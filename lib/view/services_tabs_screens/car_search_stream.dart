import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';
import 'package:project/models/car.dart';
import 'package:project/view/details_screens/car_details.dart';
import 'package:project/view/services_tabs_screens/car_service.dart';
import 'package:provider/provider.dart';

class CarSearchStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cars>>.value(
      value:AppLocalization.of(context).locale.languageCode=="ar"? DataBase().getAllCarsAr:DataBase().getAllCars,
      catchError: (_, err) => throw Exception(err),
      child: CarsService(),
    );
  }
}

class CarSearch extends StatelessWidget {

  final carList;

  CarSearch({@required this.carList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: carList != null && carList.length > 0 ? carList.length : 0,
          itemBuilder: (context, index) {
            final Cars currentCar = carList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarsDetailsScreen(car: currentCar,)));
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
                            left: AppLocalization.of(context)
                                .locale
                                .languageCode ==
                                "ar"
                                ? Radius.circular(0)
                                : Radius.circular(15),
                            right: AppLocalization.of(context)
                                .locale
                                .languageCode ==
                                "ar"
                                ? Radius.circular(15)
                                : Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(currentCar.carPhotos[0]),
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
                                        currentCar.carName,
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
                                      ? const EdgeInsets.only(right: 9)
                                      : const EdgeInsets.only(left: 9, top: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                      AutoSizeText(
                                        "${currentCar.carCountry}, ${currentCar.carCity}",
                                        style: TextStyle(),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: AppLocalization.of(context)
                                      .locale
                                      .languageCode ==
                                      "ar"
                                      ? const EdgeInsets.only(right: 12, top: 4)
                                      : const EdgeInsets.only(left: 12, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${currentCar.priceOfDay.toInt()}' +
                                            '${AppLocalization.of(context).locale.languageCode=="ar"?" \جنيه":" \EGP"} ',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.favorite,
                                      color: redAccentColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        size: 19,
                                        color: orangeColor,
                                      ),
                                      Text(
                                        '${currentCar.carRate}',
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
          }),
    );
  }
}
