// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:geolog/layers/presentation/pages/common/main_screen.dart';

class AboutPlantNotifier extends ChangeNotifier {
  int favoritePlant;
  Plant? plant;
  SupabaseSource source = SupabaseSource();
  String genus = "";
  String family = "";
  String description = "";
  String habitat = "";
  String life_cycle = "";
  String plant_type = "";

  bool isDeleteLoad = false;

  AboutPlantNotifier({
    required this.favoritePlant,
  }) {
    _setup();
  }

  void _setup() async {
    SupabaseSource source = SupabaseSource();
    plant = await source.getPlant(favoritePlant);
    if (plant!.genus != null) {
      Ccategory gen = await source.getGenus(plant!.genus);
      genus = gen.name;
    }
    if (plant!.family != null) {
      Ccategory fam = await source.getFamily(plant!.family);
      family = fam.name;
    }
    description = plant == null ? "" : plant!.description;
    Ccategory hab = await source.getHabitat(plant!.habitat);
    habitat = hab.name;
    Ccategory life_c = await source.getLifeCycle(plant!.life_cycle);
    life_cycle = life_c.name;
    Ccategory plant_t = await source.getPlantType(plant!.plant_type);
    plant_type = plant_t.name;
    notifyListeners();
  }

  void deleteLoad(bool value) {
    isDeleteLoad = value;
    notifyListeners();
  }

  void removePlant(Plant plant, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
          backgroundColor: Colors.grey.shade900,
          child: SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                SizedBox(
                    width: 32.w,
                    height: 32.h,
                    child: const CircularProgressIndicator(
                      color: Colors.red,
                    )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
    SupabaseSource source = SupabaseSource();
    await source.removePlant(plant);
    await source.clearStorage('images', plant.image);
    await source.clearStorage('models', plant.model);
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => MainPage(selectIndex: 0)),
        (f) => false);
  }
}
