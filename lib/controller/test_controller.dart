// ignore_for_file: avoid_print

import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:instagram_clone/controller/base_controller.dart';
import 'package:instagram_clone/services/base_client.dart';

class TestController extends GetxController with BaseController {
  void getData() async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get('https://jsonplaceholder.typicode.com', '/todos/1')
        .catchError(handleError);
    if (response == null) return;
    hideLoading();

    print(response);
  }

  void postData() async {
    var request = {'message': 'CodeX sucks!!!'};
    showLoading('Posting data...');
    var response = await BaseClient()
        .post('https://jsonplaceholder.typicode.com', '/posts', request)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }
}
