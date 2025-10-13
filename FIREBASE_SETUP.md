# Firebase Setup Instructions

## Prerequisites
1. Create a Firebase project at https://console.firebase.google.com/
2. Add your Android app to the Firebase project
3. Download the `google-services.json` file

## Setup Steps

### 1. Android Configuration

1. **Download google-services.json**
   - Go to Firebase Console > Project Settings > General
   - Under "Your apps", select your Android app
   - Click "Download google-services.json"
   
2. **Place the file**
   - Copy `google-services.json` to: `android/app/google-services.json`
   
3. **Package Name**
   - Ensure your package name in Firebase matches: `com.loki.royal_app`

### 2. iOS Configuration (Optional)

1. **Download GoogleService-Info.plist**
   - Go to Firebase Console > Project Settings > General
   - Under "Your apps", select your iOS app (or add one)
   - Click "Download GoogleService-Info.plist"
   
2. **Place the file**
   - Copy `GoogleService-Info.plist` to: `ios/Runner/GoogleService-Info.plist`
   - Open the project in Xcode and add the file to the Runner target

### 3. Install Dependencies

Run the following command in your terminal:

```bash
flutter pub get
```

### 4. Enable Firebase Cloud Messaging

1. Go to Firebase Console > Cloud Messaging
2. Enable Cloud Messaging API (if not already enabled)

### 5. Test Notifications

#### Send Test Notification from Firebase Console:

1. Go to Firebase Console > Cloud Messaging
2. Click "Send your first message"
3. Enter notification title and text
4. Click "Send test message"
5. Enter your FCM token (visible in the app's Notification Settings)
6. Click "Test"

#### Send from Backend (Example):

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "DEVICE_FCM_TOKEN",
    "notification": {
      "title": "Game Result",
      "body": "Check your latest game results!"
    },
    "data": {
      "screen": "results",
      "game_id": "123"
    }
  }'
```

### 6. Backend Integration

To send notifications from your backend, you need to:

1. Get your Server Key from Firebase Console > Project Settings > Cloud Messaging
2. Store user FCM tokens in your database when they register/login
3. Use the Firebase Admin SDK or HTTP API to send notifications

#### Example Backend API Endpoint:

```javascript
// Node.js example using firebase-admin
const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

async function sendNotification(fcmToken, title, body, data) {
  const message = {
    notification: {
      title: title,
      body: body
    },
    data: data,
    token: fcmToken
  };

  try {
    const response = await admin.messaging().send(message);
    console.log('Successfully sent message:', response);
  } catch (error) {
    console.log('Error sending message:', error);
  }
}
```

### 7. Update Backend to Store FCM Tokens

Add an endpoint in your backend to receive and store FCM tokens:

```javascript
// Example endpoint
POST /api/register-device
{
  "fcm_token": "user_fcm_token_here",
  "device_id": "unique_device_id",
  "device_name": "device_name",
  "platform": "android" // or "ios"
}
```

Update the `sendTokenToServer` method in `notification_service.dart` with your API endpoint.

### 8. Notification Payload Structure

Use this structure for custom navigation:

```json
{
  "notification": {
    "title": "Notification Title",
    "body": "Notification Body"
  },
  "data": {
    "screen": "home|wallet|game|results|bids",
    "route": "/specific-route",
    "game_id": "123",
    "custom_param": "value"
  }
}
```

### 9. Topic-based Notifications

Subscribe users to topics for targeted notifications:

```dart
// In your app
notificationService.subscribeToTopic('all_updates');
notificationService.subscribeToTopic('game_results');
```

Then send to topics from backend:

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "/topics/game_results",
    "notification": {
      "title": "Game Results Out!",
      "body": "Check the latest game results now"
    }
  }'
```

## Troubleshooting

### Notifications not working?

1. **Check google-services.json is in the correct location**
2. **Verify package name matches in Firebase Console**
3. **Check Android 13+ permissions** - Make sure POST_NOTIFICATIONS permission is requested
4. **Enable Cloud Messaging API** in Firebase Console
5. **Check FCM token** - Print it in logs to verify it's being generated
6. **Test from Firebase Console** first before testing from your backend

### Common Issues:

- **"FirebaseApp not initialized"**: Make sure `Firebase.initializeApp()` is called in main()
- **No FCM token**: Check internet connection and Firebase configuration
- **Notifications not showing on Android**: Create notification channel (already done in code)
- **Background notifications not working**: Ensure `firebaseMessagingBackgroundHandler` is a top-level function

## Features Implemented

✅ Firebase Cloud Messaging integration
✅ Local notifications for foreground messages
✅ Background and terminated state handling
✅ Custom notification sounds and vibration
✅ Notification click handling with deep linking
✅ Topic-based subscriptions
✅ FCM token management
✅ Notification settings UI
✅ Test notification functionality
✅ Notification count tracking

## Next Steps

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory
3. Run `flutter clean && flutter pub get`
4. Build and test the app
5. Update backend to send/receive FCM tokens
6. Send test notifications from Firebase Console
7. Implement backend notification sending logic

## Notification Best Practices

- Send timely, relevant notifications
- Don't spam users with too many notifications
- Provide clear, actionable content
- Allow users to customize notification preferences
- Test notifications thoroughly on both Android and iOS
- Handle notification clicks properly with deep linking
- Store and update FCM tokens when they refresh
