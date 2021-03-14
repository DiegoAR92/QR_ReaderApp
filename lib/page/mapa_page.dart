import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Text(scanModel.value),
      ),
    );
  }
}
