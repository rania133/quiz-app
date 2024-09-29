class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<QuizQuestion> getQuizQuestions() {
  return [
    QuizQuestion(
      question: 'The world\'s largest desert is?',
      options: ['Thar', 'Kalahari', 'Sahara', 'Sonoran'],
      correctAnswerIndex: 2,  // Correct answer: Sahara
    ),
    QuizQuestion(
      question: 'The metal whose salts are sensitive to light is?',
      options: ['Zinc', 'Silver', 'Copper', 'Aluminium'],
      correctAnswerIndex: 1,  // Correct answer: Silver
    ),
    QuizQuestion(
      question: 'The Central Rice Research Station is situated in?',
      options: ['Cuttack', 'Bangalore', 'Chennai', 'Mumbai'],
      correctAnswerIndex: 0,  // Correct answer: Cuttack
    ),
  ];
}
