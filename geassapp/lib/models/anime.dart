import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Anime {
  final String animeId;
  final String name;
  final List<dynamic> categories;
  final String descript;
  final String duration;
  final String rating;
  final String image;

  Anime({
    required this.animeId,
    required this.name,
    required this.categories,
    required this.descript,
    required this.duration,
    required this.rating,
    required this.image,
  });
  factory Anime.fromMap(Map<String, dynamic> data) {
    return Anime(
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
        'animeId': animeId,
        'name': name,
        'categories': categories,
        'descript': descript,
        'duration': duration,
        'rating': rating,
        'image': image,
      };
}

List<Anime> animeList = [
  Anime(
      animeId: uuid.v4(),
      name: "Hunter x Hunter",
      categories: ["Action", "Adventure", "Fantasy", "Shounen"],
      descript:
          "Hunters devote themselves to accomplishing hazardous tasks, all from traversing the world's uncharted territories to locating rare items and monsters. Before becoming a Hunter, one must pass the Hunter Examination—a high-risk selection process in which most applicants end up handicapped or worse, deceased.Ambitious participants who challenge the notorious exam carry their own reason. What drives 12-year-old Gon Freecss is finding Ging, his father and a Hunter himself. Believing that he will meet his father by becoming a Hunter, Gon takes the first step to walk the same path.During the Hunter Examination, Gon befriends the medical student Leorio Paladiknight, the vindictive Kurapika, and ex-assassin Killua Zoldyck. While their motives vastly differ from each other, they band together for a common goal and begin to venture into a perilous world.",
      duration: "23",
      rating: "4.05",
      image: "https://cdn.myanimelist.net/images/anime/1337/99013.jpg"),
  Anime(
      animeId: uuid.v4(),
      name: "Dragon Ball",
      categories: ["Action", "Adventure", "Comedy", "Shounen"],
      descript:
          "Gokuu Son is a young boy who lives in the woods all alone—that is, until a girl named Bulma runs into him in her search for a set of magical objects called the Dragon Balls. Since the artifacts are said to grant one wish to whoever collects all seven, Bulma hopes to gather them and wish for a perfect boyfriend. Gokuu happens to be in possession of a dragon ball, but unfortunately for Bulma, he refuses to part ways with it, so she makes him a deal: he can tag along on her journey if he lets her borrow the dragon ball's power. With that, the two set off on the journey of a lifetime.They don't go on the journey alone. On the way, they meet the old Muten-Roshi and wannabe disciple Kuririn, with whom Gokuu trains to become a stronger martial artist for the upcoming World Martial Arts Tournament. However, it's not all fun and games; the ability to make any wish come true is a powerful one, and there are others who would do much worse than just wishing for a boyfriend. To stop those who would try to abuse the legendary power, they train to become stronger fighters, using their newfound strength to help the people around them along the way.",
      duration: "24",
      rating: "3.96",
      image: "https://cdn.myanimelist.net/images/anime/1887/92364.jpg"),
  Anime(
      animeId: uuid.v4(),
      name: "The God of High School",
      categories: ["Action", "Sci-FI", "Fantasy", "Supernatural", "Shounen"],
      descript:
          "The God of High School tournament has begun, seeking out the greatest fighter among Korean high school students! All martial arts styles, weapons, means, and methods of attaining victory are permitted. The prize? One wish for anything desired by the winner.Taekwondo expert Jin Mo-Ri is invited to participate in the competition. There he befriends karate specialist Han Dae-Wi and swordswoman Yu Mi-Ra, who both have entered for their own personal reasons. Mo-Ri knows that no opponent will be the same and that the matches will be the most ruthless he has ever fought in his life. But instead of being worried, this prospect excites him beyond belief.A secret lies beneath the facade of a transparent test of combat prowess the tournament claims to be—one that has Korean political candidate Park Mu-Jin watching every fight with expectant, hungry eyes. Mo-Ri, Dae-Wi, and Mi-Ra are about to discover what it really means to become the God of High School.",
      duration: "23",
      rating: "3.07",
      image: "https://cdn.myanimelist.net/images/anime/1722/107269.jpg")
];
