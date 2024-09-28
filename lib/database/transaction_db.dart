import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sembast/sembast_io.dart';
import 'package:myapp/models/transaction.dart';

class TransactionDB {
  String dbName;
  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');

    //json
    var keyID = await store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });

    await db.close();
    return keyID;
  }

  //ดึงข้อมือ
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db);

    List<Transactions> transactions = [];
    print(snapshot);
    for (var record in snapshot) {
      transactions.add(Transactions(
          title: record['title'].toString(),
          amount: double.parse(record['amount'].toString()),
          date: DateTime.parse(record['amount'].toString())));
    }
    await db.close(); //เดี๋ยวลบบ
    return transactions;
  }

  //ลบข้อมูล
// ลบข้อมูลโดยใช้ Transactions
  Future<int> deleteData(Transactions statement) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense');

    // Use the properties of the transaction to find and delete it
    var result = await store.delete(
      db,
      finder: Finder(
        filter: Filter.and([
          Filter.equals('title', statement.title),
          Filter.equals('amount', statement.amount),
          Filter.equals('date', statement.date.toIso8601String())
        ]),
      ),
    );
    db.close();
    return result;
  }
}
