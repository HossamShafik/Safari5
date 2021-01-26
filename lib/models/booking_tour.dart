import 'package:cloud_firestore/cloud_firestore.dart';

class BookingTour{

  String bookingId;
  int totalPrice,numOfPersons,duration;
  DateTime startOfTour;


  BookingTour({
    this.bookingId,
    this.duration,
    this.totalPrice,
    this.numOfPersons,
    this.startOfTour,
    });

  List<BookingTour> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BookingTour(
        bookingId: doc.get('booking_Id') ?? '',
        duration: doc.get('duration') ?? '',
        totalPrice: doc.get('totalPrice') != null ? doc.get(
            'totalPrice') is double ? doc.get('totalPrice') : doc.get(
            'totalPrice') is String ? double.parse(
            doc.get('totalPrice')):doc.get('totalPrice').toInt() : '',
        numOfPersons: doc.get('numOfPersons') ?? '',
        startOfTour: doc.get('startOfTour') ?? '',


      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      'booking_Id': bookingId,
      'duration': duration,
      'totalPrice': totalPrice,
      'numOfPersons': numOfPersons,
      'startOfTour':startOfTour,
    };
  }
}