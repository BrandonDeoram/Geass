import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AnimeClass {
  final String animeId;
  final String name;
  final List<dynamic> categories;
  final String descript;
  final String duration;
  final String rating;
  final String image;

  AnimeClass({
    required this.animeId,
    required this.name,
    required this.categories,
    required this.descript,
    required this.duration,
    required this.rating,
    required this.image,
  });
  factory AnimeClass.fromMap(Map<String, dynamic> data) {
    return AnimeClass(
      animeId: data['animeId'],
      name: data['name'],
      categories: data['categories'],
      descript: data['descript'],
      duration: data['duration'],
      rating: data['rating'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'AnimeId': animeId,
        'name': name,
        'categories': categories,
        'descript': descript,
        'duration': duration,
        'rating': rating,
        'image': image,
      };
}
