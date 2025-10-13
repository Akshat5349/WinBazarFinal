# FCM Token Registration - Integration Complete ✅

## What Was Added

### NotificationService Updates (`lib/services/notification_service.dart`)

1. **New Imports**:
   - `dart:io` - For Platform detection
   - `device_info_plus` - For device information
   - `http` - For API calls
   - `dart:convert` - For JSON encoding
   - `base_url.dart` - For backend URL

2. **sendTokenToServer() Method**:
   - Gets device information (Android/iOS)
   - Sends FCM token to backend API
   - Includes device ID, name, and platform
   - Requires user to be logged in (JWT token)
   - Endpoint: `POST /api/register-fcm-token`

3. **removeTokenFromServer() Method**:
   - Removes FCM token from backend on logout
   - Clears local token storage
   - Endpoint: `POST /api/remove-fcm-token`

4. **Updated _getToken() Method**:
   - Automatically calls `sendTokenToServer()` after getting FCM token
   - Sends updated token on token refresh
   - Only sends if user is logged in

## How It Works

### Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│ 1. User Opens App                                           │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. NotificationService.init() is called                     │
│    - Requests notification permission                       │
│    - Gets FCM token from Firebase                          │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. _getToken() gets FCM token                               │
│    Token: "eXaMpLe_FcM_ToKeN_123..."                       │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Check if user is logged in                               │
│    box.read('token') != null?                               │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼ YES
┌─────────────────────────────────────────────────────────────┐
│ 5. sendTokenToServer(token) is called                       │
│    - Gets device info (Android/iOS)                         │
│    - Prepares request body with:                            │
│      • fcm_token                                            │
│      • device_id                                            │
│      • device_name                                          │
│      • platform                                             │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. POST to backend API                                      │
│    URL: https://royalmatk.store/app/register-fcm-token     │
│    Headers:                                                 │
│      - Authorization: Bearer <jwt_token>                    │
│      - Content-Type: application/json                       │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 7. Backend receives and stores token in User collection    │
│    User.fcm_token = "eXaMpLe..."                           │
│    User.device_id = "android_device_123"                    │
│    User.platform = "android"                                │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 8. Backend responds with success                            │
│    {                                                        │
│      "success": true,                                       │
│      "message": "FCM token registered successfully"         │
│    }                                                        │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│ 9. ✅ Token Registration Complete!                          │
│    User will now receive push notifications                │
└─────────────────────────────────────────────────────────────┘
```

## Usage Examples

### Automatic Registration (Already Implemented)
The token is automatically sent to the backend when:
1. User opens the app (if logged in)
2. User logs in
3. FCM token refreshes

No additional code needed - it's automatic!

### Manual Registration (Optional)
If you want to manually trigger token registration:

```dart
// Get NotificationService instance
final notificationService = Get.find<NotificationService>();

// Send token to backend
await notificationService.sendTokenToServer(
  notificationService.fcmToken.value
);
```

### On Logout
Call this method when user logs out to remove the token from backend:

```dart
// In your logout function
final notificationService = Get.find<NotificationService>();
await notificationService.removeTokenFromServer();
```

## Integration Points

### 1. Login Flow
After successful login, the FCM token is automatically sent to the backend.

**No changes needed** - already handled by the token refresh listener.

### 2. Logout Flow
Add this to your logout controller/function:

```dart
// Example: In your auth controller
static Future<void> logout() async {
  try {
    // Remove FCM token from backend
    final notificationService = Get.find<NotificationService>();
    await notificationService.removeTokenFromServer();
    
    // Clear local storage
    box.erase();
    
    // Navigate to login
    Get.offAllNamed('/login');
  } catch (e) {
    print('Error during logout: $e');
  }
}
```

### 3. Token Refresh
Already handled automatically by the `onTokenRefresh` listener.

## API Endpoints

### Register FCM Token
```
POST https://royalmatk.store/app/register-fcm-token

Headers:
  Authorization: Bearer <jwt_token>
  Content-Type: application/json
  Accept: application/json

Body:
{
  "fcm_token": "fcm_device_token_here",
  "device_id": "unique_device_identifier",
  "device_name": "Samsung Galaxy S21",
  "platform": "android"
}

Response (Success):
{
  "success": true,
  "message": "FCM token registered successfully"
}

Response (Error):
{
  "success": false,
  "message": "Error message here"
}
```

### Remove FCM Token
```
POST https://royalmatk.store/app/remove-fcm-token

