import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentTour{
  String bookingId;
  DateTime paymentDate;
  int paymentPrice;

  PaymentTour({ this.bookingId, this.paymentDate, this.paymentPrice});

  List<PaymentTour> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PaymentTour(

        bookingId: doc.get('booking_Id') ?? '',
        paymentDate: doc.get('paymentDate') ?? '',
        paymentPrice: doc.get('paymentPrice') !=null ?doc.get(
            'paymentPrice') is int ? doc.get('paymentPrice') : doc.get(
            'paymentPrice') is String ? int.parse(
            doc.get('paymentPrice')):doc.get('paymentPrice').toInt() : '',

      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {

      'booking_Id': bookingId,
      'paymentDate': paymentDate,
      'paymentPrice': paymentPrice,
    };
  }
}