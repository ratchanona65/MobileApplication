class Transactions {
  final String brand;
  final String model;
  final double price;
  final DateTime date;
  final String imagePath;
  final String colorsModel;
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

enum mobileColors {
  white(title: "White", colorsHex: "0xFFFFFFFF"),
  balck(title: "Black", colorsHex: "0xFF000000"),
  spaceGray(title: "SpaceGray", colorsHex: "0xFF757575"), //
  silver(title: "Silver", colorsHex: "0xFFC0C0C0"),
  blue(title: "Blue", colorsHex: "0xFF0000FF"),
  gold(title: "Gold", colorsHex: "0xFFFFD700"),
  midnightGreen(title: "Midnight Green", colorsHex: "0xFF004953"), //เขียวมรกต
  purple(title: "Purple", colorsHex: "0xFF800080"),
  red(title: "Red", colorsHex: "0xFFFF0000"),
  roseGold(title: "Rose Gold", colorsHex: "0xFFB76E79"),
  yellow(title: "Yellow", colorsHex: "0xFFFFFF00"),
  green(title: "Green", colorsHex: "0xFF228B22"),
  ;

  const mobileColors({
    required this.title,
    required this.colorsHex,
  });

  final title;
  final colorsHex;
}
