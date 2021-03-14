import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_titles.dart';

class MapasPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScanTitles(tipo: 'geo');
  }
}
