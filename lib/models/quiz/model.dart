class Question{
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question(
    {
      required this.text,
      required this.options,
      this.isLocked = false,
      this.selectedOption,
    }
  );
}

class Option{
  final String text;
  final bool isCorrect;
  
  const Option({
    required this.text,
    required this.isCorrect
  });
}

final questions = [
  Question(
    text: 'What is actually electricity?', 
    options: [
      const Option(text: 'A flow of water', isCorrect: false),
      const Option(text: 'A flow of air', isCorrect: false),
      const Option(text: 'A flow of electrons', isCorrect: true),
      const Option(text: 'A flow of atom', isCorrect: false),
    ]
  ),
  Question(
    text: 'What is actually electricity?', 
    options: [
      const Option(text: 'A flow of water', isCorrect: false),
      const Option(text: 'A flow of air', isCorrect: false),
      const Option(text: 'A flow of electrons', isCorrect: true),
      const Option(text: 'A flow of atom', isCorrect: false),
    ]
  ),
  Question(
    text: 'What is actually electricity?', 
    options: [
      const Option(text: 'A flow of water', isCorrect: false),
      const Option(text: 'A flow of air', isCorrect: false),
      const Option(text: 'A flow of electrons', isCorrect: true),
      const Option(text: 'A flow of atom', isCorrect: false),
    ]
  ),
];