import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/favorite_car.dart';
import 'package:project/models/favorite_hotel.dart';
import 'package:project/models/favorite_tour.dart';
import 'package:project/models/payment_car.dart';
import 'package:project/models/payment_hotel.dart';
import 'package:project/models/payment_tour.dart';
import 'package:project/models/rating_car.dart';
import 'package:project/models/rating_tour.dart';
import 'package:project/models/booking_car.dart';
import 'package:project/models/booking_hotel.dart';
import 'package:project/models/booking_tour.dart';
import 'package:project/models/car.dart';
import 'package:project/models/hotel.dart';
import 'package:project/models/rating_hotel.dart';
import 'package:project/models/tour.dart';
import 'package:project/models/users.dart';

class DataBase {
 final CollectionReference hotelCollection= FirebaseFirestore.instance.collection("Hotels");
 final CollectionReference hotelArCollection= FirebaseFirestore.instance.collection("HotelsAr");
 final CollectionReference carCollection= FirebaseFirestore.instance.collection("Cars");
 final CollectionReference carArCollection= FirebaseFirestore.instance.collection("CarsAr");
 final CollectionReference tourCollection= FirebaseFirestore.instance.collection("Tours");
 final CollectionReference tourArCollection= FirebaseFirestore.instance.collection("ToursAr");
 final CollectionReference travelerCollection= FirebaseFirestore.instance.collection("Travelers");
 final CollectionReference paymentCollection= FirebaseFirestore.instance.collection("Payment");

  Future<void> addTraveler(Travelers travelers) async {

     return await travelerCollection.doc(travelers.id).set(travelers.toJson());
  }



 Future<void> addRatingHotel(HotelRating rate,Travelers travelers,Hotel hotel) async {
   return await hotelCollection.doc(hotel.hotelId).collection("HotelRating").doc(travelers.id).set(rate.toJson());
 }
 Future<void> updateRatingHotel(HotelRating rate,Travelers travelers,Hotel hotel) async {
   return await hotelCollection.doc(hotel.hotelId).collection("HotelRating").doc(travelers.id).update(rate.toJson());
 }

 Future<void> addRatingTour(TourRating rate,Travelers travelers,Tour tour) async {
   return await tourCollection.doc(tour.tourId).collection("TourRating").doc(travelers.id).set(rate.toJson());
 }

 Future<void> addRatingCar(CarRating rate,Travelers travelers,Cars cars) async {
   return await carCollection.doc(cars.id).collection("CarRating").doc(travelers.id).set(rate.toJson());
 }

 Stream<List<HotelRating>>  getAllHotelComment(Hotel hotel) {
   return hotelCollection.doc(hotel.hotelId).collection("HotelRating").orderBy("timeStamp").snapshots().map(HotelRating().fromQuery);
 }


 Stream<List<TourRating>>  getAllTourComment(Tour tour) {
   return tourCollection.doc(tour.tourId).collection("TourRating").orderBy("timeStamp").snapshots().map(TourRating().fromQuery);
 }

 Stream<List<CarRating>>  getAllCarComment(Cars cars) {
   return carCollection.doc(cars.id).collection("CarRating").orderBy("timeStamp").snapshots().map(CarRating().fromQuery);
 }

