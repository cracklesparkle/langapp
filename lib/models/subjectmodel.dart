class Subject{
  final String title;
  final String imageAsset;
  final String color;
  final List<SubjectOption> options;
  String? url;

  Subject(
    {
      required this.title,
      required this.imageAsset,
      required this.color,
      required this.options,
      this.url
    }
  );

  static Subject fromJson(json){
    final categoryData = json['options'] as List<dynamic>;
    final options = categoryData != null ? categoryData.map((data) => SubjectOption.fromJson(data)).toList() : <SubjectOption>[];
    return Subject(
      title: json['title'], 
      imageAsset: json['imageAsset'], 
      color: json['color'], 
      options: options,
    );
  }
}

class SubjectOption{
  final String title;
  final String type;
  final String url;
  
  const SubjectOption({
    required this.title,
    required this.type,
    required this.url,
  });

  static SubjectOption fromJson(json) => SubjectOption(
    title: json['title'], 
    type: json['type'],
    url: json['url'],

  );
}