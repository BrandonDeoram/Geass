import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geassapp/models/anime_class.dart';

class AnimeClassNotifier with ChangeNotifier {
  List<AnimeClass> _AnimeClassList = [];
  List<AnimeClass> _adventureList = [];
  List<AnimeClass> _actionList = [];
  List<AnimeClass> _mysteryList = [];
  List<AnimeClass> _fantasyList = [];
  List<AnimeClass> _dramaList = [];
  List<AnimeClass> _supernaturalList = [];

  UnmodifiableListView<AnimeClass> get AnimeClassList =>
      UnmodifiableListView(_AnimeClassList);
  UnmodifiableListView<AnimeClass> get adventureList =>
      UnmodifiableListView(_adventureList);
  UnmodifiableListView<AnimeClass> get shonenList =>
      UnmodifiableListView(_adventureList);
  UnmodifiableListView<AnimeClass> get dramaList =>
      UnmodifiableListView(_dramaList);
  UnmodifiableListView<AnimeClass> get actionList =>
      UnmodifiableListView(_actionList);
  UnmodifiableListView<AnimeClass> get fantasyList =>
      UnmodifiableListView(_fantasyList);
  UnmodifiableListView<AnimeClass> get mysteryList =>
      UnmodifiableListView(_mysteryList);
  UnmodifiableListView<AnimeClass> get supernaturalList =>
      UnmodifiableListView(_supernaturalList);

  void setAnimeClassList(List<AnimeClass> AnimeClassList, String cat) {
    //Assign it to general list
    switch (cat) {
      case "Adventure":
        _adventureList = AnimeClassList;
        break;
      case "Shonen":
        break;
      case "Action":
        _actionList = AnimeClassList;
        break;
      case "Fantasy":
        _fantasyList = AnimeClassList;
        break;
      case "Mystery":
        _mysteryList = AnimeClassList;
        break;
      case "Supernatural":
        _supernaturalList = AnimeClassList;
        break;
      case "Drama":
        _dramaList = AnimeClassList;
        break;
      default:
        {
          print('category wrong');
          break;
        }
    }
    notifyListeners();
  }

  // set adventureList(List<AnimeClass> adventureList) {
  //   _adventureList = adventureList;
  //   notifyListeners();
  // }
}
