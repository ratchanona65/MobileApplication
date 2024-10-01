class Transactions {
  final String brand;
  final double price;
  final DateTime date;
  final String imagePath;
  final int? keyID;

  Transactions({
    required this.brand,
    required this.price,
    required this.date,
    required this.imagePath,
    this.keyID,
  });
}

enum mobileIcon {
  android(title: "Android", imagePath: "assets/img/icon_android.png"),
  ques(title: "-", imagePath: "assets/img/icon_question.png"),
  ios(title: "IOS", imagePath: "assets/img/icon_apple.png");

  const mobileIcon({
    required this.title,
    required this.imagePath,
  });

  final title;
  final imagePath;
}
