import 'dart:convert';

import 'package:azmatka/constants/values.dart';
import 'package:intl/intl.dart';

class ChartController extends GetxController{
  var market_name = Get.parameters['market_name'];
  var market_slug = Get.parameters['market_slug'];
  final resultChart = [].obs;
  final loading =true.obs;
  @override
  @override
  void onInit() {
    super.onInit();
    resultChartAPI();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void resultChartAPI() async{
    var body={
      'market_slug' : market_slug
    };
    try {
      resultChart.clear();
        var res = await ApiProvider().postRequest2(apiUrl: '/panel-chart', data: body);
        var data = jsonDecode(res);
        resultChart.addAll(data['chart']);
        for (var i = 0; i < resultChart.length; i++) {
          DateFormat dateFormat= DateFormat('d/M/yyyy');
          DateFormat outputFormat=DateFormat('d/M/yy');
          DateTime startDate= dateFormat.parse(resultChart[i]['mon']);
          for (var j = 0; j < 7; j++) {
              resultChart[i]['data'][j]['date']=outputFormat.format(startDate.add(Duration(days: j)));;
          }
        }
        loading.value=false;
      } catch (e) {
        print(e.toString());
      }
  }

}