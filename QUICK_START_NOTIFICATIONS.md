# 🚀 Push Notifications - Quick Start Guide

## ✅ Implementation Complete!

Push notifications have been successfully integrated into your app. Here's everything you need to get started.

---

## 📦 What's Included

### 1. Core Service
- **NotificationService** - Handles all FCM operations
- Auto-initializes on app start
- Manages tokens, subscriptions, and navigation

### 2. UI Components
- **Notification Settings Page** - Full-featured settings interface
- **Notification Badge Widget** - Shows unread count on any icon

### 3. Documentation
- Firebase setup guide
- Backend integration examples
- Troubleshooting tips

---

## ⚡ 5-Minute Setup

### Step 1: Firebase Project (2 min)

1. Go to: https://console.firebase.google.com/
2. Click "Add project"
3. Enter project name: "Royal Matka" (or your app name)
4. Disable Google Analytics (optional)
5. Click "Create project"

### Step 2: Add Android App (2 min)

1. In Firebase Console, click "Add app" → Android icon
2. Enter package name: **`com.loki.royal_app`**
3. Click "Register app"
4. Download **`google-services.json`**
5. Place file in: **`android/app/google-services.json`**
6. Click "Next" through remaining steps

### Step 3: Build & Run (1 min)

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎯 Usage Guide

### Access Notification Service Anywhere

```dart
import 'package:azmatka/services/notification_service.dart';

// Get the service
final notificationService = Get.find<NotificationService>();

// Get FCM token
String token = notificationService.fcmToken.value;

// Subscribe to topics
await notificationService.subscribeToTopic('game_results');

// Get notification count
int count = notificationService.notificationCount.value;
```

### Add Notification Badge to AppBar

```dart
import 'package:azmatka/widgets/notification_badge_icon.dart';

AppBar(
  title: Text('Home'),
  actions: [
    NotificationBadgeIcon(), // Shows unread count with badge
    SizedBox(width: 8),
  ],
)
```

### Navigate to Notification Settings

```dart
import 'package:azmatka/app/modules/home/views/notification_settings_view.dart';

// Navigate to settings
Get.to(() => NotificationSettingsView());
```

---

## 📤 Sending Notifications

### Option 1: Firebase Console (For Testing)

1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Fill in title and body
4. Click "Send test message"
5. Paste FCM token from app
6. Click "Test"

### Option 2: From Backend

#### Get FCM Token from User
When user logs in, their FCM token is automatically sent to your backend (you need to implement the endpoint).

Update `notification_service.dart` line ~133:

```dart
Future<void> sendTokenToServer(String token) async {
  final response = await dio.post(
    '${BaseUrl.baseUrl}/api/register-device', // Your endpoint
    data: {
      'fcm_token': token,
      'user_id': box.read('user_id'),
      'device_id': box.read('device_id'),
      'platform': 'android',
    },
  );
}
```

#### Send Notification (Node.js Example)

```javascript
const admin = require('firebase-admin');

// Initialize once
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Send to specific user
await admin.messaging().send({
  token: userFCMToken,
  notification: {
    title: 'You Won! 🎉',
    body: 'Check your winnings now'
  },
  data: {
    screen: 'wallet' // Navigates to wallet on click
  }
});

// Send to all users subscribed to topic
await admin.messaging().send({
  topic: 'game_results',
  notification: {
    title: 'Results Out! 🎲',
    body: 'Mumbai market results declared'
  },
  data: {
    screen: 'results'
  }
});
```

---

## 🎨 Navigation Options

When sending notifications, use these values in `data.screen`:

| Screen Value | Destination |
|-------------|-------------|
| `home` | Home screen |
| `wallet` | Wallet page |
| `game` | Game page (requires `game_id` in data) |
| `results` | Results page |
| `bids` | Bid history |

Example payload:
```json
{
  "notification": {
    "title": "Game Result",
    "body": "Check your game result"
  },
  "data": {
    "screen": "results",
    "game_id": "123"
  }
}
```

---

## 🔔 Notification Topics

Users can subscribe to these topics:

| Topic | Purpose |
|-------|---------|
| `all_updates` | General app updates |
| `game_results` | Game result announcements |
| `wallet_updates` | Transaction notifications |
| `promotions` | Special offers |

