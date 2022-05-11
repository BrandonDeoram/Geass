import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geassapp/models/anime_class.dart';
import 'package:geassapp/models/user1.dart';
import 'package:geassapp/providers/anime_notifier.dart';
import 'package:geassapp/screens/homeNavPages/anime_lists.dart';
import 'package:geassapp/services/path_service.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:http/http.dart' as http;

class DataBaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final jikan = Jikan();

  //Read
  Future<void> getAllAnime() async {
    QuerySnapshot qshot = await db.collection(Path.animes()).get();
    print(qshot.docs.map((e) => e.data));
  }

  Future<void> addUser(User1 user) async {
    var listUser = db.collection(Path.users());
    listUser.doc(currentUser()).set(user.toJson());
  }

  Future getUserInfo() async {
    var id = await searchUser(firebaseAuth.currentUser!.uid);
    return await db.collection(Path.users()).doc(id).get();
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

  addAnimeToList(String list, int animeID) async {
    var col = db.collection(Path.users()).doc(currentUser()).get();
    List<int> fireBaseList = [];
    fireBaseList.add(animeID);
    var a = await db
        .collection('users')
        .doc(currentUser())
        .update({list: FieldValue.arrayUnion(fireBaseList)});
  }

  deleteAnimeFromList(String list, int animeID) async {
    List<int> fireBaseList = [];
    fireBaseList.add(animeID);
    var col = await db
        .collection(Path.users())
        .doc(currentUser())
        .update({list: FieldValue.arrayRemove(fireBaseList)});
  }

  currentUser() {
    final User? user = firebaseAuth.currentUser;
    final uid = user?.uid.toString();
    return uid;
  }

  Future<List<AnimeItem>> fetchGenre(int genreID) async {
    var jikan = Jikan();
    var top = await jikan.getGenre(genreID, GenreType.anime);
    List<AnimeItem> animeList = [];
    for (var i = 0; i <= 20; i++) {
      animeList.add(top.anime![i]);
    }

    return animeList;
  }

  Future<List<Recommendation>> fetchReccomendation() async {
    var rec = await jikan.getAnimeRecommendations(1);
    List<Recommendation> recList = [];
    for (var i = 0; i <= 20; i++) {
      recList.add(rec[i]);
    }
    return recList;
  }

  Future<List<Top>> fetchTop() async {
    var rec = await jikan.getTop(TopType.anime, subtype: TopSubtype.airing);
    List<Top> topList = [];
    for (var i = 0; i <= 20; i++) {
      topList.add(rec[i]);
    }
    return topList;
  }

  Future<List<Anime>> fetchAnime(List<dynamic> animeId) async {
    List<Anime> listAnime = [];
    for (var i = 0; i < animeId.length; i++) {
      var rec = await jikan.getAnimeInfo(animeId[i]);
      listAnime.add(rec);
    }

    return listAnime;
  }

  Stream getAnimeList() {
    //Make call to specific list
    var col = db.collection(Path.users()).doc(currentUser()).snapshots();
    return col;
  }
}
