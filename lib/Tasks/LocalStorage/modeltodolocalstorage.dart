class todo{
  String title;
  bool isDone;

todo({required this.title , this.isDone = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
  };

  factory todo.fromJson(Map<String, dynamic> json) => todo(
    title: json['title'],
    isDone: json['isDone'],
  );
}