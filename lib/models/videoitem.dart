class VideoItem{
  final String title;
  final String description;
  final String url;
  final String thumbnailUrl;

  const VideoItem({
    required this.title,
    required this.description,
    required this.url,
    required this.thumbnailUrl
  });

  static VideoItem fromJson(json) => VideoItem(
    title: json['title'], 
    description: json['description'], 
    url: json['url'], 
    thumbnailUrl: json['thumbnailUrl']);
}