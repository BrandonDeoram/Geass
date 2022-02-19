import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geassapp/models/anime.dart';

class AnimeNotifier with ChangeNotifier {
  List<Anime> _animeList = [];

  UnmodifiableListView<Anime> get animeList => UnmodifiableListView(_animeList);

  set animeList(List<Anime> animeList) {
    _animeList = animeList;
    notifyListeners();
  }
}
