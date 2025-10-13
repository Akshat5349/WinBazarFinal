import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  Future<NotificationService> init() async {
    await _requestPermission();
    await _setupLocalNotifications();
    await _setupFirebaseMessaging();
    await _getToken();
    return this;
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
        notificationCount.value++;
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
        // TODO: Send this token to your backend server
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        fcmToken.value = newToken;
        box.write('fcm_token', newToken);
        print('FCM Token refreshed: $newToken');
        // TODO: Send updated token to your backend server
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

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
    notificationCount.value = 0;
  }

  /// Clear notification count
  void clearNotificationCount() {
    notificationCount.value = 0;
  }

  /// Send token to backend server
  Future<void> sendTokenToServer(String token) async {
    try {
      // TODO: Implement API call to send token to your backend
      print('Sending token to server: $token');

      // Example implementation:
      // final response = await dio.post(
      //   '${BaseUrl.baseUrl}/api/register-device',
      //   data: {
      //     'fcm_token': token,
      //     'device_id': box.read('device_id'),
      //     'device_name': box.read('device_name'),
      //     'platform': Platform.isAndroid ? 'android' : 'ios',
      //   },
      // );
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
