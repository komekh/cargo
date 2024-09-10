import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> downloadFile(String url, String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$filename';

  // Perform the GET request
  final response = await http.get(Uri.parse(url));

  // Check if the request was successful
  if (response.statusCode == 200) {
    final file = File(filePath);

    var raf = file.openSync(mode: FileMode.write);
    // response.bodyBytes is a List<int> type
    raf.writeFromSync(response.bodyBytes);
    await raf.close();

    return filePath;
  } else {
    throw Exception('Failed to download file');
  }
}
