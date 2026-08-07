class quote {
  final String text;
  final String from;

  quote({required this .text, required this .from});
  factory quote.fromJson(Map<String, dynamic>json){
    return quote(text: json["text"], from: json["from"]);
  }
}
