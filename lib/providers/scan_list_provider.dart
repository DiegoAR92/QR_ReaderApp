import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selecttedTypes = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;
    if (this.selecttedTypes == newScan.type) {
      this.scans.add(newScan);
    }
    notifyListeners();

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScansId();
    this.scans = [...scans];
    notifyListeners();
  }

  loadingScanType(String type) async {
    final scans = await DBProvider.db.getScansType(type);
    this.scans = [...scans];
    this.selecttedTypes = type;
    notifyListeners();
  }

  deletedAllScan() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deletedScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadingScanType(this.selecttedTypes);
  }
}
