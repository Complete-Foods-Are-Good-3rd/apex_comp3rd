import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> postRequest(Map<String, dynamic> value) async {
  String url = "http://192.168.4.1/update";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode(value);

  http.Response resp = await http.post(url, headers: headers, body: body);
  if (resp.statusCode == 200) {
    return "デザインを更新しました";
  }else{
    return "更新に失敗しました(${resp.body})";
  }
}

Future<double> getDistance() async {
  String url = "http://192.168.4.1/getDistance";
  http.Response resp = await http.get(url);
  if(resp.statusCode == 200){
    return double.parse(resp.body);
  }else{
    return -1;
  }
}
