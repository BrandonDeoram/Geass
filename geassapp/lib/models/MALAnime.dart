class MALAnime {
  final int malId;
  final String title;
  final String imageUrl;
  final String description;
  final List<dynamic> genres;
  final double score;

  MALAnime({
    required this.malId,
    required this.title,
    required this.genres,
    required this.description,
    required this.score,
    required this.imageUrl,
  });

  factory MALAnime.fromJson(Map<String, dynamic> json) {
    return MALAnime(
        malId: json['mal_id'],
        imageUrl: json['images']['jpg']['image_url'],
        title: json['title'],
        genres: json['genres'],
        description: json['synopsis'],
        score: json['score']);
  }
}
