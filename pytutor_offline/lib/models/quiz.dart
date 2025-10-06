class Quiz {
  final int id;
  final String title;
  final String category;
  final List<Question> questions;
  int bestScore;

  Quiz({
    required this.id,
    required this.title,
    required this.category,
    required this.questions,
    this.bestScore = 0,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      bestScore: json['bestScore'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'questions': questions.map((q) => q.toJson()).toList(),
      'bestScore': bestScore,
    };
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String? explanation;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }
}
