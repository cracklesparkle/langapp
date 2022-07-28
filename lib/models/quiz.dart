class Question{
  final String text;
  final String type;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question(
    {
      required this.text,
      required this.type,
      required this.options,
      this.isLocked = false,
      this.selectedOption,
    }
  );

  static Question fromJson(json){
    final optionsData = json['options'] as List<dynamic>;
    final options = optionsData != null ? optionsData.map((optionData) => Option.fromJson(optionData)).toList() : <Option>[];
    return Question(
      text: json['text'],
      type: json['type'], 
      options: options
    );
  }
}

class Option{
  final String text;
  final bool isCorrect;
  
  const Option({
    required this.text,
    required this.isCorrect
  });

  static Option fromJson(json) => Option(
    text: json['text'], 
    isCorrect: json['isCorrect']
  );
}