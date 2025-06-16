// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class EditPlantNotifier extends ChangeNotifier {
  String name_ru = "";
  String name_latin = "";
  String source = "";
  String origin = "";
  String description = "";
  bool isLoading = false;

  String country = "";
  String region = "";
  String descriptionRegion = "";

  Point? point;

  String? fileName;
  PlatformFile? pickedFile;

  Uint8List? profileImage;

  XFile? file;

  late ValueNotifier<String> dropFamilyValue = ValueNotifier('');
  late ValueNotifier<String> dropGenusValue = ValueNotifier('');
  late ValueNotifier<String> dropPLantTypeValue = ValueNotifier('');
  late ValueNotifier<String> dropLifeCycleValue = ValueNotifier('');
  late ValueNotifier<String> dropHabitatValue = ValueNotifier('');

  List<Ccategory> families = [];
  List<Ccategory> genuses = [];
  List<Ccategory> plant_types = [];
  List<Ccategory> life_cycles = [];
  List<Ccategory> habitats = [];

  List<String> familiesStrings = [];
  List<String> genusesStrings = [];
  List<String> plant_typesStrings = [];
  List<String> life_cyclesStrings = [];
  List<String> habitatsStrings = [];

  int family = 0;
  int genus = 0;
  int plant_type = 0;
  int life_cycle = 0;
  int habitat = 0;

  Plant plant;

  EditPlantNotifier(
    this.plant,
  ) {
    _setup();
  }

  void _setup() async {
    setLoad();
    SupabaseSource supabaseSource = SupabaseSource();
    families = await supabaseSource.getAllFamily();
    genuses = await supabaseSource.getAllGenus();
    plant_types = await supabaseSource.getAllPlantTypes();
    life_cycles = await supabaseSource.getAllLifeCycle();
    habitats = await supabaseSource.getAllHabitats();

    for (int i = 0; i < families.length; i++) {
      familiesStrings.add(families[i].name);
    }

    for (int i = 0; i < genuses.length; i++) {
      genusesStrings.add(genuses[i].name);
    }

    for (int i = 0; i < plant_types.length; i++) {
      plant_typesStrings.add(plant_types[i].name);
    }

    for (int i = 0; i < life_cycles.length; i++) {
      life_cyclesStrings.add(life_cycles[i].name);
    }

    for (int i = 0; i < habitats.length; i++) {
      habitatsStrings.add(habitats[i].name);
    }

    name_ru = plant.name_ru;
    name_latin = plant.name_latin;
    source = plant.source;
    origin = plant.origin;
    description = plant.description;

    family = plant.family ?? 0;
    genus = plant.genus ?? 0;
    plant_type = plant.plant_type ?? 0;
    life_cycle = plant.life_cycle ?? 0;
    habitat = plant.habitat ?? 0;

    for (int i = 0; i < families.length; i++) {
      if (families[i].id == family) {
        dropFamilyValue = ValueNotifier(families[i].name);
      }
    }

    for (int i = 0; i < genuses.length; i++) {
      if (genuses[i].id == genus) {
        dropGenusValue = ValueNotifier(genuses[i].name);
      }
    }

    for (int i = 0; i < plant_types.length; i++) {
      if (plant_types[i].id == plant_type) {
        dropPLantTypeValue = ValueNotifier(plant_types[i].name);
      }
    }

    for (int i = 0; i < life_cycles.length; i++) {
      if (life_cycles[i].id == life_cycle) {
        dropLifeCycleValue = ValueNotifier(life_cycles[i].name);
      }
    }

    for (int i = 0; i < habitats.length; i++) {
      if (habitats[i].id == habitat) {
        dropHabitatValue = ValueNotifier(habitats[i].name);
      }
    }

    final val = await supabaseSource.getDeposits(plant.id);
    if (val.isNotEmpty) {
      point = Point(
          latitude: val.first.geo_point!.coordinates[1],
          longitude: val.first.geo_point!.coordinates.first);
      country = val.first.country;
      region = val.first.region;
      descriptionRegion = val.first.description;
    }

    setLoad();
  }

  void setPoint(Point valuePoint) {
    point = valuePoint;
    notifyListeners();
  }

  void setLoad() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void pickImage(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) return;
    profileImage = await file!.readAsBytes();
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> editPlant() async {
    setLoad();
    SupabaseSource supabaseSource = SupabaseSource();

    List<String> pathImageSegments = [];
    List<String> pathModelSegments = [];

    if (file != null) {
      pathImageSegments = file!.path.split('/');
      if (plant.image == "(${plant.id})${pathImageSegments.last}") {
        await supabaseSource.clearStorage('images', plant.image);
      }
      if (plant.image != "(${plant.id})${pathImageSegments.last}") {
        await supabaseSource.clearStorage('images', plant.image);
      }
      await supabaseSource.loadPlantImage(
          'images', File(file!.path), "(${plant.id})${pathImageSegments.last}");
    }

    if (pickedFile != null) {
      pathModelSegments = pickedFile!.path!.split('/');
      if (plant.model == "(${plant.id})${pathModelSegments.last}") {
        await supabaseSource.clearStorage('models', plant.model);
      }
      if (plant.model != "(${plant.id})${pathModelSegments.last}") {
        await supabaseSource.clearStorage('models', plant.model);
      }
      await supabaseSource.loadModel('models', File(pickedFile!.path as String),
          "(${plant.id})${pathModelSegments.last}");
    }

    

    Plant plantEdit = Plant(
        id: plant.id,
        created_at: plant.created_at,
        model: pickedFile != null
            ? "(${plant.id})${pathModelSegments.last}"
            : plant.model,
        name_ru: name_ru,
        description: description,
        name_latin: name_latin,
        family: family,
        genus: genus,
        plant_type: plant_type,
        life_cycle: life_cycle,
        habitat: habitat,
        source: source,
        origin: origin,
        created_by: plant.created_by,
        image: file != null
            ? "(${plant.id})${pathImageSegments.last}"
            : plant.image);

    await supabaseSource.updatePlantWithLocation(
        plantEdit, region, country, descriptionRegion, point!);

    setLoad();
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['glb']);

      if (result != null) {
        fileName = result.files.single.name;
        pickedFile = result.files.single;
      }

      notifyListeners();
    } catch (e) {
      print("Ошибка при выборе файла: $e");
    }
  }
}
