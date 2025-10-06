class Lesson {
  final int id;
  final String title;
  final String description;
  final String category;
  final int duration;
  final List<Map<String, dynamic>> content;
  bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.content,
    this.isCompleted = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      duration: json['duration'],
      content: List<Map<String, dynamic>>.from(json['content']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'content': content,
      'isCompleted': isCompleted,
    };
  }
}
