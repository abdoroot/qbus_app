import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qbus/navigation/navigation_helper.dart';
import 'package:qbus/network_manager/api_url.dart';
import 'package:qbus/screens/get_started_screens/get_started_provider.dart';
import 'package:qbus/utils/constant.dart';
import 'package:qbus/widgets/counter.dart';
import 'package:qbus/widgets/custom_text.dart';
import 'package:qbus/widgets/package_card.dart';
import 'package:qbus/language.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textField.dart';
import '../explore_screens/explore_screen.dart';
import '../search_screens/search_result.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool oneRoad = false;
  bool roundTrip = false;
  bool multiTrip = false;
  int number = 0;
  final TextEditingController _email = TextEditingController();

  late GetStartedProvider getStartedProvider;

  @override
  void initState() {
    super.initState();
    getStartedProvider = GetStartedProvider();
    getStartedProvider =
        Provider.of<GetStartedProvider>(context, listen: false);
    getStartedProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getStartedProvider.getPackagesData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GetStartedProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: _getUI(context)),
      ),
    );
  }

  void _changeLanguage(lang) {
    const Locale("ar", 'Ar');
    debugPrint(lang.name);
  }

  Widget _getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 13,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const CustomText(
              text: "Book Bus\nLet's Do Now!",
              textSize: 18,
              fontWeight: FontWeight.w500,
              textColor: Colors.black,
              textAlign: TextAlign.start,
            ),
            DropdownButton(
              onChanged: (language) {
                _changeLanguage(language);
              },
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                size: 28,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                      (language) => DropdownMenuItem(
                            value: language,
                            child: Row(
                              children: <Widget>[
                                Text(language.flag),
                                Text(language.name),
                              ],
                            ),
                          ))
                  .toList(),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              checkBox(context, oneRoad, "One Way", () {
                multiTrip = false;
                roundTrip = false;
                oneRoad = true;
                setState(() {});
              }),
              checkBox(context, roundTrip, "Round Trip", () {
                multiTrip = false;
                roundTrip = true;
                oneRoad = false;
                setState(() {});
              }),
              checkBox(context, multiTrip, "Multi Destination", () {
                multiTrip = true;
                roundTrip = false;
                oneRoad = false;

                setState(() {});
              }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _email,
            padding: 0,
            validator: (val) => null,
            inputType: TextInputType.name,
            hint: "Departure from",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _email,
            padding: 0,
            validator: (val) => null,
            inputType: TextInputType.name,
            hint: "Arrival to",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _email,
            padding: 0,
            validator: (val) => null,
            inputType: TextInputType.name,
            hint: "Select Dates",
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomText(
              text: "Passengers count",
              textSize: 14,
              fontWeight: FontWeight.normal,
              textColor: Colors.black),
          const SizedBox(
            height: 10,
          ),
          Counter(
              number: number,
              onAdd: () {
                number++;
                setState(() {});
              },
              onMinus: () {
                if (number > 0) {
                  number--;
                  setState(() {});
                }
              }),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              name: "Search",
              buttonColor: appColor,
              height: 45,
              width: double.infinity,
              textSize: 14,
              textColor: Colors.white,
              fontWeight: FontWeight.normal,
              borderRadius: 5,
              onTapped: () {
                NavigationHelper.pushRoute(context, const SearchResult());
              },
              padding: 0),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                  text: "Packages",
                  textSize: 18,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.black),
              InkWell(
                onTap: () {
                  NavigationHelper.pushRoute(context, const ExploreScreen());
                },
                child: Row(
                  children: const [
                    CustomText(
                        text: "Explore",
                        textSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          getStartedProvider.isDataLoaded
              ? SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount:
                          getStartedProvider.packagesResponse.data!.length,
                      itemBuilder: (context, i) {
                        var data = getStartedProvider.packagesResponse.data![i];
                        var packageName = data.name!.en.toString();
                        var rating = data.rate.toString();
                        var fee = data.fees.toString();
                        var thumbnailImage = data.image.toString();
                        var dateFrom = data.dateFrom.toString();
                        var detail = data.description!.en.toString();
                        debugPrint("thumbnailImage: $baseUrl/$thumbnailImage");
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: packageCardContainer(
                            title: packageName,
                            rating: rating,
                            fee: fee,
                            dateFrom: dateFrom,
                            detail: detail,
                          ),
                        );
                      }),
                )
              : Container()
        ],
      ),
    );
  }

  Widget packageCardContainer({
    required String title,
    required String rating,
    required String fee,
    required String dateFrom,
    required String detail,
  }) =>
      SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              height: 130,
              //width: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    "assets/images/asste.png",
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: title,
                    textSize: 14,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CustomText(
                    text: "${detail.substring(0, 60)}...",
                    textSize: 10,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: dateFrom,
                  textSize: 10,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.black,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        CustomText(
                            text: rating,
                            textSize: 12,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black)
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: CustomText(
                            text: "SKR $fee",
                            textSize: 10,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );

  Widget checkBox(
      BuildContext context, bool isSelected, String name, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                color: isSelected ? appColor : Colors.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                    color: isSelected ? appColor : Colors.grey.shade400)),
            child: const Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          CustomText(
              text: name,
              textSize: 12,
              fontWeight: FontWeight.normal,
              textColor: Colors.black)
        ],
      ),
    );
  }
}
