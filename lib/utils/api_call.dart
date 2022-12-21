import 'package:http/http.dart' as http;

class ApiCall {
  static postData(
    final title,
    final script,
    final picture,
    final lat,
    final lon,
    final elv,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://external.addyourtour.com/'));

    request.fields.addAll({
      'auth': '20E985FC-CD1D-BDC5-7EC79AEB732E5E56',
      'lng': '1',
      'title': title,
      'script': script,
      'lat': lat,
      'lon': lon,
      'elv': elv,
      'credit': 'Copyright SignHear'
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'picture',
        picture,
      ),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("------data send----");
      print(await response.stream.bytesToString());
    } else {
      print("------data failed to send----");
      print(response.reasonPhrase);
    }
  }
}
