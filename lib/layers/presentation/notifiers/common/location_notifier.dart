import 'package:flutter/foundation.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/geo_deposit.dart';
import 'package:geolog/layers/domain/entities/locate.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationNotifier extends ChangeNotifier {
  Locate? deposit;
  List<Locate> deposits = [];
  List<GeoDeposit> myPlaces = [];
  YandexMapController? controller;
  int plantId = 0;
  Plant? plant;

  LocationNotifier(int idPlant) {
    plantId = idPlant;
    notifyListeners();
    _setup();
  }

  void _setup() async {
    SupabaseSource source = SupabaseSource();
    deposits = await source.getDeposits(plantId);
    for (int i = 0; i < deposits.length; i++) {
      points.add(
        PlacemarkMapObject(
            onTap: (object, point) async {
              for (int i = 0; i < deposits.length; i++) {
                debugPrint(point.latitude.round().toString());
                debugPrint(point.longitude.round().toString());
                debugPrint(double.parse(
                        deposits[i].geo_point!.coordinates[1].toString())
                    .round()
                    .toString());
                debugPrint(double.parse(
                        deposits[i].geo_point!.coordinates.first.toString())
                    .round()
                    .toString());
                if (double.parse(
                        deposits[i].geo_point!.coordinates[1].toString())
                    .round() ==
                        point.latitude.round() &&
                    double.parse(
                        deposits[i].geo_point!.coordinates.first.toString())
                    .round() ==
                        point.longitude.round()) {
                  deposit = deposits[i];
                  plant = await source.getPlant(deposit!.plant_id);
                  notifyListeners();
                }
              }
            },
            opacity: 1,
            mapId: MapObjectId(deposits[i].id.toString()),
            point: Point(
                latitude: deposits[i].geo_point!.coordinates[1],
                longitude: deposits[i].geo_point!.coordinates.first),
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                scale: 0.1,
                image: BitmapDescriptor.fromAssetImage(
                    'assets/image/location.png')))),
      );
    }
    notifyListeners();
  }

  void close() {
    deposit = null;
    plant = null;
    notifyListeners();
  }

  void addMyPlaces(GeoDeposit geoDeposit) async {
    SupabaseSource source = SupabaseSource();
    await source.addMyPLace(geoDeposit);
    myPlaces = await source.getMyPLaces();
    notifyListeners();
  }

  void removeMyPlaces(GeoDeposit geoDeposit) async {
    SupabaseSource source = SupabaseSource();
    await source.removeMyPlaces(geoDeposit);
    myPlaces = await source.getMyPLaces();
    notifyListeners();
  }

  List<MapObject> points = [
    //     PlacemarkMapObject(
    //     opacity: 1,
    //     mapId: const MapObjectId('2'),
    // point: const Point(latitude: 67.9500, longitude: 40.2000),
    // icon: PlacemarkIcon.single(
    //   PlacemarkIconStyle(
    //     scale: 0.11,
    //     image: BitmapDescriptor.fromAssetImage('assets/image/basalt_point.png')))
    //     ),
    //     PlacemarkMapObject(
    //     opacity: 1,
    //     mapId: const MapObjectId('3'),
    // point: const Point(latitude: 40.0691, longitude: 45.0382),
    // icon: PlacemarkIcon.single(
    //   PlacemarkIconStyle(
    //     scale: 0.11,
    //     image: BitmapDescriptor.fromAssetImage('assets/image/basalt_point.png')))
    //     ),
    //     PlacemarkMapObject(
    //     opacity: 1,
    //     mapId: const MapObjectId('4'),
    // point: const Point(latitude: 61.7868, longitude: 34.3469),
    // icon: PlacemarkIcon.single(
    //   PlacemarkIconStyle(
    //     scale: 0.11,
    //     image: BitmapDescriptor.fromAssetImage('assets/image/gneiss_point.png')))
    //     ),
    //     PlacemarkMapObject(
    //     opacity: 1,
    //     mapId: const MapObjectId('5'),
    // point: const Point(latitude:  7.8731, longitude: 80.7718),
    // icon: PlacemarkIcon.single(
    //   PlacemarkIconStyle(
    //     scale: 0.11,
    //     image: BitmapDescriptor.fromAssetImage('assets/image/gneiss_point.png')))
    //     ),
  ];
}
