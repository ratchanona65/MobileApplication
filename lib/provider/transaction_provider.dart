import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/database/transaction_db.dart';
import 'package:myapp/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [
    // Transaction(brand: 'Samsung', price: 29000, date: DateTime.now()),
    // Transaction(title: 'เสื้อ', amount: 500, date: DateTime.now()),
    // Transaction(title: 'รองเท้า', amount: 1000, date: DateTime.now()),
  ];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = await TransactionDB(dbName: 'transactions.db');
    transactions = await db.loadAllData();

    notifyListeners();
  }

  void addTransaction(Transactions transaction) async {
    var db = await TransactionDB(dbName: 'transactions.db');
    var keyID = await db.InsertData(transaction); //บันทึกข้อมูล

    transactions.add(transaction);
    transactions = await db.loadAllData();

    print("keyID: $keyID");
    notifyListeners();
  }

  void deleteTransaction(int? index) async {
    var db = TransactionDB(dbName: 'transactions.db');
    await db.deleteData(index);

    // Reload transactions after deletion
    transactions = await db.loadAllData();
    notifyListeners();
  }

  //อัพโหลดรูป
}