Subscribe in code:
```dart
await notificationService.subscribeToTopic('game_results');
```

Or let users toggle in Notification Settings UI.

---

## 🧪 Testing Checklist

### Before Testing
- [ ] `google-services.json` is in `android/app/`
- [ ] App builds without errors
- [ ] Notification permission granted

### Foreground (App Open)
- [ ] Notification shows at top of screen
- [ ] Badge count increases
- [ ] Sound/vibration works
- [ ] Tapping navigates correctly

### Background (App Minimized)
- [ ] System notification appears
- [ ] Tapping opens app
- [ ] Navigates to correct screen

### Terminated (App Closed)
- [ ] Notification received
- [ ] Opens app on tap
- [ ] Navigation works

---

## 🎯 Common Use Cases

### 1. Game Result Declared
```javascript
// Send to all users
await admin.messaging().send({
  topic: 'game_results',
  notification: {
    title: '🎲 Results Declared',
    body: 'Mumbai Market results are out!'
  },
  data: { screen: 'results', market_id: '123' }
});
```

### 2. User Wins
```javascript
// Send to specific winner
await admin.messaging().send({
  token: winnerFCMToken,
  notification: {
    title: '🎉 Congratulations!',
    body: 'You won ₹5000 in Mumbai Market'
  },
  data: { screen: 'wallet' }
});
```

### 3. Wallet Credited
```javascript
await admin.messaging().send({
  token: userFCMToken,
  notification: {
    title: '💰 Wallet Updated',
    body: 'Your account credited with ₹1000'
  },
  data: { screen: 'wallet' }
});
```

### 4. Promotional Offer
```javascript
await admin.messaging().send({
  topic: 'promotions',
  notification: {
    title: '🎁 Special Offer',
    body: 'Get 10% bonus on recharge today!'
  },
  data: { screen: 'wallet' }
});
```

---

## 🐛 Troubleshooting

### No FCM Token?
```
✓ Check internet connection
✓ Verify google-services.json location
✓ Run: flutter clean && flutter pub get
✓ Check console logs for errors
```

### Notifications Not Showing?
```
✓ Grant notification permissions
✓ Check Do Not Disturb is off
✓ Test from Firebase Console first
✓ Enable Cloud Messaging API in Firebase
```

### Navigation Not Working?
```
✓ Check payload structure
✓ Verify screen names are correct
✓ Test with simple screens first
✓ Check console for navigation errors
```

---

## 📚 Documentation Files

- **`FIREBASE_SETUP.md`** - Detailed Firebase configuration
- **`NOTIFICATIONS_GUIDE.md`** - Complete usage guide
- **`PUSH_NOTIFICATIONS_SUMMARY.md`** - Implementation overview
- **`NOTIFICATION_INTEGRATION_EXAMPLE.dart`** - Code examples

---

## 🎓 Next Steps

1. ✅ Add `google-services.json` (if not done)
2. ✅ Build and test the app
3. ✅ Send test notification from Firebase Console
4. ✅ Add notification badge to your UI
5. ✅ Implement backend token storage
6. ✅ Create backend notification sending logic
7. ✅ Test all notification scenarios

---

## 💡 Pro Tips

✨ **Subscribe users on first login** - Get them engaged immediately
✨ **Send timely notifications** - Right after game results
✨ **Personalize messages** - Use user's name when possible
✨ **Don't spam** - Quality over quantity
✨ **Test thoroughly** - All states (foreground, background, terminated)
✨ **Track metrics** - Monitor open rates and engagement

---

## 🆘 Need Help?

1. Check the documentation files in your project
2. Test with Firebase Console before backend
3. Check Firebase Console logs
4. Verify google-services.json is correct
5. Review notification_service.dart implementation

---

## ✅ Status

**Implementation:** ✅ Complete
**Configuration:** ⏳ Needs google-services.json
**Testing:** ⏳ Needs Firebase setup
**Backend:** ⏳ Needs token storage endpoint

---

**Estimated Time to Complete:** ~5 minutes
**Difficulty Level:** Easy 🟢

🎉 **Ready to go! Just add Firebase configuration and test!**

---

Made with ❤️ for Royal Matka App
