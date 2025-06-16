// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolog/layers/domain/entities/favorite.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/geo_deposit.dart';
import 'package:geolog/layers/domain/entities/locate.dart';
import 'package:geolog/layers/domain/entities/profile.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SupabaseSource {
  final supabase = Supabase.instance.client;

  Future<String> signUp(String email, String password) async {
    final response =
        await supabase.auth.signUp(password: password, email: email);
    return response.user?.id as String;
  }

  Future<void> registerProfile(
    String userId,
    String nickname,
  ) async {
    await supabase.from('profiles').insert({
      'user_id': userId,
      'fio': nickname,
    });
  }

  Future<void> loadAvatar(String avatar) async {
    await supabase.from('profiles').update({'avatar': avatar}).eq(
        'user_id', supabase.auth.currentSession!.user.id);
  }

  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<void> logOut() async {
    await supabase.auth.signOut();
  }

  Future<Profile> getMyProfile() async {
    final profilesMaps = await supabase
        .from('profiles')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    return Profile.fromMap(profilesMaps.first);
  }

  Future<List<Plant>> getPlants() async {
    final plants = await supabase.from('plants').select();

    List<Plant> Plants = [];
    for (int i = 0; i < plants.length; i++) {
      Plants.add(Plant.fromMap(plants[i]));
    }

    debugPrint(Plants[0].toString());
    debugPrint(Plants[1].toString());
    debugPrint(Plants[2].toString());

    return Plants;
  }


   Future<List<Plant>> getPlantsByType(int type_id) async {
    final plants = await supabase.from('plants').select().eq('plant_type', type_id);

    List<Plant> Plants = [];
    for (int i = 0; i < plants.length; i++) {
      Plants.add(Plant.fromMap(plants[i]));
    }

  

    return Plants;
  }

  Future<Ccategory> getGenus(genusId) async {
    final genuses =
        await supabase.from('plant_genuses').select().eq('id', genusId);

    List<Ccategory> Genuses = [];
    for (int i = 0; i < genuses.length; i++) {
      Genuses.add(Ccategory.fromMap(genuses[i]));
    }
    return Genuses.first;
  }

  Future<Ccategory> getFamily(genusId) async {
    final family =
        await supabase.from('plant_families').select().eq('id', genusId);

    List<Ccategory> Family = [];
    for (int i = 0; i < family.length; i++) {
      Family.add(Ccategory.fromMap(family[i]));
    }
    return Family.first;
  }

  Future<Ccategory> getPlantType(plantTypeId) async {
    final plantType =
        await supabase.from('plant_types').select().eq('id', plantTypeId);

    List<Ccategory> PlantType = [];
    for (int i = 0; i < plantType.length; i++) {
      PlantType.add(Ccategory.fromMap(plantType[i]));
    }
    return PlantType.first;
  }

  Future<Ccategory> getLifeCycle(lifeCycleId) async {
    final lifeCycle =
        await supabase.from('life_cycle').select().eq('id', lifeCycleId);

    List<Ccategory> LifeCycle = [];
    for (int i = 0; i < lifeCycle.length; i++) {
      LifeCycle.add(Ccategory.fromMap(lifeCycle[i]));
    }
    return LifeCycle.first;
  }

  Future<Ccategory> getHabitat(habitatId) async {
    final habitat =
        await supabase.from('plant_habitats').select().eq('id', habitatId);

    List<Ccategory> Habitat = [];
    for (int i = 0; i < habitat.length; i++) {
      Habitat.add(Ccategory.fromMap(habitat[i]));
    }
    return Habitat.first;
  }

  Future<Plant> getPlant(int plant) async {
    final plants = await supabase.from('plants').select().eq('id', plant);

    return Plant.fromMap(plants.first);
  }

  Future<List<Locate>> getDeposits(int plantId) async {
    final locates = await supabase
        .rpc('get_plant_locations', params: {'plant_id': plantId});

    List<Locate> list = [];
    for (int i = 0; i < locates.length; i++) {
      list.add(Locate.fromMap(locates[i]));
    }
    return list;
  }

  Future<void> removePlant(Plant plant) async {
    await supabase
        .rpc('force_delete_plant_cascade', params: {'p_plant_id': plant.id});
  }

  Future<int> createPlantWithLocation(Plant plant, String region,
      String country, String description, Point point) async {
    final plants = await supabase.rpc('create_plant_with_locations', params: {
      'p_name_ru': plant.name_ru,
      'p_name_latin': plant.name_latin,
      'p_family_id': plant.family,
      'p_genus_id': plant.genus,
      'p_plant_type_id': plant.plant_type,
      'p_life_cycle_id': plant.life_cycle,
      'p_habitat_id': plant.habitat,
      'p_description': plant.description,
      'p_source': plant.source,
      'p_origin': plant.origin,
      'p_image': plant.image,
      'p_model': plant.model,
      'p_locations': [
        {
          "region": region,
          "country": country,
          "description": description,
          "geo_point":
              "{\"type\":\"Point\",\"coordinates\":[${point.latitude},${point.longitude}]}"
        }
      ]
    });
    return plants['plant_id'];
  }

  Future<void> updatePlantWithLocation(Plant plant, String region,
      String country, String description, Point point) async {
    await supabase.rpc('update_plant_with_locations', params: {
      'p_plant_id': plant.id,
      'p_name_ru': plant.name_ru,
      'p_name_latin': plant.name_latin,
      'p_family_id': plant.family,
      'p_genus_id': plant.genus,
      'p_plant_type_id': plant.plant_type,
      'p_life_cycle_id': plant.life_cycle,
      'p_habitat_id': plant.habitat,
      'p_description': plant.description,
      'p_source': plant.source,
      'p_origin': plant.origin,
      'p_image': plant.image,
      'p_model': plant.model,
      'p_locations': [
        {
          "region": region,
          "country": country,
          "description": description,
          "geo_point":
              "{\"type\":\"Point\",\"coordinates\":[${point.latitude},${point.longitude}]}"
        }
      ]
    });
  }

  Future<void> loadModel(String bucketName, File file, String fileName) async {
    await supabase.storage.from(bucketName).upload(fileName, file);
  }

  Future<void> clearStorage(String bucketName, String fileName) async {
    await supabase.storage.from(bucketName).remove([fileName]);
  }

  Future<void> loadPlantImage(
      String bucketName, File file, String fileName) async {
    await supabase.storage.from(bucketName).upload(fileName, file);
  }

  Future<void> addFavorite(Plant plant) async {
    await supabase.from('favourites').insert({
      'plant_id': plant.id,
      'created_at': plant.created_at,
      'user_id': supabase.auth.currentSession!.user.id,
    });
  }

  Future<void> addMyPLace(GeoDeposit geoDeposit) async {
    await supabase.from('myPlaces').insert({
      'id': geoDeposit.id,
      'name': geoDeposit.name,
      'description': geoDeposit.description,
      'image': geoDeposit.image,
      'icon_uri': geoDeposit.icon_uri,
      'latitude': geoDeposit.latitude,
      'longitude': geoDeposit.longitude,
      'user_id': supabase.auth.currentSession!.user.id,
    });
  }

  Future<Plant> addPlant(Plant plant) async {
    final response = await supabase.from('plants').insert({
      'model': plant.model,
      'name_ru': plant.name_ru,
      'name_latin': plant.name_latin,
      'family': plant.family,
      'genus': plant.genus,
      'plant_type': plant.plant_type,
      'life_cycle': plant.life_cycle,
      'habitat': plant.habitat,
      'source': plant.source,
      'origin': plant.origin,
      'created_by': supabase.auth.currentSession!.user.id,
      'image': plant.image,
      'description': plant.description,
    }).select();

    return Plant.fromMap(response.first);
  }

  Future<void> editPlant(Plant plant) async {
    await supabase.from('plants').update({
      'model': plant.model,
      'name_ru': plant.name_ru,
      'name_latin': plant.name_latin,
      'family': plant.family,
      'genus': plant.genus,
      'plant_type': plant.plant_type,
      'life_cycle': plant.life_cycle,
      'habitat': plant.habitat,
      'source': plant.source,
      'origin': plant.origin,
      'created_by': supabase.auth.currentSession!.user.id,
      'image': plant.image,
      'description': plant.description,
    }).eq('id', plant.id);
  }

  Future<void> removeMyPlaces(GeoDeposit geoDeposit) async {
    await supabase
        .from('myPlaces')
        .delete()
        .eq('user_id', supabase.auth.currentSession!.user.id)
        .eq('id', '${geoDeposit.id}');
  }

  Future<void> removeFavorite(Plant plant) async {
    await supabase
        .from('favourites')
        .delete()
        .eq('user_id', supabase.auth.currentSession!.user.id)
        .eq('plant_id', '${plant.id}');
  }

  Future<List<Favorite>> getMyFavorites() async {
    final maps = await supabase
        .from('favourites')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    List<Favorite> favorites = [];
    for (int i = 0; i < maps.length; i++) {
      favorites.add(Favorite.fromMap(maps[i]));
    }
    return favorites;
  }

   Future<Favorite> getFavorite(int id) async {
    final maps = await supabase
        .from('favourites')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id)
        .eq('plant_id', id)
        ;
    return Favorite.fromMap(maps.first);
  }

  Future<List<GeoDeposit>> getMyPLaces() async {
    final maps = await supabase
        .from('myPlaces')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    List<GeoDeposit> myPlaces = [];
    for (int i = 0; i < maps.length; i++) {
      myPlaces.add(GeoDeposit.fromMap(maps[i]));
    }
    return myPlaces;
  }

  Future<List<Ccategory>> getAllFamily() async {
    final families = await supabase.from('plant_families').select();

    List<Ccategory> Families = [];
    for (int i = 0; i < families.length; i++) {
      Families.add(Ccategory.fromMap(families[i]));
    }
    return Families;
  }

  Future<List<Ccategory>> getAllGenus() async {
    final genuses = await supabase.from('plant_genuses').select();

    List<Ccategory> Genuses = [];
    for (int i = 0; i < genuses.length; i++) {
      Genuses.add(Ccategory.fromMap(genuses[i]));
    }
    return Genuses;
  }

  Future<List<Ccategory>> getAllHabitats() async {
    final habitats = await supabase.from('plant_habitats').select();

    List<Ccategory> Habitats = [];
    for (int i = 0; i < habitats.length; i++) {
      Habitats.add(Ccategory.fromMap(habitats[i]));
    }
    return Habitats;
  }

  Future<List<Ccategory>> getAllPlantTypes() async {
    final plantTypes = await supabase.from('plant_types').select();

    List<Ccategory> PlantTypes = [];
    for (int i = 0; i < plantTypes.length; i++) {
      PlantTypes.add(Ccategory.fromMap(plantTypes[i]));
    }
    return PlantTypes;
  }

  Future<List<Ccategory>> getAllLifeCycle() async {
    final lifeCycles = await supabase.from('life_cycle').select();

    List<Ccategory> LifeCycles = [];
    for (int i = 0; i < lifeCycles.length; i++) {
      LifeCycles.add(Ccategory.fromMap(lifeCycles[i]));
    }
    return LifeCycles;
  }
}