Headers:
  Authorization: Bearer <jwt_token>
  Content-Type: application/json
  Accept: application/json

Response (Success):
{
  "success": true,
  "message": "FCM token removed successfully"
}
```

## Testing

### Test Token Registration

1. **Login to the app**
2. **Check console logs** - Look for:
   ```
   Sending FCM token to server...
   Request body: {fcm_token: ..., device_id: ..., device_name: ..., platform: android}
   Response status: 200
   ✅ FCM token registered successfully: FCM token registered successfully
   ```

3. **Check backend logs** - Should see:
   ```
   ✅ FCM token registered for user 1234567890
   ```

4. **Check MongoDB** - User document should have:
   ```javascript
   {
     fcm_token: "eXaMpLe_token...",
     device_id: "android_device_123",
     device_name: "Samsung Galaxy S21",
     platform: "android"
   }
   ```

### Test Notification Reception

1. **Login to admin panel**
2. **Send a test notification**
3. **Check Flutter app** - Notification should appear!

### Test Token Removal

1. **Logout from the app**
2. **Check console logs** - Look for:
   ```
   Removing FCM token from server...
   ✅ FCM token removed successfully
   ```

3. **Check MongoDB** - User document should have:
   ```javascript
   {
     fcm_token: null
   }
   ```

## Troubleshooting

### Issue: "User not logged in, skipping token registration"
**Reason**: User hasn't logged in yet, so no JWT token available.
**Solution**: This is normal behavior. Token will be sent after login.

### Issue: "Failed to register FCM token: 401"
**Reason**: JWT token is invalid or expired.
**Solution**: 
- Check if user token is valid in storage
- Re-login to get a fresh token
- Check backend JWT verification

### Issue: "Failed to register FCM token: 500"
**Reason**: Backend error.
**Solution**:
- Check backend logs for errors
- Verify backend is running
- Check database connection
- Ensure User model has fcm_token fields

### Issue: Token not appearing in database
**Solution**:
1. Check if backend is running
2. Verify API endpoint URL is correct
3. Check network connectivity
4. Review backend logs
5. Ensure User model migration is complete

### Issue: Notifications not received
**Solution**:
1. Verify token is in database
2. Check notification permissions in app
3. Test with Firebase Console first
4. Check backend notification sending logic
5. Review Firebase service account key

## Console Log Messages

### Success Messages
- ✅ `FCM token registered successfully`
- ✅ `FCM token removed successfully`

### Info Messages
- ⚠️ `User not logged in, skipping token registration`
- ℹ️ `Sending FCM token to server...`
- ℹ️ `Removing FCM token from server...`

### Error Messages
- ❌ `Failed to register FCM token: <error>`
- ❌ `Error sending token to server: <error>`
- ❌ `Error removing token from server: <error>`

## Backend Integration Status

### Backend Setup Required
Before testing, ensure the backend has:

1. ✅ Firebase Admin SDK installed (`npm install`)
2. ✅ Firebase service account key in `config/firebase-adminsdk.json`
3. ✅ Backend server running (`npm run dev`)
4. ✅ Firebase initialized successfully
5. ✅ API endpoints available:
   - `POST /api/register-fcm-token`
   - `POST /api/remove-fcm-token`

### Verification
Check backend logs for:
```
✅ Firebase Admin SDK initialized successfully
```

If you see:
```
⚠️ Firebase service account file not found
```
Then add the `firebase-adminsdk.json` file to `config/` folder.

## Next Steps

1. ✅ **Token registration** - Already implemented and automatic
2. ✅ **Token removal** - Implemented, needs to be called on logout
3. 🔄 **Add to logout flow** - Integrate `removeTokenFromServer()` in your auth controller
4. 🧪 **Test end-to-end** - Login → Send notification → Receive in app
5. 📊 **Monitor delivery** - Check Firebase Console for delivery stats

## Files Modified

- ✅ `lib/services/notification_service.dart` - Added token registration methods

## Files to Update (Optional)

- 📝 Your auth/login controller - To call `removeTokenFromServer()` on logout

## Production Checklist

- [x] Token registration implemented
- [x] Token removal implemented
- [x] Device info collection
- [x] Error handling
- [x] Logging for debugging
- [ ] Add to logout flow
- [ ] Test on real devices (Android & iOS)
- [ ] Monitor token registration rates
- [ ] Set up token cleanup job (backend)

---

**Status**: ✅ Ready to Test
**Next Action**: Test login → verify token in database → send test notification
