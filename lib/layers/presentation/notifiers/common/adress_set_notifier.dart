import 'package:flutter/foundation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SetaddresspageNotifier extends ChangeNotifier {
  

  YandexMapController? controller;

  List<PlacemarkMapObject> mapObjects = [];

  Point? choosedPoint;

  late DateTime startDate;

  late DateTime endDate;

 

 

  void chooseAdress(Point point) {
    choosedPoint = point;

    mapObjects.clear();


    mapObjects.add(
      PlacemarkMapObject(
          onTap: (object, point) async {},
          opacity: 1,
          mapId: const MapObjectId("choosePoint"),
          point: Point(latitude: point.latitude, longitude: point.longitude),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              scale: 0.15,
              image: BitmapDescriptor.fromAssetImage(
                  "assets/image/location.png")))),
    );

    notifyListeners();
  }
}
