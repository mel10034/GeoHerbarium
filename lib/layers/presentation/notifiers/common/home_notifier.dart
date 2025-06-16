// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/favorite.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/plant.dart';

class HomeNotifier extends ChangeNotifier {
  List<Plant> plants = [];
  List<Plant> supportPlants = [];
  List<Favorite> favorites = [];
  late ValueNotifier<String> dropPLantTypeValue = ValueNotifier('');
  List<Ccategory> plant_types = [];
  List<String> plant_typesStrings = [];
  bool isLoading = false;
  String searchName = "";

  int life_cycle = 0;
  int plant_type = 0;

  HomeNotifier() {
    _setup();
  }

  void _setup() async {
    setLoad(true);
    SupabaseSource source = SupabaseSource();
    final list = await source.getAllPlantTypes();

    plant_types
        .add(Ccategory(id: 0, created_at: "created_at", name: "Без фильтра"));
    plant_typesStrings.add("Без фильтра");
    for (int i = 0; i < list.length; i++) {
      plant_types.add(list[i]);
    }

    for (int i = 0; i < list.length; i++) {
      plant_typesStrings.add(list[i].name);
    }

    supportPlants = await source.getPlants();
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    setLoad(false);
  }

  void searchPlants(String name) async {
    setLoad(true);
    SupabaseSource source = SupabaseSource();
    String lowerCaseQuery = name.toLowerCase();
    plants = supportPlants
        .where((item) => item.name_ru.toLowerCase().contains(lowerCaseQuery))
        .toList();
    setLoad(false);
  }

  void searchByType(int id) async {
    SupabaseSource source = SupabaseSource();
    if (id == 0) {
      setLoad(true);
      supportPlants = await source.getPlants();
      plants = await source.getPlants();
      setLoad(false);
      return;
    }
    setLoad(true);

    supportPlants = await source.getPlantsByType(id);
    plants = await source.getPlantsByType(id);
    setLoad(false);
  }

  void addFavorite(Plant stone) async {
    SupabaseSource source = SupabaseSource();
    await source.addFavorite(stone);
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    notifyListeners();
  }

  void setLoad(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void removeFavorite(Plant stone) async {
    SupabaseSource source = SupabaseSource();
    await source.removeFavorite(stone);
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    notifyListeners();
  }
}
