// Example: How to add notification badge to home_view.dart

// 1. Add import at the top of home_view.dart
import 'package:azmatka/widgets/notification_badge_icon.dart';

// 2. In the AppBar's actions, add the notification badge icon:

AppBar(
  title: Text("Royal", style: BaseStyles.whiteMedium20),
  centerTitle: false,
  elevation: 0,
  backgroundColor: AppColors.primaryColor,
  actions: [
    // Add this notification badge widget
    NotificationBadgeIcon(
      iconColor: AppColors.whiteColor,
      iconSize: 24,
    ),
    SizedBox(width: 8),
    
    // Keep your existing wallet widget
    controller.approve.value == 'true'
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.goldColor, Color(0xFFFFA000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                SystemSound.play(SystemSoundType.click);
                Get.to(() => WalletView());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Obx(
                    () => Text(
                      "₹${controller.userWallet['wallet_balance'].toString()}",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(),
    widthSpace10,
  ],
)

// That's it! The notification badge will automatically:
// ✅ Show unread notification count
// ✅ Navigate to notification settings on tap
// ✅ Clear the count when tapped
// ✅ Update in real-time when new notifications arrive
