class AudioItem{
  final String title;
  final String subtitle;
  final String description;
  final String url;
  final String thumbnailUrl;

  const AudioItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.url,
    required this.thumbnailUrl
  });

  static AudioItem fromJson(json) => AudioItem(
    title: json['title'], 
    subtitle: json['subtitle'], 
    description: json['description'], 
    url: json['url'], 
    thumbnailUrl: json['thumbnailUrl']);
}