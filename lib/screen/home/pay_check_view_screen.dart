import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';

class PayCheckViewScreen extends StatefulWidget {
  const PayCheckViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PayCheckViewScreen> createState() => _PayCheckViewScreenState();
}

class _PayCheckViewScreenState extends State<PayCheckViewScreen> {
  bool loading = true;
  late PDFDocument pdfDocument;

  loadPdf() async {
    pdfDocument = await PDFDocument.fromAsset(
        "assets/images/CHU-VAN-HOANG-INTERN-FLUTTER.pdf");
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: " widget.name",
        elevate: 0.5,
        centerTitle: false,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: kBackgroundColor,
              ),
            )
          : PDFViewer(
              document: pdfDocument,
              zoomSteps: 1,
            ),
    );
  }
}
