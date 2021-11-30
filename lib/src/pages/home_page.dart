import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

// import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  // String barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: scansBloc.borrarScanTodos
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), label: 'Direcciones')
      ],
    );
  }

  _scanQR() async {
    // https://smartsalesteam.com/
    // 'geo:40.68467240898116,-73.95650282343753'
    String barcode = 'https://smartsalesteam.com/';

    /* try {
      // barcode = await BarcodeScanner.scan();
      BarcodeScanner.scan().then((value) {
        setState(() {
          barcode = value;
          print(barcode);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => barcode = 'No hay formato');
    } catch (e) {
      print('Estamos en el error $e');
      setState(() {
        barcode = e.toString();
      });
      setState(() => barcode = 'Unknown error: $e');
    }
    print('INFORMACION QR:  $barcode');
    */
    if (barcode != null) {
      final scan = ScanModel(valor: barcode);
      scansBloc.agregarScan(scan);

      final scan2 = ScanModel(valor: 'geo:40.68467240898116,-73.95650282343753');
      scansBloc.agregarScan(scan2);
      _alert(context);
      
      // utils.abrirScan(scan);
    }
  }

  void _alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Excelente'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25.0),
                Text('Se creó un nuevo registro',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5.0),
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50.0,
                )
              ],
            ),
            actions: [
              TextButton(
                  child: Text('Ok'),
                  onPressed: () => {Navigator.of(context).pop()})
            ],
          );
        });
  }

}
