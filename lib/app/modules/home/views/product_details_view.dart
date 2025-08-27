import 'package:azmatka/app/modules/home/controllers/product_details_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:azmatka/widgets/image_loader.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductDetailsController());
    var item = Get.arguments['item'];
    var save = double.parse(item['price'].toString()) -
        double.parse(item['offer_price'].toString());
    var discount = (save / double.parse(item['price'].toString())) * 100;
    String discountPercent = discount.toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name'].toString()),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: Get.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: networkImage(
                          url: '${BASE_URL_image}${item['image']}',
                          width: Get.width,
                          height: Get.width),
                    ),
                    Positioned(
                        top: 2,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            ' $discountPercent% Off',
                            maxLines: 1,
                            style:
                                BaseStyles.whiteMedium16.copyWith(fontSize: 14),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(item['name'].toString(), style: BaseStyles.blackNormal18),
              SizedBox(height: 5),
              Row(
                children: [
                  Text('₹${item['price']}',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.lineThrough)),
                  SizedBox(width: 10),
                  Text(
                    '₹${item['offer_price']}',
                    style: BaseStyles.blackNormal18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    ' ${(((double.parse(item['price'].toString()) - double.parse(item['offer_price'].toString())) / double.parse(item['price'].toString())) * 100).toStringAsFixed(0)}% Off',
                    maxLines: 1,
                    style: BaseStyles.greenMedium14,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'You save ₹ ${double.parse(item['price'].toString()) - double.parse(item['offer_price'].toString())} ',
                        maxLines: 1,
                        style: BaseStyles.blackNormal12,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('QTY  : ', style: BaseStyles.blackMedium16),
                      IconButton(
                          onPressed: () {
                            if (controller.count.value != 1) {
                              controller.decrement();
                            }
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 25,
                          )),
                      Text(controller.count.value.toString(),
                          style: BaseStyles.blackMedium16),
                      IconButton(
                          onPressed: () {
                            controller.increment();
                          },
                          icon: Icon(Icons.add)),
                      SizedBox(width: 10)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgets().buildMaterialBtnwithWidth(
                        color: AppColors.primaryColor,
                        width: Get.width * 0.40,
                        text: 'Buy Now',
                        fontSize: 20,
                        onPressed: () {}),
                    CustomWidgets().buildMaterialBtnwithWidth(
                        color: AppColors.primaryColor,
                        width: Get.width * 0.40,
                        text: 'Add to Cart',
                        fontSize: 20,
                        onPressed: () {}),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(item['description'].toString(),
                  style: BaseStyles.blackNormal18),

              // Html(
              //   data: item['description'].toString(),
              //   style: {
              //     'body': Style(
              //       fontSize: const FontSize(16.0),
              //       fontWeight: FontWeight.w500,
              //     )
              //   },
              // ),
              // Divider(
              //   thickness: 1,
              //   color: Colors.black45,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
