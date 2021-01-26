import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteTour{
  String uid,tourId;
  bool fav;

  FavoriteTour({this.uid, this.tourId, this.fav});


  List<FavoriteTour> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FavoriteTour(
        uid: doc.get('traveler_id') ?? '',
        tourId: doc.get('Tour_Id') ?? '',
        fav: doc.get('fav') ?? '',

      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      'traveler_id': uid,
      'Tour_Id': tourId,
      'fav': fav,
    };
  }
}