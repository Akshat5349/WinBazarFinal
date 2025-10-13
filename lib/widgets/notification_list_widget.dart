import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/services/notification_service.dart';
import 'package:intl/intl.dart';

class NotificationListWidget extends StatelessWidget {
  final NotificationService notificationService =
      Get.find<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(() {
            if (notificationService.notifications.isEmpty) {
              return SizedBox.shrink();
            }
            return TextButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Clear All Notifications'),
                    content: Text(
                        'Are you sure you want to clear all notifications?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          notificationService.clearAllNotifications();
                          Get.back();
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(color: AppColors.errorColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (notificationService.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 80,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 16),
                Text(
                  'No notifications yet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You\'ll see notifications here when you receive them',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: notificationService.notifications.length,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final notification = notificationService.notifications[index];
            final isRead = notification['isRead'] ?? false;
            final timestamp = DateTime.parse(notification['timestamp']);
            final category = notification['category'] ?? 'general';

            return Dismissible(
              key: Key(notification['id']),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: AppColors.errorColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete,
                  color: AppColors.whiteColor,
                ),
              ),
              onDismissed: (direction) {
                notificationService.removeNotification(notification['id']);
                Get.snackbar(
                  'Notification Removed',
                  'The notification has been deleted',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black87,
                  colorText: AppColors.whiteColor,
                );
              },
              child: InkWell(
                onTap: () {
                  if (!isRead) {
                    notificationService.markAsRead(notification['id']);
                  }
                  // Handle navigation based on notification data if needed
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isRead
                        ? AppColors.whiteColor
                        : AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isRead
                          ? Colors.grey[300]!
                          : AppColors.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Icon
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _getIconColor(category).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getIcon(category),
                          color: _getIconColor(category),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      // Notification Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notification['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isRead
                                          ? FontWeight.w600
                                          : FontWeight.bold,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                                if (!isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              notification['body'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _formatTime(timestamp),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// Format timestamp to human-readable string
  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(timestamp);
    }
  }

  /// Get icon based on category
  IconData _getIcon(String category) {
    switch (category) {
      case 'result':
        return Icons.emoji_events;
      case 'wallet':
        return Icons.account_balance_wallet;
      case 'game':
        return Icons.casino;
      case 'bid':
        return Icons.receipt_long;
      case 'announcement':
        return Icons.campaign;
      default:
        return Icons.notifications;
    }
  }

  /// Get icon color based on category
  Color _getIconColor(String category) {
    switch (category) {
      case 'result':
        return Colors.amber;
      case 'wallet':
        return Colors.green;
      case 'game':
        return AppColors.primaryColor;
      case 'bid':
        return Colors.orange;
      case 'announcement':
        return Colors.purple;
      default:
        return AppColors.primaryColor;
    }
  }
}
