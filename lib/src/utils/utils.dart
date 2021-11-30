import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';





void abrirScan(ScanModel scan) async {
  if (scan.tipo == 'http') {
    await canLaunch(scan.valor) ? await launch(scan.valor) : throw 'Could not launch ${scan.valor}';
  } else {
    print('GEOO ${scan.valor}');
  }

}
