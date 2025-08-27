// import 'dart:io';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:http/http.dart' as http;
// import 'package:azmatka/constants/values.dart';
// import 'package:azmatka/widgets/image_loader.dart';

// class ReferScreen extends StatefulWidget {
//   const ReferScreen({Key? key}) : super(key: key);

//   @override
//   State<ReferScreen> createState() => _ReferScreenState();
// }

// class _ReferScreenState extends State<ReferScreen> {
//   var data = {};
//   var loading = false;
//   @override
//   void initState() {
//     super.initState();
//     refer();
//   }

//   refer() async {
//     loading = true;
//     try {
//       var res = await ApiProvider().getRequest(apiUrl: 'ref-details');
//       data.addAll(res);
//       loading = false;
//       setState(() {});

//       print(res);
//     } catch (e) {
//       print(e.toString());
//       loading = false;
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomWidgets().getAppBar(title: 'Refer And Earn'),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: loading
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Column(
//                   children: [
//                     networkImage(
//                         url: '${data['path']}/${data['data']['image']}',
//                         width: Get.width),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Html(
//                       data: data['data']['referral_description'].toString(),
//                       style: {'body': Style(fontSize: FontSize(16.0))},
//                     ),
//                     Text(
//                       'Enter my refferal code  to get extra benefit and kuber Coin Use Code : ${GlobalVar.global.user!.info!.referId}',
//                       style: BaseStyles.blackMedium14,
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Tap on box to copy refferal code',
//                       style: BaseStyles.greyMedium14,
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 10),
//                     // InkWell(
//                     //   onTap: () {
//                     //     Clipboard.setData(ClipboardData(
//                     //       text: GlobalVar.global.user!.info!.referId.toString(),
//                     //     ));
//                     //     toast('Refferal code copied');
//                     //   },
//                     //   child: Container(
//                     //     padding: const EdgeInsets.symmetric(
//                     //         vertical: 6, horizontal: 15),
//                     //     decoration: BoxDecoration(
//                     //       border: Border.all(),
//                     //     ),
//                     //     child: Text(
//                     //       GlobalVar.global.user!.info!.referId.toString(),
//                     //       style: BaseStyles.blackBold30,
//                     //     ),
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: CustomWidgets().buildMaterialBtn(
//                           text: 'Refer & Earn',
//                           color: AppColors.primaryColor,
//                           textColor: AppColors.whiteColor,
//                           onPressed: () async {
//                             final imageurl =
//                                 '${data['path']}/${data['data']['image']}';
//                             final uri = Uri.parse(imageurl);
//                             final response = await http.get(uri);
//                             final bytes = response.bodyBytes;
//                             final temp = await getTemporaryDirectory();
//                             final path = '${temp.path}/image.jpg';
//                             File(path).writeAsBytesSync(bytes);
//                             Share.shareFiles([path],
//                                 text:
//                                     'Checkout this free app - It pays to Walk \n\n "   ',
//                                 subject: 'Look what I made!');
//                           }),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
