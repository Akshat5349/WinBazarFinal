# Push Notifications Implementation Guide

## Overview
Push notifications have been successfully integrated into your Flutter app using Firebase Cloud Messaging (FCM). This allows you to send notifications to users even when the app is closed.

## Features Implemented

### 1. **Notification Service** (`lib/services/notification_service.dart`)
- ✅ Firebase Cloud Messaging integration
- ✅ Local notifications for foreground messages
- ✅ Background and terminated state handling
- ✅ FCM token management with auto-refresh
- ✅ Topic-based subscriptions
- ✅ Custom notification sounds and vibration
- ✅ Notification click handling with deep linking
- ✅ Notification count tracking

### 2. **Notification Settings UI** (`lib/app/modules/home/views/notification_settings_view.dart`)
- ✅ Display FCM token
- ✅ Show notification count
- ✅ Clear all notifications
- ✅ Topic subscription toggles:
  - All Updates
  - Game Results
  - Wallet Updates
  - Promotions
- ✅ Test notification button

### 3. **Notification Badge Widget** (`lib/widgets/notification_badge_icon.dart`)
- ✅ Shows unread notification count
- ✅ Red badge with count indicator
- ✅ Clickable to open notification settings
- ✅ Auto-clears count on click

## How to Use

### For Users

1. **Enable Notifications**
   - Open the app
   - Go to Notification Settings (tap bell icon)
   - Allow notification permissions when prompted

2. **Subscribe to Topics**
   - Open Notification Settings
   - Toggle switches for topics you want:
     - All Updates: General app announcements
     - Game Results: Get notified of game outcomes
     - Wallet Updates: Transaction notifications
     - Promotions: Special offers

3. **View Notifications**
   - Tap on notifications to open relevant screens
   - Badge shows unread count
   - Clear all from settings

### For Developers

#### Add Notification Badge to AppBar

```dart
import 'package:azmatka/widgets/notification_badge_icon.dart';

AppBar(
  title: Text('Home'),
  actions: [
    NotificationBadgeIcon(), // Adds notification icon with badge
    SizedBox(width: 8),
  ],
)
```

#### Send Notification from Backend

```javascript
// Node.js example
const admin = require('firebase-admin');

// Send to specific user
await admin.messaging().send({
  token: userFCMToken,
  notification: {
    title: 'Game Result Out!',
    body: 'Your bid won ₹5000'
  },
  data: {
    screen: 'results',
    game_id: '123'
  }
});

// Send to topic
await admin.messaging().send({
  topic: 'game_results',
  notification: {
    title: 'Results Declared',
    body: 'Check latest game results'
  },
  data: {
    screen: 'results'
  }
});
```

#### Custom Navigation

The notification service supports custom navigation based on payload:

```json
{
  "data": {
    "screen": "home",        // home, wallet, game, results, bids
    "route": "/custom-route", // or use custom route
    "game_id": "123",         // additional parameters
    "market_id": "456"
  }
}
```

**Supported Screens:**
- `home` → Navigate to home screen
- `wallet` → Navigate to wallet
- `game` → Navigate to game (requires `game_id`)
- `results` → Navigate to results
- `bids` → Navigate to bid history

#### Access Notification Service

```dart
import 'package:azmatka/services/notification_service.dart';

// Get notification service
final notificationService = Get.find<NotificationService>();

// Get FCM token
String token = notificationService.fcmToken.value;

// Subscribe to topic
await notificationService.subscribeToTopic('game_results');

// Unsubscribe from topic
await notificationService.unsubscribeFromTopic('promotions');

// Clear all notifications
await notificationService.clearAllNotifications();

// Get notification count
int count = notificationService.notificationCount.value;
```

## Setup Required

⚠️ **Important:** Before notifications work, you need to:

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Create a new project or use existing one

2. **Download Configuration Files**
   - For Android: Download `google-services.json`
   - Place in: `android/app/google-services.json`

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Test**
   - Run the app
   - Check console for FCM token
   - Send test notification from Firebase Console

📖 See **FIREBASE_SETUP.md** for detailed step-by-step instructions.

## Notification Types

### 1. Foreground Notifications
When app is open:
- Shows local notification at top
- Updates notification count badge
- Custom sound and vibration

