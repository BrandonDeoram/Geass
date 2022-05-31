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

  Future<void> addUser(User1 user) async {
    var listUser = db.collection(Path.users());
    listUser.doc(currentUser()).set(user.toJson());
    listUser
        .doc(currentUser())
        .collection('Pictures')
        .doc('1')
        .set({'backgroundImage': "", "avatarImage": ""});
  }

  Future getUserInfo() async {
    var id = await searchUser(firebaseAuth.currentUser!.uid);
    return await db.collection(Path.users()).doc(id).get();
  }

  Future uploadBackgroundImage(String path) async {
    var id = await searchUser(firebaseAuth.currentUser!.uid);
    var data = await db
        .collection(Path.users())
        .doc(id)
        .collection('Pictures')
        .doc('1')
        .set({"backgroundImage": path}, SetOptions(merge: true));
  }

  Future uploadAvatarImage(String path) async {
    var id = await searchUser(firebaseAuth.currentUser!.uid);
    var data = await db
        .collection(Path.users())
        .doc(id)
        .collection('Pictures')
        .doc('1')
        .set({"avatarImage": path}, SetOptions(merge: true));
  }

  Future getBackgroundImage() async {
    var id = await searchUser(firebaseAuth.currentUser!.uid);
    return await db
        .collection(Path.users())
        .doc(id)
        .collection('Pictures')
        .doc('1')
        .get();
  }

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

  Future<List<Anime>> fetchTop() async {
    var rec = await jikan.getTop(TopType.anime, subtype: TopSubtype.airing);
    List<Top> topList = [];
    List<dynamic> animeId = [];
    var animeList;
    var listAnime;
    // for (var i = 0; i <= 20; i++) {
    //   topList.add(rec[i]);
    // }
    for (var i = 0; i <= 10; i++) {
      animeId.add(rec[i].malId);
    }

    return await fetchAnime(animeId);
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

  Future<List> getFavouriteList() async {
    //Make call to specific list
    var favouriteList = [];
    DocumentReference docRef = db.collection(Path.users()).doc(currentUser());
    await docRef.get().then((value) => favouriteList = value.get('favourites'));
    return favouriteList;
  }
}
