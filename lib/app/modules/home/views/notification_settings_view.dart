import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/services/notification_service.dart';

class NotificationSettingsView extends StatelessWidget {
  final NotificationService notificationService =
      Get.find<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('Notification Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // FCM Token Section
          _buildSectionHeader('Device Information'),
          heightSpace10,
          Obx(() => _buildInfoCard(
                'FCM Token',
                notificationService.fcmToken.value.isEmpty
                    ? 'Loading...'
                    : notificationService.fcmToken.value,
                Icons.smartphone,
              )),
          heightSpace20,

          // Notification Count
          _buildSectionHeader('Notifications'),
          heightSpace10,
          Obx(() => _buildStatCard(
                'Unread Notifications',
                notificationService.notificationCount.value.toString(),
                Icons.notifications,
                AppColors.primaryColor,
              )),
          heightSpace10,
          _buildActionButton(
            'Clear All Notifications',
            Icons.clear_all,
            () {
              notificationService.clearAllNotifications();
              Get.snackbar(
                'Success',
                'All notifications cleared',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.successColor,
                colorText: AppColors.whiteColor,
              );
            },
            AppColors.errorColor,
          ),
          heightSpace20,

          // Topic Subscriptions
          _buildSectionHeader('Topic Subscriptions'),
          heightSpace10,
          _buildTopicCard(
            'All Updates',
            'Receive all app updates and announcements',
            'all_updates',
          ),
          heightSpace10,
          _buildTopicCard(
            'Game Results',
            'Get notified when game results are declared',
            'game_results',
          ),
          heightSpace10,
          _buildTopicCard(
            'Wallet Updates',
            'Receive notifications about wallet transactions',
            'wallet_updates',
          ),
          heightSpace10,
          _buildTopicCard(
            'Promotions',
            'Get special offers and promotional notifications',
            'promotions',
          ),
          heightSpace20,

          // Test Notification
          _buildSectionHeader('Test'),
          heightSpace10,
          _buildActionButton(
            'Send Test Notification',
            Icons.notifications_active,
            () {
              _sendTestNotification();
            },
            AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              color: AppColors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(String title, String description, String topic) {
    final RxBool isSubscribed = false.obs;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Obx(() => Switch(
                value: isSubscribed.value,
                onChanged: (value) async {
                  isSubscribed.value = value;
                  if (value) {
                    await notificationService.subscribeToTopic(topic);
                    Get.snackbar(
                      'Subscribed',
                      'You will now receive $title notifications',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.successColor,
                      colorText: AppColors.whiteColor,
                      duration: Duration(seconds: 2),
                    );
                  } else {
                    await notificationService.unsubscribeFromTopic(topic);
                    Get.snackbar(
                      'Unsubscribed',
                      'You will no longer receive $title notifications',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.grey,
                      colorText: AppColors.whiteColor,
                      duration: Duration(seconds: 2),
                    );
                  }
                },
                activeColor: AppColors.primaryColor,
              )),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 20),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendTestNotification() {
    Get.snackbar(
      'Test Notification',
      'This is a test notification from your app!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
      icon: Icon(Icons.notifications, color: AppColors.whiteColor),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 16,
    );

    notificationService.notificationCount.value++;
  }
}
