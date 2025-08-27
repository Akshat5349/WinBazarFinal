import 'package:azmatka/app/modules/home/controllers/product_controller.dart';
import 'package:azmatka/app/modules/home/views/product_details_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:azmatka/widgets/image_loader.dart';
import 'package:azmatka/widgets/views/product_drawer_view.dart';

class ProductView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());

    return Scaffold(
      appBar: AppBar(
        title: Text('RAJ MATKA'),
        centerTitle: true,
      ),
      drawer: ProductDrawerView(),
      body: Obx(
        () => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.products.length == 0
                ? Center(
                    child: Text('No Product Available',
                        style: BaseStyles.blackMedium16),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        heightSpace20,
                        GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(15),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.64,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: controller.products.length,
                            itemBuilder: (BuildContext context, index) {
                              var item = controller.products[index];
                              var save = double.parse(
                                      item['price'].toString()) -
                                  double.parse(item['offer_price'].toString());
                              var discount = (save /
                                      double.parse(item['price'].toString())) *
                                  100;
                              String discountPercent =
                                  discount.toStringAsFixed(0);

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(),
                                      arguments: {
                                        'item': item,
                                        'url': controller.url.value.toString(),
                                      });
                                },
                                child: Container(
                                  width: Get.width * 0.40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width * 0.45,
                                        height: Get.width * 0.45,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: networkImage(
                                                  url:
                                                      '${BASE_URL_image}${item['image']}',
                                                  width: Get.width * 0.45,
                                                  height: Get.width * 0.45),
                                            ),
                                            Positioned(
                                                top: 2,
                                                right: 5,
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    ' $discountPercent% Off',
                                                    maxLines: 1,
                                                    style: BaseStyles
                                                        .whiteMedium16
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(item['name'].toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      BaseStyles.productTitle),
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '₹${item['offer_price']}',
                                                      style: BaseStyles
                                                          .blackMedium16,
                                                    ),
                                                    Text('₹${item['price']}',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough)),
                                                    Text(
                                                      ' $discountPercent% Off',
                                                      maxLines: 1,
                                                      style: BaseStyles
                                                          .greenMedium14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
      ),
    );
  }
}
