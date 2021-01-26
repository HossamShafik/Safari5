import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';
import 'package:project/models/favorite_hotel.dart';
import 'package:project/models/hotel.dart';
import 'package:project/models/users.dart';
import 'package:project/view/details_screens/hotel_details.dart';
import 'package:provider/provider.dart';

class FavoritesHotelStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FavoriteHotel>>.value(
      value: DataBase().getFavoriteHotels(
          Travelers(id: FirebaseAuth.instance.currentUser.uid)),
      catchError: (_, err) => throw Exception(err),
      child: FavoritesHotels(),
    );
  }
}

class FavoritesHotels extends StatefulWidget {
  @override
  _FavoritesHotelsState createState() => _FavoritesHotelsState();
}

class _FavoritesHotelsState extends State<FavoritesHotels> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final hotelList = Provider.of<List<FavoriteHotel>>(context);

    return ListView.builder(
        itemCount:
            hotelList != null && hotelList.length > 0 ? hotelList.length : 0,
        itemBuilder: (context, index) {
          final FavoriteHotel currentHotel = hotelList[index];

          return Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 5,
            ),
            child: InkWell(
              onTap: () {
                 //Navigator.push(context, MaterialPageRoute(builder: (context)=>HotelsDetailsScreen(hotel: ,)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left:
                              AppLocalization.of(context).locale.languageCode ==
                                      "ar"
                                  ? Radius.circular(0)
                                  : Radius.circular(15),
                          right:
                              AppLocalization.of(context).locale.languageCode ==
                                      "ar"
                                  ? Radius.circular(15)
                                  : Radius.circular(0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(currentHotel.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: AppLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? EdgeInsets.only(right: 12, top: 12)
                                    : EdgeInsets.only(left: 12, top: 12),
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  child: AutoSizeText(
                                    currentHotel.hotelName,
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: AppLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        'ar'
                                    ? const EdgeInsets.only(right: 9, top: 8)
                                    : const EdgeInsets.only(left: 9, top: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.45,
                                      child: AutoSizeText(
                                        '${currentHotel.hotelCountry}, ${currentHotel.hotelCity}',
                                        style: TextStyle(),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: AppLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? const EdgeInsets.only(right: 12, top: 8)
                                    : const EdgeInsets.only(left: 12, top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${currentHotel.price}' + ' EGP',
                                      style: TextStyle(
                                        color: pink600Color.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: AppLocalization.of(context)
                                        .locale
                                        .languageCode ==
                                    "ar"
                                ? const EdgeInsets.only(
                                    top: 12, bottom: 14, left: 12)
                                : const EdgeInsets.only(
                                    top: 12, bottom: 16, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFav=currentHotel.fav;
                                    });
                                  },
                                  child: isFav
                                      ? Icon(
                                    Icons.favorite_border_outlined,
                                    color: redAccentColor,
                                    size: 30,
                                  )
                                : Icon(
                                          Icons.favorite,
                                          color: redAccentColor,
                                          size: 30,
                                        )

                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      size: 19,
                                      color: orangeColor,
                                    ),
                                    Text(
                                      '${currentHotel.rate}',
                                      style: TextStyle(
                                          color: grey700Color,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
