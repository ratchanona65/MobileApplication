import 'package:myapp/main.dart';
import 'package:myapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/mobile_colors.dart';

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final brandController = TextEditingController(); //ชื่อแบรนด์
  final modelController = TextEditingController(); //ชื่อรุ่น
  final priceController = TextEditingController(); //ราคา

  String iconController = "assets/img/icon_question.png"; //เริ่มต้นเป็น ?

  String colorsModelController = "0xFF000000"; //เริ่มต้น
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Colors.white), //เปลี่ยนสีไอคอน <- (กลับ)
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'กรอกแบบฟอร์มข้อมูล',
                style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),

              const SizedBox(width: 8), // เพิ่มระยะห่างระหว่างข้อความกับไอคอน
              const Icon(Icons.edit, color: Colors.white), // ไอคอนปากกา
            ],
          ),

          backgroundColor: const Color.fromARGB(255, 24, 26, 113),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ชื่อแบรนด์',
                      ),
                      autofocus: false, //เปิด -ปิด แป้น
                      controller: brandController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ชื่อรุ่น',
                      ),
                      autofocus: false, //เปิด -ปิด แป้น
                      controller: modelController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'ระบบปฏิบัติการ',
                        ),
                        items: mobileIcon.values.map((key) {
                          return DropdownMenuItem(
                              value: key, child: Text(key.title));
                        }).toList(),
                        onChanged: (value) {
                          iconController = value!.imagePath.toString();
                        }),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      hint: Text("สีเครื่อง"),
                      value: selectedColor,
                      items: MobileColors.values.map((color) {
                        return DropdownMenuItem<String>(
                          value:
                              "0x${color.color.value.toRadixString(16)}", // เก็บค่าสีในรูปแบบ String
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: color.color, // แสดงสี
                              ),
                              SizedBox(width: 10),
                              Text(color.title), // แสดงชื่อสี
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            selectedColor = value; // บันทึกสีที่เลือก
                            colorsModelController =
                                value; // เก็บค่าที่เลือกไว้ใน colorsModelController
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ราคาเปิดตัว',
                      ),
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      validator: (String? input) {
                        try {
                          double amount = double.parse(input!);
                          if (amount < 0) {
                            return 'กรุณากรอกข้อมูลมากกว่า 0';
                          }
                        } catch (e) {
                          return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 44, 45, 136),
                          foregroundColor: Colors.white, // เปลี่ยนสี text
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                        child: Text(
                          'บันทึก',
                          style: GoogleFonts.kanit(
                            fontSize: 18, // ขนาดฟอนต์
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // create transaction data object

                            var statement = Transactions(
                              brand: brandController.text,
                              model: modelController.text,
                              colorsModel: colorsModelController.isNotEmpty
                                  ? colorsModelController
                                  : '0xFF000000', // ค่าเริ่มต้นหากไม่มีการเลือกสี
                              price: double.parse(priceController.text),
                              imagePath: iconController.isNotEmpty
                                  ? iconController
                                  : 'assets/img/icon_question.png',
                            );

                            // add transaction data object to provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);

                            provider.addTransaction(statement);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyHomePage(
                                    title: "",
                                  );
                                },
                              ),
                            );
                          }
                        })
                  ],
                )),
          ),
        ));
  }
}
