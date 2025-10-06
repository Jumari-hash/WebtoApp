class QAEntry {
  final int id;
  final String question;
  final String answer;
  final String category;
  final String? codeExample;
  final List<String> keywords;

  QAEntry({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    this.codeExample,
    required this.keywords,
  });

  factory QAEntry.fromJson(Map<String, dynamic> json) {
    return QAEntry(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      category: json['category'],
      codeExample: json['codeExample'],
      keywords: List<String>.from(json['keywords']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
      'codeExample': codeExample,
      'keywords': keywords,
    };
  }
}
