class JsonPdf {
  late final String name;
  late final String pdf;
  JsonPdf({required this.name, required this.pdf});
}

List<JsonPdf> lisPdf = [
  JsonPdf(
      name: "Hoàng 1", pdf: "assets/images/CHU-VAN-HOANG-INTERN-FLUTTER.pdf"),
  JsonPdf(name: "Hoàng 2", pdf: "assets/images/Chu-Van-Hoang-Fresher-Ruby.pdf"),
  JsonPdf(name: "Hoàng 3", pdf: "assets/images/Chu-Van-Hoang-PHP.pdf"),
  JsonPdf(name: "Hoàng 4", pdf: "assets/images/baocaodoanchuyennganh1.pdf"),
  JsonPdf(
      name: "Hoàng 5",
      pdf: "assets/images/Learn Google Flutter Fast_ 65 Example Apps.pdf")
];

class GiftCode {
  late final String code;
  late final String images;
  GiftCode({required this.code, required this.images});
}

List<GiftCode> listGift = [
  GiftCode(code: "A0123456789", images: "assets/images/Group 5389.png"),
  GiftCode(code: "B0123456789", images: "assets/images/Group 5390.png"),
  GiftCode(code: "C0123456789", images: "assets/images/Group 5391.png")
];
