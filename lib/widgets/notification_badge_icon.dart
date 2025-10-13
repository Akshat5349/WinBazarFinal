import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/services/notification_service.dart';
import 'package:azmatka/app/modules/home/views/notification_settings_view.dart';

class NotificationBadgeIcon extends StatelessWidget {
  final NotificationService notificationService =
      Get.find<NotificationService>();
  final Color? iconColor;
  final double? iconSize;

  NotificationBadgeIcon({
    this.iconColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notificationService.clearNotificationCount();
        Get.to(() => NotificationSettingsView());
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Icon(
              Icons.notifications_outlined,
              color: iconColor ?? AppColors.whiteColor,
              size: iconSize,
            ),
            Obx(() {
              final count = notificationService.notificationCount.value;
              if (count == 0) return SizedBox.shrink();

              return Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.errorColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.whiteColor,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      count > 9 ? '9+' : count.toString(),
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
