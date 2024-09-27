import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sembast/sembast_io.dart';
import 'package:myapp/models/transaction.dart';

class TransactionDB {
  String dbName;
  TransactionDB({required this.dbName});

  Future<Database> openDatabase(dynamic appDirectory) async {
    Directory appDicrectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transaction statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');

    //json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "data": statement.date.toIso8160String()
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมือ
  loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshort = store.find(db);
  }
}
