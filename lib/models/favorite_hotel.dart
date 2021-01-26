import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteHotel{

 String uid,hotelId,hotelName, hotelCity, hotelCountry,image;
 bool fav;
 double price,rate;



 FavoriteHotel({this.uid, this.hotelId, this.image, this.hotelName,
      this.hotelCity, this.hotelCountry, this.fav, this.price, this.rate});

  List<FavoriteHotel> fromQuery(QuerySnapshot snapshot) {
   return snapshot.docs.map((doc) {
     return FavoriteHotel(
       uid: doc.get('traveler_id') ?? '',
       hotelId: doc.get('hotel_Id') ?? '',
       fav: doc.get('fav') ?? '',
       rate: doc.get('hotelRate') !=null ?doc.get(
           'hotelRate') is double ? doc.get('hotelRate') : doc.get(
           'hotelRate') is String ? double.parse(
           doc.get('hotelRate')):doc.get('hotelRate').toDouble() : '',
       hotelCity: doc.get('hotelCity') ?? '',
       hotelCountry: doc.get('hotelCountry') ?? '',
       hotelName: doc.get('hotelName') ?? '',
       price: doc.get('priceOfDay') != null ? doc.get(
           'priceOfDay') is double ? doc.get('priceOfDay') : doc.get(
           'priceOfDay') is String ? double.parse(
           doc.get('priceOfDay')):doc.get('priceOfDay').toDouble() : '',
       image: doc.get('images') ?? '',

     );
   }).toList();
 }



 Map<String, dynamic> toJson() {
   return {
     'traveler_id': uid,
     'hotel_Id': hotelId,
     'fav': fav,
     'hotelRate': rate,
     'hotelCity': hotelCity,
     'hotelCountry': hotelCountry,
     'hotelName': hotelName,
     'priceOfDay': price,
     'images': image,


   };
 }
}