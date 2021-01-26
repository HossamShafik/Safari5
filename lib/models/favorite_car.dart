import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteCar{
  String uid,carId;
  bool fav;

  FavoriteCar({this.uid, this.carId, this.fav});


  List<FavoriteCar> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FavoriteCar(
        uid: doc.get('traveler_id') ?? '',
        carId: doc.get('Car_Id') ?? '',
        fav: doc.get('fav') ?? '',

      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      'traveler_id': uid,
      'Car_Id': carId,
      'fav': fav,
    };
  }
}