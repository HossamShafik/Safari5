import 'package:cloud_firestore/cloud_firestore.dart';

class BookingHotel{

  String bookingId,roomType;
  int totalPrice,duration;
  DateTime  startOfStay, endOfStay;


  BookingHotel({
      this.bookingId,
      this.duration,
      this.roomType,
      this.totalPrice,
      this.startOfStay,
      this.endOfStay});

  List<BookingHotel> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BookingHotel(
        bookingId: doc.get('booking_Id') ?? '',
        duration: doc.get('duration') ?? '',
        roomType: doc.get('roomType') ?? '',
        totalPrice: doc.get('totalPrice') != null ? doc.get(
            'totalPrice') is double ? doc.get('totalPrice') : doc.get(
            'totalPrice') is String ? double.parse(
            doc.get('totalPrice')):doc.get('totalPrice').toInt() : '',
        startOfStay: doc.get('startOfStay') ?? '',
        endOfStay: doc.get('endOfStay') ?? '',

      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      'booking_Id': bookingId,
      'duration': duration,
      'roomType': roomType,
      'totalPrice': totalPrice,
      'startOfStay': startOfStay,
      'endOfStay': endOfStay,
    };
  }
}