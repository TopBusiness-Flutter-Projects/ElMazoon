import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key, required this.pdfLink, required this.pdfTitle}) : super(key: key);
  final String pdfLink;
  final String pdfTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfTitle),
      ),
      body: SfPdfViewer.network(
        pdfLink,
        canShowPaginationDialog: true,
        pageLayoutMode: PdfPageLayoutMode.continuous,
      ),
    );  }
}
