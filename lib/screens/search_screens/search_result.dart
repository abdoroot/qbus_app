import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qbus/models/TripFilterModel.dart';
import 'package:qbus/models/additional/GetAdditionalResponse.dart';
import 'package:qbus/res/common_padding.dart';
import 'package:qbus/res/extensions.dart';
import 'package:qbus/screens/search_screens/search_provider.dart';
import 'package:qbus/screens/trip_filter_screens/trip_filter_screen.dart';

import '../../../../navigation/navigation_helper.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/custom_text.dart';
import '../../models/trips/TripsResponse.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_views.dart';
import '../selectAddition/select_addition_screen.dart';

class SearchResult extends StatefulWidget {
  final TripFilterModel? tripFilterModel;
  final String? fromCity;
  final String? toCity;

  const SearchResult(
      {Key? key, this.tripFilterModel, this.fromCity, this.toCity})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late SearchProvider searchProvider;

  late ScrollController _scrollController;

  int index = 0;

  @override
  void initState() {
    super.initState();

    searchProvider = SearchProvider();
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.init(context: context);

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint("Ending...");
        setState(() {
          index++;
          debugPrint("EndingIndex: $index");
        });
        searchProvider.getTripsData(
            tripFilterModel: widget.tripFilterModel!, offset: index);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchProvider.getTripsData(
          tripFilterModel: widget.tripFilterModel!, offset: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          elevation: 0,
          centerTitle: false,
          title: CustomText(
              text: "${widget.fromCity ?? ""} - ${widget.toCity ?? ""}",
              textSize: 18,
              fontWeight: FontWeight.w400,
              textColor: Colors.white),
        ),
        body: Column(
          children: [
            searchProvider.isTripDataLoaded
                ? Expanded(
                    child: searchProvider.tripsResponse.data!.trips!.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            itemCount: searchProvider
                                .tripsResponse.data!.trips!.length,
                            itemBuilder: (context, i) {
                              var data =
                                  searchProvider.tripsResponse.data!.trips![i];
                              var stationA =
                                  data.startStationName!.en.toString();
                              var stationB =
                                  data.arrivalStationName!.en.toString();
                              var fees = data.fees.toString();
                              var rate = data.rate.toString();
                              var fromCityName =
                                  data.fromCityName!.en.toString();
                              var toCityName = data.toCityName!.en.toString();
                              var timeFrom = data.timeFrom.toString();
                              var timeTo = data.timeTo.toString();
                              var stops = data.stops.toString();
                              var providerName = data.providerName.toString();
                              var additionals =
                                  data.additionals!.map((e) => {e});

                              return InkWell(
                                  onTap: () {
                                    NavigationHelper.pushRoute(
                                        context, const SelectAdditionScreen());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizes!.widthRatio * 20,
                                        vertical: sizes!.heightRatio * 5),
                                    child: _card(
                                        context: context,
                                        stationA: stationA,
                                        stationB: stationB,
                                        fees: fees,
                                        rate: rate,
                                        fromCityName: fromCityName,
                                        toCityName: toCityName,
                                        timeFrom: timeFrom,
                                        timeTo: timeTo,
                                        stops: stops,
                                        providerName: providerName,
                                        additionals: data.additionals!),
                                  ));
                            })
                        : Center(
                            child: TextView.getSubHeadingTextWith15(
                                "No Data Available", Assets.latoBold,
                                color: AppColors.blueHomeColor,
                                lines: 1,
                                fontWeight: FontWeight.normal),
                          ),
                  )
                : Container(),
            CommonPadding.sizeBoxWithHeight(height: 10),
            searchProvider.isTripDataLoaded
                ? CustomButton(
                        name: "Filter Result",
                        buttonColor: appColor,
                        height: sizes!.heightRatio * 45,
                        width: double.infinity,
                        textSize: sizes!.fontRatio * 16,
                        textColor: Colors.white,
                        fontWeight: FontWeight.normal,
                        borderRadius: 5,
                        onTapped: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TripFilterScreen()));
                        },
                        padding: 0)
                    .get20HorizontalPadding()
                : Container(),
            CommonPadding.sizeBoxWithHeight(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _card(
      {required BuildContext context,
      required String stationA,
      required String stationB,
      required String fees,
      required String rate,
      required String fromCityName,
      required String toCityName,
      required String timeFrom,
      required String timeTo,
      required String stops,
      required String providerName,
      required List<Additionals> additionals}) {
    return Container(
      height: sizes!.heightRatio * 130,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.containerShadowColor,
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sizes!.heightRatio * 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                        text: "$timeFrom $fromCityName",
                        textSize: sizes!.fontRatio * 14,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff747268)),
                    const Icon(
                      Icons.play_arrow,
                      color: Color(0xff747268),
                      size: 18,
                    ),
                    CustomText(
                        text: "$timeTo $toCityName",
                        textSize: sizes!.fontRatio * 14,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff747268)),
                  ],
                ),
                Container(
                  height: sizes!.heightRatio * 20,
                  width: sizes!.widthRatio * 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: appColor),
                  child: Center(
                    child: CustomText(
                        text: "SAR $fees",
                        textSize: sizes!.fontRatio * 10,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: sizes!.heightRatio * 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                        text: stationA,
                        textSize: sizes!.fontRatio * 14,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff747268)),
                    const Icon(
                      Icons.play_arrow,
                      color: Color(0xff747268),
                      size: 18,
                    ),
                    CustomText(
                        text: stationB,
                        textSize: sizes!.fontRatio * 14,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff747268)),
                  ],
                ),
                CustomText(
                    text: "$stops Stops",
                    textSize: sizes!.fontRatio * 14,
                    fontWeight: FontWeight.w400,
                    textColor: const Color(0xff747268))
              ],
            ),
            SizedBox(
              height: sizes!.heightRatio * 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: providerName,
                    textSize: sizes!.fontRatio * 16,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xff747268)),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 18,
                    ),
                    CustomText(
                        text: rate,
                        textSize: sizes!.fontRatio * 16,
                        fontWeight: FontWeight.normal,
                        textColor: const Color(0xff747268)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: sizes!.heightRatio * 10,
            ),
            SizedBox(
                height: sizes!.heightRatio * 20,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: additionals.length,
                    itemBuilder: (context, index) {
                      var data = additionals[index].en;
                      return CustomText(
                          text: "$data /",
                          textSize: sizes!.fontRatio * 14,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey);
                    }))
          ],
        ),
      ),
    );
  }
}
