import 'package:azmatka/constants/values.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    policyApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: data.isEmpty
          ? Container()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Html(
                data: data[0]['content'].toString(),
              ),
            ),
    );
  }

  var data = [];
  policyApi() async {
    var box = GetStorage();
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'privacypolicy', token: box.read('token'));
      setState(() {
        data.addAll(res);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
