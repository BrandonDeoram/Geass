import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geassapp/models/MALAnime.dart';
import 'package:geassapp/models/user1.dart';
import 'package:geassapp/services/path_service.dart';
import 'package:http/http.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:http/http.dart' as http;

class DataBaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final jikan = Jikan();
  final url = "https://api.jikan.moe/v4/";

  //Helpers
  List<MALAnime> getResponse(Response response) {
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      List<MALAnime> malAnime = [];
      for (var i = 0; i < data['data'].length; i++) {
        malAnime.add(MALAnime.fromJson(data['data'][i]));
      }

      return malAnime;
    } else {
      throw Exception('Failed to load album');
    }
  }

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

  Future<List<Anime>> fetchGenre() async {
    var top = await jikan.getAnimeGenres(type: GenreType.genres);
    List<int> malIds = [2];
    var search = await jikan.searchAnime(type: AnimeType.tv, genres: malIds);
    List<Anime> animeList = await fetchAnime(malIds);
    // for (var i = 0; i <= 20; i++) {
    //   animeList.add(top[i].malId);
    // }

    return animeList;
  }

  Future<List<Anime>> fetchReccomendation(int id) async {
    var rec = await jikan.getAnimeRecommendations(id);
    List<int> recList = [];
    for (var i = 0; i <= 20; i++) {
      recList.add(rec[i].entry.malId);
    }
    return await fetchAnime(recList);
  }

  Future<List<Anime>> fetchTop() async {
    var top =
        await jikan.getTopAnime(type: TopType.tv, subtype: TopSubtype.airing);
    List<dynamic> animeId = [];
    var listAnime;

    for (var i = 0; i <= 10; i++) {
      animeId.add(top[i].malId);
    }

    return await fetchAnime(animeId);
  }

  Future<List<Anime>> fetchAnime(List<dynamic> animeId) async {
    List<Anime> listAnime = [];
    var length = animeId.length;
    for (var i = 0; i < length; i++) {
      var rec = await jikan.getAnime(animeId[i]);
      listAnime.add(rec);
    }

    return Future.value(listAnime);
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

  Future<List> searchBarAnime(String name) async {
    var rec = await jikan.searchAnime(query: name);
    List newList = [];
    newList = rec.toList();
    return newList;
  }

  Future<List<MALAnime>> getTopAnime() async {
    final response =
        await http.get(Uri.parse(url + 'top/anime?limit=4&limit=20'));

    return getResponse(response);
  }

  Future<List<MALAnime>> getReccomendedAnime(int id) async {
    final response =
        await http.get(Uri.parse(url + 'anime/$id/recommendations'));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      late List<MALAnime> malList = [];
      List<int> malId = [];
      // Get mal id
      for (var i = 0; i < 10; i++) {
        malList.add(await getMALAnime(data['data'][i]['entry']['mal_id']));
        await Future.delayed(Duration(milliseconds: 300));
        print(malList[i].title);
      }
      return malList;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<MALAnime> getMALAnime(int id) async {
    final response = await http.get(Uri.parse(url + 'anime/$id/full'));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return MALAnime.fromJson(data['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<MALAnime>> getMALAnimeID(List<int> malIDS) async {
  //   List<MALAnime> malList = [];
  //   int id;
  //   print("printing list");
  //   for (var i = 0; i < 10; i++) {
  //     id = malIDS[i];
  //     final response = await http
  //         .get(Uri.parse(url + 'anime/$id/full'))
  //         .whenComplete(() => const Duration(seconds: 3));
  //     dynamic data = jsonDecode(response.body);
  //     malList.add(MALAnime.fromJson(data['data']));
  //     print(malList[i]);
  //   }
  //   print("printing list");
  //   print(malList);
  //   return malList;
  // }
}
