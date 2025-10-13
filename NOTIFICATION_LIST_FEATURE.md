# Notification List Feature

## Overview
This document describes the implementation of the notification list feature that allows users to view all their push notifications in a dedicated screen instead of navigating to notification settings.

## Changes Made

### 1. NotificationService Updates (`lib/services/notification_service.dart`)

#### Added Observable List
- Added `notifications` observable list to store all received notifications
- Each notification contains: id, title, body, data, timestamp, isRead flag, and category

#### New Methods

**_loadNotifications()**
- Loads saved notifications from GetStorage on app initialization
- Updates the unread notification count

**_saveNotification(RemoteMessage message)**
- Saves incoming FCM notifications to storage
- Adds notification to the beginning of the list (newest first)
- Marks new notifications as unread
- Updates the notification badge count
- Persists to GetStorage for data persistence

**markAsRead(String notificationId)**
- Marks a specific notification as read
- Updates the notification badge count
- Persists changes to storage

**removeNotification(String notificationId)**
- Removes a specific notification from the list
- Updates the notification badge count
- Persists changes to storage

**clearAllNotifications()** (Updated)
- Clears all local notifications
- Clears the notifications list
- Removes from storage
- Resets notification badge count to 0

### 2. NotificationBadgeIcon Updates (`lib/widgets/notification_badge_icon.dart`)

#### Navigation Change
- **Before**: Clicking the notification bell icon navigated to `NotificationSettingsView`
- **After**: Now navigates to `NotificationListWidget` to show the list of all notifications
- Removed `clearNotificationCount()` call on tap (badge count now managed by read status)

### 3. New NotificationListWidget (`lib/widgets/notification_list_widget.dart`)

A complete notification list UI with the following features:

#### UI Components
- **AppBar**: Shows "Notifications" title with back button and "Clear All" button
- **Empty State**: Displays a friendly message when there are no notifications
- **Notification Cards**: Shows each notification with:
  - Category icon with colored background
  - Title and body text
  - Timestamp (formatted as "Just now", "5m ago", "2h ago", etc.)
  - Unread indicator (blue dot)
  - Different background for unread notifications

#### Features
- **Swipe to Delete**: Swipe left on any notification to delete it
- **Tap to Mark as Read**: Tap on a notification to mark it as read (if unread)
- **Clear All**: Confirm dialog to clear all notifications at once
- **Category-based Icons**: Different icons and colors for different notification types:
  - Result: Trophy icon (Amber)
  - Wallet: Wallet icon (Green)
  - Game: Casino icon (Primary Blue)
  - Bid: Receipt icon (Orange)
  - Announcement: Campaign icon (Purple)
  - General: Bell icon (Primary Blue)

#### Time Formatting
- Just now (< 1 minute)
- Minutes ago (< 1 hour)
- Hours ago (< 1 day)
- Days ago (< 1 week)
- Full date (> 1 week)

## User Experience Flow

1. **Receiving Notification**
   - User receives a push notification via Firebase
   - Notification is displayed in the system tray
   - Notification is automatically saved to storage
   - Badge count increases for unread notifications

2. **Viewing Notifications**
   - User taps the notification bell icon in the AppBar
   - Navigates to the notification list screen
   - Sees all notifications sorted by newest first
   - Unread notifications are highlighted

3. **Managing Notifications**
   - Tap a notification to mark it as read
   - Swipe left to delete a notification
   - Use "Clear All" button to remove all notifications
   - Badge count updates automatically

## Data Structure

### Notification Object
```dart
{
  'id': 'unique_message_id',
  'title': 'Notification Title',
  'body': 'Notification message body',
  'data': { ... }, // Custom FCM data payload
  'timestamp': '2024-01-15T10:30:00.000Z',
  'isRead': false,
  'category': 'general' // or 'result', 'wallet', 'game', 'bid', 'announcement'
}
```

## Storage

- Notifications are stored in GetStorage with key: `'notifications'`
- Data persists across app restarts
- Automatically loaded when NotificationService initializes

## Testing

To test the notification list feature:

1. Send a test notification from Firebase Console (see TESTING_NOTIFICATIONS.md)
2. Check that notification appears in the list
3. Verify the badge count increases
4. Tap the notification to mark as read
5. Verify the badge count decreases
6. Swipe to delete a notification
7. Use "Clear All" to remove all notifications
8. Close and reopen app to verify persistence

## Future Enhancements

- Add pull-to-refresh functionality
- Implement notification actions (from FCM data)
- Add notification filtering by category
- Implement search functionality
- Add notification sound/vibration preferences
- Group notifications by date
- Add batch operations (mark all as read, delete multiple)
