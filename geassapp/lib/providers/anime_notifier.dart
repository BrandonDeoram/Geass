import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geassapp/models/anime.dart';

class AnimeNotifier with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> _adventureList = [];
  List<Anime> _actionList = [];
  List<Anime> _mysteryList = [];
  List<Anime> _fantasyList = [];
  List<Anime> _dramaList = [];
  List<Anime> _supernaturalList = [];

  UnmodifiableListView<Anime> get animeList => UnmodifiableListView(_animeList);
  UnmodifiableListView<Anime> get adventureList =>
      UnmodifiableListView(_adventureList);
  UnmodifiableListView<Anime> get shonenList =>
      UnmodifiableListView(_adventureList);
  UnmodifiableListView<Anime> get dramaList => UnmodifiableListView(_dramaList);
  UnmodifiableListView<Anime> get actionList =>
      UnmodifiableListView(_actionList);
  UnmodifiableListView<Anime> get fantasyList =>
      UnmodifiableListView(_fantasyList);
  UnmodifiableListView<Anime> get mysteryList =>
      UnmodifiableListView(_mysteryList);
  UnmodifiableListView<Anime> get supernaturalList =>
      UnmodifiableListView(_supernaturalList);

  void setanimeList(List<Anime> animeList, String cat) {
    //Assign it to general list
    switch (cat) {
      case "Adventure":
        _adventureList = animeList;
        break;
      case "Shonen":
        break;
      case "Action":
        _actionList = animeList;
        break;
      case "Fantasy":
        _fantasyList = animeList;
        break;
      case "Mystery":
        _mysteryList = animeList;
        break;
      case "Supernatural":
        _supernaturalList = animeList;
        break;
      case "Drama":
        _dramaList = animeList;
        break;
      default:
        {
          print('category wrong');
          break;
        }
    }
    notifyListeners();
  }

  // set adventureList(List<Anime> adventureList) {
  //   _adventureList = adventureList;
  //   notifyListeners();
  // }
}
