import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geassapp/models/anime.dart';

class AnimeNotifier with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> _adventureList = [];

  UnmodifiableListView<Anime> get animeList => UnmodifiableListView(_animeList);
  UnmodifiableListView<Anime> get adventureList =>
      UnmodifiableListView(_adventureList);

  set animeList(List<Anime> animeList) {
    _animeList = animeList;
    notifyListeners();
  }

  set adventureList(List<Anime> adventureList) {
    _adventureList = adventureList;
    notifyListeners();
  }
}
