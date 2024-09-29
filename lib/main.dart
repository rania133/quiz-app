import 'package:flutter/material.dart';
import 'quiz_data.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _nameController = TextEditingController();

  void _startQuiz() {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizHomePage(name: name),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please Enter your name ',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(

              controller: _nameController,
              decoration: const InputDecoration(

                border: OutlineInputBorder(),
                labelText: '',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 150, // Set a fixed width for the button
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set the button color to green
                  ),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  final String name;
  const QuizHomePage({Key? key, required this.name}) : super(key: key);

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  List<QuizQuestion> _questions = getQuizQuestions();
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isQuizFinished = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _isQuizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Quiz - ${widget.name}'),
      ),
      body: _isQuizFinished
          ? _buildResult()
          : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _questions[_currentQuestionIndex].question,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ..._questions[_currentQuestionIndex].options.asMap().entries.map(
                (entry) {
              int idx = entry.key;
              String answer = entry.value;
              return ElevatedButton(
                onPressed: () => _answerQuestion(idx),
                child: Text(answer),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quiz Finished!',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Your score is: $_score / ${_questions.length}',
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _restartQuiz,
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
