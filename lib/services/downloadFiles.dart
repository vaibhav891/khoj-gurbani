import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Downloader {
  bool downloadFinish = false;
  var pathName;
  var imagePath;
  Future<dynamic> downloadFile(String url, filename) async {
    print('inside download file -> url is $url');
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename' + '.mp3');
    var request = await http.get(
      url,
    );
    var bytes = request.bodyBytes; //close();
    await file.writeAsBytes(bytes);
    pathName = file.path;
    downloadFinish = true;
    print('file download is finished');
    return pathName;
  }

  Future<dynamic> downloadImage(String url, filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File image = new File('$dir/$filename' + '.jpg');
    var request = await http.get(
      url,
    );
    var bytes = request.bodyBytes; //close();
    await image.writeAsBytesSync(bytes);
    imagePath = image.path;
    downloadFinish = true;
    return imagePath;
  }

  Future<void> removeDownloadFile(String pathName) async {
    print('inside remove download  -> pathName is $pathName');
    try {
      var file = File(pathName);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('error deleting file from local storage [${e.toString()}]');
    }
  }
}
