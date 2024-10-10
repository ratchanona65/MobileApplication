import 'dart:ui';

class Transactions {
  final String brand;
  final String model;
  final double price;
  final String imagePath;
  String colorsModel;
  final int? keyID;

  Transactions({
    required this.brand,
    required this.model,
    required this.price,
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
