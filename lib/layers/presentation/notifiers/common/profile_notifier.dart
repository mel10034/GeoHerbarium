import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/favorite.dart';
import 'package:geolog/layers/domain/entities/geo_deposit.dart';
import 'package:geolog/layers/domain/entities/profile.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_in.dart';
import 'package:geolog/layers/presentation/style/colors.dart';

class ProfileNotifier extends ChangeNotifier {
  Profile? _profile;
  String nickname = '';
  Uint8List? bytes;
  List<GeoDeposit> myPlaces = [];
  List<Favorite> favorites = [];
  List<Plant> myFavorites = [];
  bool isLoading = false;

  ProfileNotifier() {
    _setup();
  }

  void _setup() async {
    setLoad();
    SupabaseSource source = SupabaseSource();
    _profile = await source.getMyProfile();
    favorites = await source.getMyFavorites();
    // myPlaces = await source.getMyPLaces();
    nickname = _profile!.fio;
    // for (int i = 0; i < myPlaces.length; i++) {
    //   myPlacesImage
    //       .add(await source.downloadAsset('images', myPlaces[i].image));
    // }
    for (int i = 0; i < favorites.length; i++) {
      myFavorites
          .add(await source.getPlant(favorites[i].plant_id));
    }
    if(_profile!.avatar != null){
      bytes =  base64Decode(_profile!.avatar as String);
    }
    setLoad();
  }

  void setLoad() async {
    isLoading = !isLoading;
    notifyListeners();
  }

  void logOut(BuildContext context) async {
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
                    child: CircularProgressIndicator(
                      color: MyColors.brandColor,
                    )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
    SupabaseSource source = SupabaseSource();
    await source.logOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignIn()),
            (route) => false));
  }

  void removeFavorite(int plantId) async {
    SupabaseSource source = SupabaseSource();
    Plant plant = await source.getPlant(plantId);
    await source.removeFavorite(plant);
    favorites = await source.getMyFavorites();
    notifyListeners();
  }

  void removeMyPlace(GeoDeposit geoDeposit) async {
    SupabaseSource source = SupabaseSource();
    await source.removeMyPlaces(geoDeposit);
    myPlaces = await source.getMyPLaces();
    notifyListeners();
  }
}
