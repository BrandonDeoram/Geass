import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geassapp/models/anime.dart';
import 'package:geassapp/models/user1.dart';
import 'package:geassapp/providers/anime_notifier.dart';
import 'package:geassapp/services/path_service.dart';

class DataBaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

  Future<List<Anime>> getTypeAnime(String cat) async {
    List<Anime> list = [];
    var anime = db.collection(Path.animes());
    await anime.where('categories', arrayContains: cat).get().then((snapshot) {
      for (var snap in snapshot.docs) {
        Anime anime = Anime.fromMap(snap.data());
        list.add(anime);
      }
    });
    return list;
  }

  Future<void> addAllAnimes() async {
    for (int i = 0; i < animeList.length; i++) {
      db
          .collection(Path.animes())
          .doc(animeList[i].animeId)
          .set(animeList[i].toJson());
    }
  }

  Future<void> addUser(User1 user) async {
    var listUser = db.collection(Path.users());
    listUser.doc(currentUser()).set(user.toJson());
  }

  // Future<bool?> searchUser(String? email) async {
  //   bool? value;
  //   var collection =
  //       db.collection(Path.users()).where('email', isEqualTo: email).limit(1);
  //   var snap = collection.snapshots();
  //   await snap.isEmpty.then((result) => value = result);
  //   return value;
  // }
  // Future<String> searchUser(String uuid) async {
  //   bool? value;
  //   var collection = db.collection(Path.users());
  //   collection.
  //   return collection;
  // }
  Future<String> searchUser(String uuid) async {
    var a = await db.collection('users').doc(uuid).get();
    if (a.exists) {
      print('Exists');
      return a.id;
    } else {
      print('DOES IT EXITS');
      print(a.exists);
      return "";
    }
  }

  // addAnimeToList(String list,String animeID) {

  // }
  currentUser() {
    final User? user = firebaseAuth.currentUser;
    final uid = user?.uid.toString();
    return uid;
  }
}
