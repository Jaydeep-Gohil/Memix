class Meme {
  final String postLink;
  final String subreddit;
  final String title;
  final String url;
  final bool nsfw;
  final bool spoiler;
  final String author;
  final int ups;
  final List<String> preview;

  Meme({
    required this.postLink,
    required this.subreddit,
    required this.title,
    required this.url,
    required this.nsfw,
    required this.spoiler,
    required this.author,
    required this.ups,
    required this.preview,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      postLink: json['postLink'],
      subreddit: json['subreddit'],
      title: json['title'],
      url: json['url'],
      nsfw: json['nsfw'],
      spoiler: json['spoiler'],
      author: json['author'],
      ups: json['ups'],
      preview: List<String>.from(json['preview']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postLink': postLink,
      'subreddit': subreddit,
      'title': title,
      'url': url,
      'nsfw': nsfw,
      'spoiler': spoiler,
      'author': author,
      'ups': ups,
      'preview': preview,
    };
  }
}
