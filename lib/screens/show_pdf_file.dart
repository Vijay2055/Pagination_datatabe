import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ShowPdfFile extends StatelessWidget {
  const ShowPdfFile({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pdf"),
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: true,
        backgroundColor: Colors.grey,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      ).cachedFromUrl(
        url,
        placeholder: (progress) => Center(
          child: Text(
            '$progress %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        errorWidget: (error) => Center(
          child: Text(error),
        ),
      ),
    );
  }
}
