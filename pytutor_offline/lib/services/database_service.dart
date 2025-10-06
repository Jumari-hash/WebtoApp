import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lesson.dart';
import '../models/quiz.dart';
import '../models/qa_entry.dart';

class DatabaseService {
  static Database? _database;
  List<Lesson>? _cachedLessons;
  List<Quiz>? _cachedQuizzes;
  List<QAEntry>? _cachedQAEntries;

  Future<void> initialize() async {
    _database = await _initDB();
    await _loadData();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pytutor.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE lessons (
            id INTEGER PRIMARY KEY,
            isCompleted INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE quiz_scores (
            quizId INTEGER PRIMARY KEY,
            bestScore INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<void> _loadData() async {
    final lessonsJson = await rootBundle.loadString('assets/lessons/lessons.json');
    final quizzesJson = await rootBundle.loadString('assets/lessons/quizzes.json');
    final qaJson = await rootBundle.loadString('assets/qa_data/qa_entries.json');

    final lessonsData = json.decode(lessonsJson) as List;
    final quizzesData = json.decode(quizzesJson) as List;
    final qaData = json.decode(qaJson) as List;

    _cachedLessons = lessonsData.map((l) => Lesson.fromJson(l)).toList();
    _cachedQuizzes = quizzesData.map((q) => Quiz.fromJson(q)).toList();
    _cachedQAEntries = qaData.map((q) => QAEntry.fromJson(q)).toList();

    await _syncProgress();
  }

  Future<void> _syncProgress() async {
    if (_database == null) return;

    for (var lesson in _cachedLessons ?? []) {
      final result = await _database!.query(
        'lessons',
        where: 'id = ?',
        whereArgs: [lesson.id],
      );

      if (result.isNotEmpty) {
        lesson.isCompleted = result.first['isCompleted'] == 1;
      }
    }

    for (var quiz in _cachedQuizzes ?? []) {
      final result = await _database!.query(
        'quiz_scores',
        where: 'quizId = ?',
        whereArgs: [quiz.id],
      );

      if (result.isNotEmpty) {
        quiz.bestScore = result.first['bestScore'] as int;
      }
    }
  }

  Future<List<Lesson>> getLessons(String category) async {
    if (_cachedLessons == null) await _loadData();

    if (category == 'All') {
      return _cachedLessons ?? [];
    }

    return _cachedLessons!
        .where((lesson) => lesson.category == category)
        .toList();
  }

  Future<List<Quiz>> getQuizzes() async {
    if (_cachedQuizzes == null) await _loadData();
    return _cachedQuizzes ?? [];
  }

  Future<List<QAEntry>> searchQA(String query) async {
    if (_cachedQAEntries == null) await _loadData();

    final lowerQuery = query.toLowerCase();
    return _cachedQAEntries!.where((qa) {
      return qa.question.toLowerCase().contains(lowerQuery) ||
          qa.answer.toLowerCase().contains(lowerQuery) ||
          qa.keywords.any((k) => k.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  Future<void> markLessonComplete(int lessonId) async {
    if (_database == null) return;

    await _database!.insert(
      'lessons',
      {'id': lessonId, 'isCompleted': 1},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final lesson = _cachedLessons?.firstWhere((l) => l.id == lessonId);
    if (lesson != null) {
      lesson.isCompleted = true;
    }
  }

  Future<void> saveQuizScore(int quizId, int score) async {
    if (_database == null) return;

    final existing = await _database!.query(
      'quiz_scores',
      where: 'quizId = ?',
      whereArgs: [quizId],
    );

    final currentBest = existing.isNotEmpty
        ? existing.first['bestScore'] as int
        : 0;

    if (score > currentBest) {
      await _database!.insert(
        'quiz_scores',
        {'quizId': quizId, 'bestScore': score},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final quiz = _cachedQuizzes?.firstWhere((q) => q.id == quizId);
      if (quiz != null) {
        quiz.bestScore = score;
      }
    }
  }

  Future<Map<String, dynamic>> getProgress() async {
    if (_cachedLessons == null || _cachedQuizzes == null) {
      await _loadData();
    }

    final totalLessons = _cachedLessons?.length ?? 0;
    final lessonsCompleted = _cachedLessons?.where((l) => l.isCompleted).length ?? 0;
    final quizzesCompleted = _cachedQuizzes?.where((q) => q.bestScore > 0).length ?? 0;

    final scores = _cachedQuizzes
            ?.where((q) => q.bestScore > 0)
            .map((q) => q.bestScore)
            .toList() ??
        [];
    final averageScore = scores.isEmpty
        ? 0.0
        : scores.reduce((a, b) => a + b) / scores.length;

    return {
      'totalLessons': totalLessons,
      'lessonsCompleted': lessonsCompleted,
      'quizzesCompleted': quizzesCompleted,
      'averageScore': averageScore,
    };
  }
}
