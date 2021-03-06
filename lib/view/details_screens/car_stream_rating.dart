import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';
import 'package:project/models/car.dart';
import 'package:project/models/rating_car.dart';
import 'package:provider/provider.dart';


class CarRatingStream extends StatelessWidget {
  final Cars carId;

  CarRatingStream({this.carId});

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<CarRating>>.value(
      value: DataBase().getAllCarComment(carId),
      catchError: (_, err) => throw Exception(err),
      child: CarRatingWidget(),
    );
  }
}

class CarRatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carRatingList = Provider.of<List<CarRating>>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: carRatingList != null && carRatingList.length > 0 ? carRatingList.length : 0,
        itemBuilder: (context, index) {
          final CarRating currentRate = carRatingList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundColor: whiteColor,
                            radius: 22,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  currentRate.photoUrl),
                              radius: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                AppLocalization.of(context)
                                    .locale
                                    .languageCode ==
                                    "ar"
                                    ? const EdgeInsets.only(
                                    right: 10)
                                    : const EdgeInsets.only(
                                    left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.40,
                                      child: AutoSizeText(
                                        currentRate.username,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                            color: pink600Color),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                    ),
                                    Text(
                                      "${AppLocalization.of(context).locale.languageCode=="ar"?currentRate.timeStampAr:currentRate.timeStamp}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: grey600Color),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                AppLocalization.of(context)
                                    .locale
                                    .languageCode ==
                                    "ar"
                                    ? const EdgeInsets.only(
                                    top: 2, right: 8)
                                    : const EdgeInsets.only(
                                    top: 2, left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      (Icons.star_rate_rounded),
                                      color: orangeColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      currentRate.rate.toString(),
                                      style: TextStyle(
                                          color: grey700Color,
                                          fontWeight:
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            currentRate.comment),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}