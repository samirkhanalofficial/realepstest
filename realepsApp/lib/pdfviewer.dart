import 'package:eshopbuilder/skloading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class PdfViewer extends StatefulWidget {
  String link, title;
  PdfViewer({Key key, this.link, this.title}) : super(key: key);

  @override
  _PdfViewerState createState() => _PdfViewerState(link, title);
}

class _PdfViewerState extends State<PdfViewer> {
  String link, title;
  _PdfViewerState(this.link, this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: SfPdfViewer.network(
              "https://www.samirk.com.np/realepstest/"+link.toString(),
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails e){
                debugPrint("error:"+e.error);
                return error();
              },
              
              enableDoubleTapZooming: true,

              ),
      ),
    );
  }
}
