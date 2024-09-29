import 'package:flutter/material.dart';

class Transactions {
  final String brand;
  final double price;
  final DateTime date;
  final String? imagePath;

  Transactions(
      {required this.brand,
      required this.price,
      required this.date,
      this.imagePath});
}

enum mobileIcon {
  ios(title: "IOS", image: "assets/img/icon_apple.png"),
  android(title: "Andriod", image: "assets/img/icon_andriod.png");

  const mobileIcon({
    required this.title,
    required this.image,
  });

  final title;
  final image;
}