 Future<void> addBookingHotel(BookingHotel booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingHotel").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void> addBookingCar(BookingCar booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingCar").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void> addBookingTour(BookingTour booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingTour").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void> addBookingHotelAr(BookingHotel booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingHotelAr").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void> addBookingCarAr(BookingCar booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingCarAr").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void> addBookingTourAr(BookingTour booking,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingTourAr").doc(booking.bookingId).set(booking.toJson());
 }

 Future<void>addFavoritesHotel(FavoriteHotel fav,Travelers travelers,Hotel hotel)async{
   return await travelerCollection.doc(travelers.id).collection("FavHotel").doc(hotel.hotelId).set(fav.toJson());
 }

 Future<void>addFavoritesTour(FavoriteTour fav,Travelers travelers,Tour tour)async{
   return await travelerCollection.doc(travelers.id).collection("FavTour").doc(tour.tourId).set(fav.toJson());
 }

 Future<void>addFavoritesCar(FavoriteCar fav,Travelers travelers,Cars cars)async{
   return await travelerCollection.doc(travelers.id).collection("FavCar").doc(cars.id).set(fav.toJson());
 }

 Future<void> addPaymentHotel(PaymentHotel payment,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingHotel").doc(payment.bookingId).collection("PaymentHotel").doc().set(payment.toJson());
 }


 Future<void> addPaymentTour(PaymentTour payment,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingTour").doc(payment.bookingId).collection("PaymentTour").doc().set(payment.toJson());
 }


 Future<void> addPaymentCar(PaymentCar payment,Travelers travelers) async {
   return await travelerCollection.doc(travelers.id).collection("BookingCar").doc(payment.bookingId).collection("PaymentCar").doc().set(payment.toJson());
 }

 Stream<List<FavoriteHotel>> getFavoriteHotels(Travelers travelers) {
   return travelerCollection.doc(travelers.id).collection("FavHotel").snapshots().map(FavoriteHotel().fromQuery);
 }

 Stream<List<FavoriteTour>> getFavoriteTour(Travelers travelers) {
   return travelerCollection.doc(travelers.id).collection("FavTour").snapshots().map(FavoriteTour().fromQuery);
 }

 Stream<List<FavoriteCar>> getFavoriteCar(Travelers travelers) {
   return travelerCollection.doc(travelers.id).collection("FavCar").snapshots().map(FavoriteCar().fromQuery);
 }

  // stream for hotels
  Stream<List<Hotel>> get getAllHotels {
    return hotelCollection.orderBy("hotelName").snapshots().map(Hotel().fromQuery);
  }

  Stream<List<Hotel>> get getHotels {
  return hotelCollection.limit(4).snapshots().map(Hotel().fromQuery);
  }

 // stream for hotels
 Stream<List<Hotel>> get getAllHotelsAr {
   return hotelArCollection.orderBy("hotelName").snapshots().map(Hotel().fromQuery);
 }

 Stream<List<Hotel>> get getHotelsAr {
   return hotelArCollection.limit(4).snapshots().map(Hotel().fromQuery);
 }

  // Future<void> addNewHotel(Hotel hotel)async{
  //   await hotelCollection.doc().set(hotel.toJson());
  // }


  // stream for cars
  Stream<List<Cars>> get getAllCars {
    return carCollection.orderBy("CarName").snapshots().map(Cars().fromQuery);
  }

  Stream<List<Cars>> get getCars {
    return carCollection.limit(4).snapshots().map(Cars().fromQuery);
  }


 // stream for cars
 Stream<List<Cars>> get getAllCarsAr {
   return carArCollection.orderBy("CarName").snapshots().map(Cars().fromQuery);
 }

 Stream<List<Cars>> get getCarsAr {
   return carArCollection.limit(4).snapshots().map(Cars().fromQuery);
 }

  // Future<void> addNewCar(Cars car)async{
  //   await carCollection.doc().set(car.toJson());
  // }


  // stream for tours
  Stream<List<Tour>> get getAllTours {
    return tourCollection.orderBy("PlaceName").snapshots().map(Tour().fromQuery);
  }

  // stream for tours
  Stream<List<Tour>> get getTours {
    return tourCollection.limit(4).snapshots().map(Tour().fromQuery);
  }


 Stream<List<Tour>> get getAllToursAr {
   return tourArCollection.orderBy("PlaceName").snapshots().map(Tour().fromQuery);
 }

 // stream for tours
 Stream<List<Tour>> get getToursAr {
   return tourArCollection.limit(4).snapshots().map(Tour().fromQuery);
 }

  // Future<void> addNewTour(Tour tour)async{
  //   await tourCollection.doc().set(tour.toJson());
  // }

}
