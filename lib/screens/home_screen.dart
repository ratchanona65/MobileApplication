import 'package:flutter/material.dart';
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Mobile Application",
            style: GoogleFonts.kanit(
                textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
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
                      padding: const EdgeInsets.all(10.0), // เพิ่ม padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // จัดให้อยู่ด้านบนของการ์ด
                        children: [
                          // ส่วนของรูปภาพ
                          Container(
                            child: Image.asset(statement.imagePath ??
                                'assets/img/icon_question.png'),
                            width: 70,
                            height: 70,
                            color: Colors.purple,
                            // width: 100,
                            // height: 100,
                            // color: Colors
                            // .red,  สีพื้นหลังรูป test ไว้ก่อนเดี๋ยวลบบ

                            // child: Center(
                            //   child: Text(
                            //     'product image', // เดี๋ยวเปลี่ยนเป็นให้อัปโหลด
                            //     style: TextStyle(
                            //         color: const Color.fromARGB(255, 10, 8, 8)),
                            //   ),
                            // ),
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
                                  'ราคา: ${statement.price.toString()}',
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
