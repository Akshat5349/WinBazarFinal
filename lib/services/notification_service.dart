import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:azmatka/widgets/base_url.dart';

/// Background message handler - must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
}

class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final box = GetStorage();

  // Observable for FCM token
  final fcmToken = ''.obs;

  // Observable for notification count
  final notificationCount = 0.obs;

  // Observable list for notifications
  final notifications = <Map<String, dynamic>>[].obs;

  Future<NotificationService> init() async {
    print('Initializing NotificationService...');

    // Request permission
    await _requestPermission();

    // Setup local notifications
    await _setupLocalNotifications();

    // Setup Firebase messaging handlers
    await _setupFirebaseMessaging();

    // Get FCM token
    await _getToken();

    // Load saved FCM token
    String? savedToken = box.read('fcm_token');
    if (savedToken != null) {
      fcmToken.value = savedToken;
    }

    // Load saved notifications
    _loadNotifications();

    print('NotificationService initialized successfully');
    return this;
  }

  /// Load saved notifications from storage
  void _loadNotifications() {
    try {
      final savedNotifications = box.read<List>('notifications');
      if (savedNotifications != null) {
        notifications.value = List<Map<String, dynamic>>.from(
          savedNotifications.map((n) => Map<String, dynamic>.from(n)),
        );
        // Update count of unread notifications
        notificationCount.value =
            notifications.where((n) => n['isRead'] == false).length;
      }
    } catch (e) {
      print('Error loading notifications: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  /// Setup local notifications for displaying in-app notifications
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Setup Firebase Messaging handlers
  Future<void> _setupFirebaseMessaging() async {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showLocalNotification(message);
        _saveNotification(message);
      }
    });

    // Handle notification opened app from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      _handleNotificationNavigation(message);
    });

    // Check if app was opened from a terminated state by notification
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationNavigation(initialMessage);
    }
  }

  /// Get FCM token
  Future<void> _getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        fcmToken.value = token;
        box.write('fcm_token', token);
        print('FCM Token: $token');

        // Send token to backend server
        if (box.read('token') != null) {
          await sendTokenToServer(token);
        }
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        fcmToken.value = newToken;
        box.write('fcm_token', newToken);
        print('FCM Token refreshed: $newToken');

        // Send updated token to backend server
        if (box.read('token') != null) {
          sendTokenToServer(newToken);
        }
      });
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }

  /// Show local notification when app is in foreground
  Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            styleInformation: BigTextStyleInformation(
              notification.body ?? '',
              contentTitle: notification.title,
            ),
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
    // Handle navigation based on payload
    if (response.payload != null) {
      // Parse payload and navigate accordingly
      _navigateBasedOnPayload(response.payload!);
    }
  }

  /// Handle notification navigation when app is opened
  void _handleNotificationNavigation(RemoteMessage message) {
    print('Handling notification navigation: ${message.data}');

    // Extract navigation data
    String? screen = message.data['screen'];
    String? route = message.data['route'];

    if (route != null) {
      Get.toNamed(route);
    } else if (screen != null) {
      _navigateToScreen(screen, message.data);
    }
  }

  /// Navigate based on payload string
  void _navigateBasedOnPayload(String payload) {
    // Parse payload and navigate
    // Example: {"screen": "home", "id": "123"}
    print('Navigating based on payload: $payload');
  }

  /// Navigate to specific screen based on notification data
  void _navigateToScreen(String screen, Map<String, dynamic> data) {
    switch (screen) {
      case 'home':
        Get.toNamed('/home');
        break;
      case 'wallet':
        Get.toNamed('/wallet');
        break;
      case 'game':
        String? gameId = data['game_id'];
        if (gameId != null) {
          Get.toNamed('/game', arguments: {'id': gameId});
        }
        break;
      case 'results':
        Get.toNamed('/result');
        break;
      case 'bids':
        Get.toNamed('/bid-history');
        break;
      default:
        Get.toNamed('/home');
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }

  /// Save notification to storage
  void _saveNotification(RemoteMessage message) {
    try {
      final notification = {
        'id': message.messageId ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        'title': message.notification?.title ?? 'Notification',
        'body': message.notification?.body ?? '',
        'data': message.data,
        'timestamp': DateTime.now().toIso8601String(),
        'isRead': false,
        'category': message.data['category'] ?? 'general',
      };

      notifications.insert(0, notification); // Add to beginning of list
      box.write('notifications', notifications.toList());

      // Update unread count
      notificationCount.value =
          notifications.where((n) => n['isRead'] == false).length;
    } catch (e) {
      print('Error saving notification: $e');
    }
  }

  /// Mark notification as read
  void markAsRead(String notificationId) {
    try {
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        notifications[index]['isRead'] = true;
        notifications.refresh();
        box.write('notifications', notifications.toList());

        // Update unread count
        notificationCount.value =
            notifications.where((n) => n['isRead'] == false).length;
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  /// Remove a notification
  void removeNotification(String notificationId) {
    try {
      notifications.removeWhere((n) => n['id'] == notificationId);
      box.write('notifications', notifications.toList());

      // Update unread count
      notificationCount.value =
          notifications.where((n) => n['isRead'] == false).length;
    } catch (e) {
      print('Error removing notification: $e');
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
    notifications.clear();
    box.remove('notifications');
    notificationCount.value = 0;
  }

  /// Clear notification count
  void clearNotificationCount() {
    notificationCount.value = 0;
  }

  /// Send token to backend server
  Future<void> sendTokenToServer(String token) async {
    try {
      print('Sending FCM token to server...');

      // Get device information
      final deviceInfo = DeviceInfoPlugin();
      String? deviceId;
      String? deviceName;
      String platform = 'unknown';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
        platform = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
        deviceName = '${iosInfo.model}';
        platform = 'ios';
      }

      // Get user token from storage
      final userToken = box.read('token');
      if (userToken == null) {
        print('⚠️ User not logged in, skipping token registration');
        return;
      }

      // Prepare request body
      final body = {
        'fcm_token': token,
        'device_id': deviceId ?? 'unknown',
        'device_name': deviceName ?? 'Unknown Device',
        'platform': platform,
      };

      print('Request body: $body');

      // Send to backend
      final response = await http.post(
        Uri.parse('${BASE_URL}/user/register-fcm-token'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(
            '✅ FCM token registered successfully: ${responseData['message']}');
      } else {
        print('❌ Failed to register FCM token: ${response.body}');
      }
    } catch (e) {
      print('❌ Error sending token to server: $e');
    }
  }

  /// Remove FCM token from backend server (call on logout)
  Future<void> removeTokenFromServer() async {
    try {
      print('Removing FCM token from server...');

      // Get user token from storage
      final userToken = box.read('token');
      if (userToken == null) {
        print('⚠️ User not logged in, skipping token removal');
        return;
      }

      // Send to backend
      final response = await http.post(
        Uri.parse('${BASE_URL}/user/remove-fcm-token'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('✅ FCM token removed successfully: ${responseData['message']}');

        // Clear local storage
        box.remove('fcm_token');
        fcmToken.value = '';
      } else {
        print('❌ Failed to remove FCM token: ${response.body}');
      }
    } catch (e) {
      print('❌ Error removing token from server: $e');
    }
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
