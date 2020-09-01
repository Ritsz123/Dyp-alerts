import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';

double screenWidth({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.width / divideBy;
}

double screenHeight({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.height / divideBy;
}

const loadingIndicator = SpinKitDualRing(
  color: Colors.blue,
);

const kNoticeTitle = TextStyle(fontSize: 20);
const kNoticeAuthor = TextStyle(fontSize: 14);
const kNoticeTime = TextStyle(fontSize: 14);

const kProfileDescTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
var kProfileDescInfo = TextStyle(fontSize: 20, color: Colors.blueGrey.shade700);

const kCardTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

//Create pdf file from url
Future<File> createFileOfPDFUrl(String pdfUrl) async {
  print(pdfUrl);
  final filename = pdfUrl.substring(pdfUrl.lastIndexOf("/") + 1);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  if (!file.existsSync()) {
    var request = await HttpClient().getUrl(Uri.parse(pdfUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    await file.writeAsBytes(bytes);
  }
  return file;
}
