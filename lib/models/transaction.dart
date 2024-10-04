import 'dart:ui';

class Transactions {
  final String brand;
  final String model;
  final double price;
  final DateTime date;
  final String imagePath;
  String colorsModel;
  final int? keyID;

  Transactions({
    required this.brand,
    required this.model,
    required this.price,
    required this.date,
    required this.imagePath,
    required this.colorsModel,
    this.keyID,
  });
}

enum mobileIcon {
  ques(title: "-", imagePath: "assets/img/icon_question.png"),
  android(title: "Android", imagePath: "assets/img/icon_android.png"),
  ios(title: "IOS", imagePath: "assets/img/icon_apple.png");

  const mobileIcon({
    required this.title,
    required this.imagePath,
  });

  final title;
  final imagePath;
}

// enum mobileColors {
//   white(title: "White", color: "0xffffffff"),
//   black(title: "Black", color: "0xff000000"),
//   spaceGray(title: "SpaceGray", color: "0xff757575"),
//   silver(title: "Silver", color: "0xffc0c0c0"),
//   blue(title: "Blue", color: "0xff0000ff"),
//   gold(title: "Gold", color: "0xffffd700"),
//   midnightGreen(title: "Midnight Green", color: "0xff004953"),
//   purple(title: "Purple", color: "0xff800080"),
//   red(title: "Red", color: "0xffff0000"),
//   roseGold(title: "Rose Gold", color: "0xffb76e79"),
//   yellow(title: "Yellow", color: "0xffffff00"),
//   green(title: "Green", color: "0xff228b22"),
//   ;

//   const mobileColors({
//     required this.title,
//     required this.color,
//   });

//   final String title;
//   final String color; // เปลี่ยนเป็น String
// }
