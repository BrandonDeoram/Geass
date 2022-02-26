import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geassapp/models/anime.dart';
import 'package:geassapp/providers/anime_notifier.dart';
import 'package:geassapp/services/path_service.dart';

class DataBaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Read
  Future<void> getAllAnime() async {
    QuerySnapshot qshot = await db.collection(Path.animes()).get();
    print(qshot.docs.map((e) => e.data));
  }

  getAnimes(AnimeNotifier animeNotifier) async {
    final snapshot = await db.collection(Path.animes()).get();
    List<Anime> _animeList = [];
    for (var snap in snapshot.docs) {
      Anime anime = Anime.fromMap(snap.data());
      _animeList.add(anime);
    }
  }

  getTypeAnime(AnimeNotifier animeNotifier, String cat) async {
    List<Anime> list = [];
    var anime = db.collection(Path.animes());
    await anime.where('categories', arrayContains: cat).get().then((snapshot) {
      for (var snap in snapshot.docs) {
        Anime anime = Anime.fromMap(snap.data());
        list.add(anime);
      }
    });
    animeNotifier.setanimeList(list, cat);
  }

  // Future<void> addAllAnimes() async {
  //   for (int i = 0; i < animeList.length; i++) {
  //     db
  //         .collection(Path.animes())
  //         .doc(animeList[i].animeID)
  //         .set(animeList[i].toJson());
  //   }
  // }
}
