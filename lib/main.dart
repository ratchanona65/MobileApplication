import 'package:flutter/material.dart';
import 'package:myapp/models/transaction.dart';
import 'package:myapp/screens/form_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/transaction_provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 57, 35, 26)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Mobileee'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<TransactionProvider>(context, listen: false);
    provider.initData();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormScreen();
                }));
              },
            ),
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            //แก้เพิ่ม
            var count = provider.transactions.length;

            if (count <= 0) {
              return Center(
                child: Text("ไม่มีข้อมูล"),
              );
            } else {
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10.0), // เพิ่ม padding ให้เหมาะสม
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // จัดให้อยู่ด้านบนของการ์ด
                        children: [
                          // ส่วนของรูปภาพ
                          Container(
                            width: 100, // ความกว้างของรูป
                            height: 100, // ความสูงของรูป
                            color: Colors
                                .red, // สีพื้นหลังรูป test ไว้ก่อนเดี๋ยวลบบ
                            child: Center(
                              child: Text(
                                'product image', // เดี๋ยวเปลี่ยนเป็นให้อัปโหลด
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // ระยะห่างระหว่างรูปกับข้อความ
                          // ส่วนของข้อความ
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  statement.title, // ชื่อรายการ
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Amount: ${statement.amount.toString()}'),
                                Text(
                                    'Date: ${DateFormat.yMMMd().format(statement.date)}'),
                              ],
                            ),
                          ),
                          // ปุ่มลบ
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.deleteTransaction(statement);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
