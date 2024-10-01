import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myapp/provider/transaction_provider.dart';
import 'package:myapp/screens/form_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<TransactionProvider>(context, listen: false);
    provider.initData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(
              255, 24, 26, 113), //Theme.of(context).colorScheme.primary,
          title: Row(
            children: [
              Image.asset(
                'assets/img/icon_app.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Mobile Application",
                style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
          actions: [
            // IconButton(
            //   icon: const Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return FormScreen();
            //     }));
            //   },
            // ),

            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                SystemNavigator.pop();
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
                      padding: const EdgeInsets.all(10.0), // เพิ่ม padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // จัดให้อยู่ด้านบนของการ์ด
                        children: [
                          // ส่วนของรูปภาพ
                          Container(
                            width: 70,
                            height: 100,
                            // color: const Color.fromARGB(255, 226, 68, 68), //สี Container ใหญ่
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    statement.imagePath,
                                    width: 60,
                                    height: 60,
                                  ),

                                  // color:
                                  //     const Color.fromARGB(255, 116, 238, 116),  //สี Container ของ Icon
                                ),
                              ],
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
                                  statement.brand, // ชื่อรายการ
                                  style: GoogleFonts.kanit(
                                      textStyle: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                                Text(
                                  'ราคาเปิดตัว: ${statement.price.toString()} ฿',
                                  style: GoogleFonts.kanit(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                                Text(
                                    'Date: ${DateFormat.yMMMd().format(statement.date)}'),
                              ],
                            ),
                          ),
                          // ปุ่มลบ
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.deleteTransaction(statement.keyID);
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
