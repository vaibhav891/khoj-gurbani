import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Downloader {
  bool downloadFinish = false;
  var pathName;
  var imagePath;
  Future<dynamic> downloadFile(String url, filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename' + '.mp3');
    var request = await http.get(
      url,
    );
    var bytes = await request.bodyBytes; //close();
    await file.writeAsBytes(bytes);
    pathName = file.path;
    downloadFinish = true;
    return pathName;
  }

  Future<dynamic> downloadImage(String url, filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File image = new File('$dir/$filename' + '.jpg');
    var request = await http.get(
      url,
    );
    var bytes = await request.bodyBytes; //close();
    await image.writeAsBytesSync(bytes);
    imagePath = image.path;
    downloadFinish = true;
    return imagePath;
  }
}
