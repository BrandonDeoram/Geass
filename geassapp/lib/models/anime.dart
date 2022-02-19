import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Anime {
  final String name;
  final List<dynamic> categories;
  final String descript;
  final String duration;
  final String rating;
  final String image;

  Anime({
    required this.name,
    required this.categories,
    required this.descript,
    required this.duration,
    required this.rating,
    required this.image,
  });
  factory Anime.fromMap(Map<String, dynamic> data) {
    return Anime(
      name: data['name'],
      categories: data['categories'],
      descript: data['descript'],
      duration: data['duration'],
      rating: data['rating'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() => {
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
      name: "One Piece",
      categories: ["Action", "Adventure", "Comedy", "Drama", "Fantasy"],
      descript:
          "Gol D. Roger was known as the Pirate King, the strongest and most infamous being to have sailed the Grand Line. The capture and execution of Roger by the World Government brought a change throughout the world. His last words before his death revealed the existence of the greatest treasure in the world, One Piece. It was this revelation that brought about the Grand Age of Pirates, men who dreamed of finding One Piece—which promises an unlimited amount of riches and fame—and quite possibly the pinnacle of glory and the title of the Pirate King.Enter Monkey D. Luffy, a 17-year-old boy who defies your standard definition of a pirate. Rather than the popular persona of a wicked, hardened, toothless pirate ransacking villages for fun, Luffy's reason for being a pirate is one of pure wonder: the thought of an exciting adventure that leads him to intriguing people and ultimately, the promised treasure. Following in the footsteps of his childhood hero, Luffy and his crew travel across the Grand Line, experiencing crazy adventures, unveiling dark mysteries and battling strong enemies, all in order to reach the most coveted of all fortunes—One Piece",
      duration: "24",
      rating: "3.62",
      image: "https://cdn.myanimelist.net/images/anime/6/73245.jpg"),
  Anime(
      name: "Jujutsu Kaisen",
      categories: ["Action", "Supernatural"],
      descript:
          "Idly indulging in baseless paranormal activities with the Occult Club, high schooler Yuuji Itadori spends his days at either the clubroom or the hospital, where he visits his bedridden grandfather. However, this leisurely lifestyle soon takes a turn for the strange when he unknowingly encounters a cursed item. Triggering a chain of supernatural occurrences, Yuuji finds himself suddenly thrust into the world of Curses—dreadful beings formed from human malice and negativity—after swallowing the said item, revealed to be a finger belonging to the demon Sukuna Ryoumen, the King of Curses.Yuuji experiences first-hand the threat these Curses pose to society as he discovers his own newfound powers. Introduced to the Tokyo Metropolitan Jujutsu Technical High School, he begins to walk down a path from which he cannot return—the path of a Jujutsu sorcerer",
      duration: "23",
      rating: "4.1",
      image: "https://cdn.myanimelist.net/images/anime/1171/109222.jpg"),
  Anime(
      name: "Attack On Titan",
      categories: ["Action", "Drama", "Fantasy", "Myster"],
      descript:
          "Centuries ago, mankind was slaughtered to near extinction by monstrous humanoid creatures called titans, forcing humans to hide in fear behind enormous concentric walls. What makes these giants truly terrifying is that their taste for human flesh is not born out of hunger but what appears to be out of pleasure. To ensure their survival, the remnants of humanity began living within defensive barriers, resulting in one hundred years without a single titan encounter. However, that fragile calm is soon shattered when a colossal titan manages to breach the supposedly impregnable outer wall, reigniting the fight for survival against the man-eating abominations. After witnessing a horrific personal loss at the hands of the invading creatures, Eren Yeager dedicates his life to their eradication by enlisting into the Survey Corps, an elite military unit that combats the merciless humanoids outside the protection of the walls. Based on Hajime Isayama's award-winning manga, Shingeki no Kyojin follows Eren, along with his adopted sister Mikasa Ackerman and his childhood friend Armin Arlert, as they join the brutal war against the titans and race to discover a way of defeating them before the last walls are breached",
      duration: "24",
      rating: "4.0",
      image: "https://cdn.myanimelist.net/images/anime/10/47347.jpg")
];