### 2. Background Notifications
When app is in background:
- System tray notification
- Tap to open app
- Navigates to specified screen

### 3. Terminated State
When app is closed:
- Receives notification
- Opens app on tap
- Processes navigation data

## Backend Integration

### Store FCM Tokens

When user logs in or registers, send FCM token to your backend:

```dart
// Already implemented in notification_service.dart
notificationService.sendTokenToServer(token);
```

Update your API endpoint in `notification_service.dart`:

```dart
Future<void> sendTokenToServer(String token) async {
  final response = await dio.post(
    '${BaseUrl.baseUrl}/api/register-device',
    data: {
      'fcm_token': token,
      'device_id': box.read('device_id'),
      'user_id': box.read('user_id'), // Add user ID
      'platform': Platform.isAndroid ? 'android' : 'ios',
    },
  );
}
```

### Send Notifications

Create backend endpoints to send notifications:

**When game result is declared:**
```javascript
// Send to all users subscribed to game_results topic
await sendToTopic('game_results', {
  title: 'Results Out!',
  body: 'Mumbai Market results declared',
  data: { screen: 'results', market_id: '123' }
});
```

**When user wins:**
```javascript
// Send to specific user
await sendToUser(userFCMToken, {
  title: 'Congratulations! 🎉',
  body: 'You won ₹5000 in Mumbai Market',
  data: { screen: 'wallet' }
});
```

**For promotions:**
```javascript
// Send to promotions topic
await sendToTopic('promotions', {
  title: 'Special Offer! 🎁',
  body: 'Get 10% bonus on wallet recharge',
  data: { screen: 'wallet' }
});
```

## Testing Notifications

### 1. From Firebase Console
1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Enter title and body
4. Click "Send test message"
5. Paste FCM token from app
6. Click "Test"

### 2. Using cURL
```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "USER_FCM_TOKEN",
    "notification": {
      "title": "Test Notification",
      "body": "This is a test"
    },
    "data": {
      "screen": "home"
    }
  }'
```

### 3. From App
Use the built-in test notification button in Notification Settings.

## Troubleshooting

### No FCM Token?
- Check internet connection
- Verify Firebase is initialized
- Check `google-services.json` is in place
- Run `flutter clean && flutter pub get`

### Notifications Not Showing?
- Check notification permissions are granted
- Verify Cloud Messaging API is enabled in Firebase
- Test from Firebase Console first
- Check device Do Not Disturb is off

### Background Notifications Not Working?
- Ensure `firebaseMessagingBackgroundHandler` is top-level function
- Check AndroidManifest.xml has FCM service
- Verify app is in background (not terminated during test)

### Navigation Not Working?
- Check payload data structure
- Verify routes are defined in app_pages.dart
- Test with simple screen names first

## Best Practices

✅ **DO:**
- Send relevant, timely notifications
- Use appropriate topics for categorization
- Test thoroughly before production
- Handle all notification states (foreground, background, terminated)
- Update FCM tokens on refresh
- Provide clear notification settings

❌ **DON'T:**
- Spam users with too many notifications
- Send notifications during sleep hours
- Use notifications for non-urgent information
- Forget to handle notification clicks
- Ignore token refresh events

## Security

- ⚠️ Never expose Firebase Server Key in client code
- ⚠️ Store Server Key securely on backend
- ⚠️ Validate all notification payloads
- ⚠️ Use HTTPS for all API calls
- ⚠️ Implement rate limiting on backend

## Support

For issues or questions:
1. Check FIREBASE_SETUP.md for setup instructions
2. Review notification_service.dart for implementation details
3. Test with Firebase Console first
4. Check Firebase Console logs for errors

## Quick Start Checklist

- [ ] Create Firebase project
- [ ] Download google-services.json
- [ ] Place in android/app/ directory
- [ ] Run flutter pub get
- [ ] Build and install app
- [ ] Grant notification permissions
- [ ] Check FCM token in Notification Settings
- [ ] Send test notification from Firebase Console
- [ ] Verify notification received
- [ ] Test notification click navigation
- [ ] Update backend to store/send FCM tokens
- [ ] Test from backend
- [ ] Subscribe to topics
- [ ] Test topic notifications

🎉 **You're all set!** Notifications are ready to use once Firebase is configured.
