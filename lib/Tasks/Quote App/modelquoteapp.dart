class Quote {
  final String text;
  final String from;

  Quote({required this.text, required this.from});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(text: json["text"], from: json["from"]);
  }
}