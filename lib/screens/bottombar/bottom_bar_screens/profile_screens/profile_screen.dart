import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qbus/local_cache/utils.dart';
import 'package:qbus/navigation/navigation_helper.dart';
import 'package:qbus/res/assets.dart';
import 'package:qbus/res/colors.dart';
import 'package:qbus/res/common_padding.dart';
import 'package:qbus/res/extensions.dart';
import 'package:qbus/res/res.dart';
import 'package:qbus/screens/auth/login_screens/login_screen.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/about_us_screens/about_us_screen.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/edit_user_profile_screens/edit_user_profile_screen.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/privacy_policy_screens/privacy_policy_screen.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/profile_provider.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/return_policy_screens/return_policy_screen.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/wallet_screens/wallet_screen.dart';
import 'package:qbus/widgets/text_views.dart';

import '../../../../utils/constant.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/setting_card.dart';
import '../contact_us_screens/contact_us_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = ProfileProvider();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Center(
          child: CustomText(
              text: "Profile",
              textSize: 18,
              fontWeight: FontWeight.w700,
              textColor: Colors.white),
        ),
      ),
      body: Column(
        children: [
          CommonPadding.sizeBoxWithHeight(height: 20),
          profileProvider.isProfileLoading == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EditUserProfileScreen()));
                  },
                  child: Container(
                    height: sizes!.heightRatio * 80,
                    width: sizes!.widthRatio * 345,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.heightRatio * 12,
                          vertical: sizes!.heightRatio * 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/user_icon.svg",
                            height: sizes!.heightRatio * 30,
                            width: sizes!.widthRatio * 30,
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView.getMediumText14(
                                  profileProvider.userResponse.data!.user!.name
                                      .toString(),
                                  Assets.latoBold,
                                  color: AppColors.black900,
                                  fontWeight: FontWeight.w400,
                                  lines: 1),
                              CommonPadding.sizeBoxWithHeight(height: 4),
                              TextView.getMediumText14(
                                  profileProvider
                                      .userResponse.data!.user!.maritalStatus
                                      .toString().toUpperCase(),
                                  Assets.latoBold,
                                  color: AppColors.black900,
                                  fontWeight: FontWeight.w400,
                                  lines: 1),
                              CommonPadding.sizeBoxWithHeight(height: 4),
                              TextView.getMediumText14(
                                  profileProvider.userResponse.data!.user!.phone
                                      .toString(),
                                  Assets.latoBold,
                                  color: AppColors.black900,
                                  fontWeight: FontWeight.w400,
                                  lines: 1),
                            ],
                          )
                        ],
                      ),
                    ),
                  ).get20HorizontalPadding(),
                )
              : const Center(
                  child: Text("No User Profile Found"),
                ),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: 'Wallet',
              onPress: () {
                NavigationHelper.pushRoute(context, const WalletScreen());
              }),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: 'About us',
              onPress: () {
                NavigationHelper.pushRoute(context, const AboutUsScreen());
              }),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: 'Privacy Policy',
              onPress: () {
                NavigationHelper.pushRoute(
                    context, const PrivacyPolicyScreen());
              }),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: 'Return Policy',
              onPress: () {
                NavigationHelper.pushRoute(context, const ReturnPolicyScreen());
              }),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: "Contact us",
              onPress: () {
                NavigationHelper.pushRoute(context, const ContactUsScreen());
              }),
          CommonPadding.sizeBoxWithHeight(height: 15),
          getRow(
              title: "Logout",
              onPress: () {
                _lagOut();
              }),
        ],
      ),
    );
  }

  Future<void> _lagOut() async {
    await profileProvider.logoutUser();
    await PreferenceUtils.clearPreferences();
    if (profileProvider.isUserLogout) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  Widget getRow({required String title, required Function? onPress}) =>
      GestureDetector(
        onTap: () {
          if (onPress != null) {
            onPress.call();
          }
        },
        child: Container(
          height: sizes!.heightRatio * 42,
          width: sizes!.widthRatio * 335,
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView.getMediumText14(title, Assets.latoBold,
                    color: AppColors.black900,
                    fontWeight: FontWeight.w400,
                    lines: 1),
                SvgPicture.asset(
                  "assets/svg/forward_icon.svg",
                  width: sizes!.widthRatio * 24,
                  height: sizes!.heightRatio * 24,
                ),
              ],
            ),
          ),
        ).get20HorizontalPadding(),
      );
}
