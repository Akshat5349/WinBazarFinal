import 'package:azmatka/constants/values.dart';

class WinRateView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: Text('Win Rate'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          design(title: 'Single Digit', price: '10 - 95'),
          design(title: 'Jodi Digit', price: '10 - 950'),
          design(title: 'Single Pana', price: '10 - 1400'),
          design(title: 'Double Pana', price: '10 - 3000'),
          design(title: 'Tripple Pana', price: '10 - 7000'),
          design(title: 'Half Sangam', price: '10 - 10000'),
          design(title: 'Full Sangam', price: '10 - 100000'),
        ],
      ),
    );
  }

  Widget design({required title, required price}) {
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    IconPath.hand,
                    height: 25,
                    fit: BoxFit.fill,
                  ),
                  widthSpace5,
                  Text(title, style: BaseStyles.primaryMedium18),
                ],
              ),
              Text(price, style: BaseStyles.primaryMedium18)
            ],
          ),
        ),
        Divider(
          color: AppColors.primaryAccentColor,
          thickness: 2,
        )
      ],
    );
  }
}
