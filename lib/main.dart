import 'package:flutter/material.dart';
import 'package:myapp/screens/form_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
          scaffoldBackgroundColor: const Color.fromARGB(255, 220, 226, 255),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 11, 1, 72)),
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 26, 113),
        body: TabBarView(children: [HomeScreen(), FormScreen()]),
        bottomNavigationBar: TabBar(
          labelStyle: GoogleFonts.kanit(
            fontSize: 18, // ขนาดฟอนต์
            fontWeight: FontWeight.bold, // หนา
          ),
          tabs: [
            Tab(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              text: "หน้าแรก",
            ),
            Tab(
              icon: Icon(Icons.add, color: Colors.white),
              text: "เพิ่มข้อมูล",
            )
          ],

          labelColor: const Color.fromARGB(
              255, 59, 131, 255), // สีของข้อความที่ถูกเลือก
          unselectedLabelColor: const Color.fromARGB(
              255, 246, 246, 246), // สีของข้อความที่ไม่ถูกเลือก
          indicatorColor: const Color.fromARGB(
              255, 251, 251, 251), // สีของขีดด้านใต้เมนูที่เลือก
        ),
      ),
    );
  }
}
