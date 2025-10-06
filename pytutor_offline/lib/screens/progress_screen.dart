import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/database_service.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DatabaseService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: dbService.getProgress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData) {
            return const Center(child: Text('No progress data'));
          }
          
          final progress = snapshot.data!;
          final lessonsCompleted = progress['lessonsCompleted'] ?? 0;
          final totalLessons = progress['totalLessons'] ?? 0;
          final quizzesCompleted = progress['quizzesCompleted'] ?? 0;
          final averageScore = progress['averageScore'] ?? 0.0;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Overall Progress',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: lessonsCompleted.toDouble(),
                                  color: Colors.green,
                                  title: '$lessonsCompleted',
                                  titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: (totalLessons - lessonsCompleted).toDouble(),
                                  color: Colors.grey[300],
                                  title: '${totalLessons - lessonsCompleted}',
                                  titleStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildLegendItem('Completed', Colors.green),
                            _buildLegendItem('Remaining', Colors.grey[300]!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.check_circle,
                        title: 'Lessons',
                        value: '$lessonsCompleted/$totalLessons',
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.quiz,
                        title: 'Quizzes',
                        value: '$quizzesCompleted',
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  icon: Icons.star,
                  title: 'Average Score',
                  value: '${averageScore.toStringAsFixed(1)}%',
                  color: Colors.amber,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildAchievement(
                  title: 'First Steps',
                  description: 'Complete your first lesson',
                  isUnlocked: lessonsCompleted > 0,
                  icon: Icons.flag,
                ),
                _buildAchievement(
                  title: 'Python Basics Master',
                  description: 'Complete all beginner lessons',
                  isUnlocked: lessonsCompleted >= 10,
                  icon: Icons.school,
                ),
                _buildAchievement(
                  title: 'Code Ninja',
                  description: 'Score 100% on 5 quizzes',
                  isUnlocked: quizzesCompleted >= 5 && averageScore >= 100,
                  icon: Icons.emoji_events,
                ),
                _buildAchievement(
                  title: 'Python Expert',
                  description: 'Complete all lessons',
                  isUnlocked: lessonsCompleted >= totalLessons && totalLessons > 0,
                  icon: Icons.workspace_premium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievement({
    required String title,
    required String description,
    required bool isUnlocked,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUnlocked ? Colors.amber : Colors.grey[300],
          child: Icon(
            icon,
            color: isUnlocked ? Colors.white : Colors.grey[600],
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isUnlocked ? null : Colors.grey,
          ),
        ),
        subtitle: Text(description),
        trailing: isUnlocked
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.lock_outline, color: Colors.grey),
      ),
    );
  }
}
