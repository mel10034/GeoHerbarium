// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreatePlantPageNotifier extends ChangeNotifier {
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

  CreatePlantPageNotifier() {
    _setup();
  }

  void _setup() async {
    SupabaseSource source = SupabaseSource();
    families = await source.getAllFamily();
    genuses = await source.getAllGenus();
    plant_types = await source.getAllPlantTypes();
    life_cycles = await source.getAllLifeCycle();
    habitats = await source.getAllHabitats();

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
  }

  void notify() {
    notifyListeners();
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

  Future<void> createPlant() async {
    setLoad();
    SupabaseSource supabaseSource = SupabaseSource();

    List<String> pathImageSegments = file!.path.split('/');
    List<String> pathModelSegments = pickedFile!.path!.split('/');

    Plant plant = Plant(
        id: 1,
        created_at: "created_at",
        model: pathModelSegments.last,
        name_ru: name_ru,
        family: family,
        genus: genus,
        description: description,
        name_latin: name_latin,
        plant_type: plant_type,
        life_cycle: life_cycle,
        habitat: habitat,
        source: source,
        origin: origin,
        created_by: "created_by",
        image: pathImageSegments.last);

    int plantId = await supabaseSource.createPlantWithLocation(
        plant, region, country, description, point as Point);

    await supabaseSource.loadPlantImage(
        'images', File(file!.path), "($plantId)${pathImageSegments.last}");
    await supabaseSource.loadModel('models', File(pickedFile!.path as String),
        "($plantId)${pathModelSegments.last}");

    plant = Plant(
        id: plantId,
        created_at: "created_at",
        model: "($plantId)${pathModelSegments.last}",
        name_ru: name_ru,
        description: description,
        name_latin: name_latin,
        plant_type: plant_type,
        life_cycle: life_cycle,
        family: family,
        genus: genus,
        habitat: habitat,
        source: source,
        origin: origin,
        created_by: "created_by",
        image: "($plantId)${pathImageSegments.last}");

    await supabaseSource.updatePlantWithLocation(
        plant, region, country, description, point as Point);

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
