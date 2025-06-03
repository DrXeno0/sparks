import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sparks/model/intern.dart';

class DocumentGenerator {
  Future<void> generateAndPrintPDF(Intern intern) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load("assets/fonts/NotoSans-Regular.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            fontFallback: [
              pw.Font.helvetica(),
              pw.Font.times(),
              pw.Font.courier(),
              ttf,
            ],
          ),
          clip: false,
          textDirection: pw.TextDirection.ltr,
        ),
        build: (context) => [
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.SizedBox(height: 100),
                pw.Row(
                    mainAxisSize: pw.MainAxisSize.max,
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text('M. ${intern.name.toUpperCase()} ',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text(intern.address,
                                style: pw.TextStyle(fontSize: 12)),
                          ])
                    ]),
                pw.SizedBox(height: 50),
                pw.Text('Objet : Acceptation de stage',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text(
                    'Référence: votre courrier n°${intern.ref}/2025 reçu le ${DateTime.now().toString()}'),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Monsieur,\n\n'
                  'Suite à votre demande citée en référence, j’ai le plaisir de vous informer '
                  'qu’un avis favorable a été accordé à votre demande de stage au sein du service : '
                  '« Gestion des Ressources Humaines » de la division : « Affaires Générales » '
                  'relevant du CNRST, et ce du ${intern.startDate.toString()} au ${intern.endDate.toString()}.\n\n'
                  'Par ailleurs, je vous signale que vous êtes tenu de présenter une attestation '
                  'd\'assurance couvrant la période de votre stage.\n\n'
                  'Veuillez agréer, Monsieur, nos meilleures salutations.',
                  style: pw.TextStyle(fontSize: 13),
                ),
                pw.SizedBox(height: 100),
                pw.Text(
                  'N.B: Le stage n’est pas rémunéré. Il sera sanctionné par la délivrance d’une '
                  'attestation après le dépôt d’un rapport validé par l’encadrant côté CNRST. La demande '
                  'de l’attestation doit se faire au plus tard un an après la fin du stage. À l’expiration '
                  'de ce délai, le stagiaire ne pourra prétendre à aucun droit vis-à-vis du CNRST.',
                  style: pw.TextStyle(
                      fontSize: 11, fontStyle: pw.FontStyle.italic),
                ),
              ]),
        ],
      ),
    );

    // Show the system's print dialog
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
    print(" ✅ done Printing");
  }
}
