import 'package:flutter/foundation.dart';
import 'package:myapp/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [
    // Transaction(title: 'หนังสือ', amount: 300, date: DateTime.now()),
    // Transaction(title: 'เสื้อ', amount: 500, date: DateTime.now()),
    // Transaction(title: 'รองเท้า', amount: 1000, date: DateTime.now()),
  ];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }
}
