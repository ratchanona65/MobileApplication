import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/transaction.dart';
import 'package:myapp/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/mobile_colors.dart';

class EditScreen extends StatefulWidget {
  final Transactions transaction; // รับข้อมูลที่ต้องการแก้ไข

  EditScreen({required this.transaction});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController priceController;
  late String colorsModelController;
  String? selectedColor;
  String iconController = "";

  @override
  void initState() {
    super.initState();

    brandController = TextEditingController(text: widget.transaction.brand);
    modelController = TextEditingController(text: widget.transaction.model);
    priceController =
        TextEditingController(text: widget.transaction.price.toString());
    colorsModelController = widget.transaction.colorsModel;
    selectedColor = widget.transaction.colorsModel;
    iconController = widget.transaction.imagePath;
  }

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'แก้ไขข้อมูล',
              style: GoogleFonts.kanit(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.edit, color: Colors.white),
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
                  controller: modelController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                DropdownButtonFormField<mobileIcon>(
                  value: mobileIcon.values.firstWhere(
                      (icon) => icon.imagePath == iconController,
                      orElse: () => mobileIcon.ques),
                  decoration: const InputDecoration(
                    labelText: 'ระบบปฏิบัติการ',
                  ),
                  items: mobileIcon.values.map((icon) {
                    return DropdownMenuItem<mobileIcon>(
                      value: icon,
                      child: Row(
                        children: [
                          Image.asset(icon.imagePath,
                              width: 24, height: 24), // ไอคอน
                          const SizedBox(width: 10),
                          Text(icon.title),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        iconController =
                            value.imagePath; // อัปเดต iconController
                      }
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'สีเครื่อง',
                  ),
                  hint: const Text("สีเครื่อง"),
                  value: selectedColor,
                  items: MobileColors.values.map((color) {
                    return DropdownMenuItem<String>(
                      value: "0x${color.color.value.toRadixString(16)}",
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: color.color,
                          ),
                          SizedBox(width: 10),
                          Text(color.title),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedColor = value;
                      colorsModelController = value ?? "0xFF000000";
                    });
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
                    backgroundColor: const Color.fromARGB(255, 44, 45, 136),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                  child: Text(
                    'บันทึก',
                    style: GoogleFonts.kanit(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var updatedTransaction = Transactions(
                        keyID: widget.transaction.keyID,
                        brand: brandController.text,
                        model: modelController.text,
                        colorsModel: colorsModelController,
                        price: double.parse(priceController.text),
                        imagePath: iconController,
                      );

                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.updateTransaction(updatedTransaction);

                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
