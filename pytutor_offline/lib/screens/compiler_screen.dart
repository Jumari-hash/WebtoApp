import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlighting/themes/monokai-sublime.dart';
import 'package:flutter_highlighting/themes/github.dart';
import 'package:provider/provider.dart';
import 'package:highlight/languages/python.dart';
import '../services/python_service.dart';
import '../services/theme_service.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({super.key});

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen> {
  late CodeController _codeController;
  String _output = '';
  bool _isRunning = false;
  
  final String _defaultCode = '''# Write your Python code here
print("Hello, PyTutor!")

# Example: Calculate the sum of numbers
numbers = [1, 2, 3, 4, 5]
total = sum(numbers)
print(f"Sum of {numbers} = {total}")
''';

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: _defaultCode,
      language: python,
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _runCode() async {
    setState(() {
      _isRunning = true;
      _output = 'Running...';
    });
    
    try {
      final result = await PythonService.executeCode(_codeController.text);
      setState(() {
        _output = result;
        _isRunning = false;
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
        _isRunning = false;
      });
    }
  }

  void _clearCode() {
    _codeController.text = '';
    setState(() {
      _output = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDark = themeService.themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Python Compiler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearCode,
            tooltip: 'Clear code',
          ),
          IconButton(
            icon: const Icon(Icons.insert_drive_file),
            onPressed: () {
            },
            tooltip: 'Load example',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.code, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Code Editor',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: CodeTheme(
                        data: CodeThemeData(
                          styles: isDark ? monokaiSublimeTheme : githubTheme,
                        ),
                        child: CodeField(
                          controller: _codeController,
                          textStyle: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isRunning ? null : _runCode,
                icon: _isRunning
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(_isRunning ? 'Running...' : 'Run Code'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.terminal, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Output',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: SelectableText(
                        _output.isEmpty ? 'Output will appear here...' : _output,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          color: _output.isEmpty
                              ? Colors.grey
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
