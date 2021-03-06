import 'package:provider/provider.dart';
import 'package:qbus/screens/auth/forgot_screens/forgot_provider.dart';
import 'package:qbus/screens/auth/phone_activation_screens/phone_activation_provider.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/about_us_screens/about_us_provider.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/privacy_policy_screens/privacy_policy_provider.dart';
import 'package:qbus/screens/bottombar/bottom_bar_screens/profile_screens/wallet_screens/wallet_provider.dart';
import 'package:qbus/screens/explore_screens/package_detail_screens/package_detail_provider.dart';
import 'package:qbus/screens/get_started_screens/get_started_provider.dart';
import 'package:qbus/screens/trip_filter_screens/trip_filter_provider.dart';
import '../screens/auth/login_screens/login_provider.dart';
import '../screens/auth/sign_up_screens/sign_up_provider.dart';
import '../screens/bottombar/bottom_bar_screens/booking_history_screens/booking_history_provider.dart';
import '../screens/bottombar/bottom_bar_screens/contact_us_screens/contact_us_provider.dart';
import '../screens/bottombar/bottom_bar_screens/profile_screens/change_password_screens/change_password_provider.dart';
import '../screens/bottombar/bottom_bar_screens/profile_screens/edit_user_profile_screens/edit_user_profile_provider.dart';
import '../screens/bottombar/bottom_bar_screens/profile_screens/profile_provider.dart';
import '../screens/bottombar/bottom_bar_screens/profile_screens/return_policy_screens/return_policy_provider.dart';
import '../screens/bottombar/bottom_bar_screens/setting_screens/setting_provider.dart';
import '../screens/bottombar/bottom_bar_screens/setting_select_lang_screens/setting_select_lang_provider.dart';

import '../screens/explore_screens/explore_provider.dart';
import '../screens/package_filter_screens/package_filter_provider.dart';
import '../screens/search_screens/search_provider.dart';
import '../screens/selectAddition/select_addition_provider.dart';
import '../screens/splash_screens/splash_provider.dart';

final multiProviders = [
  ChangeNotifierProvider<SplashProvider>(
    create: (_) => SplashProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<LoginProvider>(
    create: (_) => LoginProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SignUpProvider>(
    create: (_) => SignUpProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SearchProvider>(
    create: (_) => SearchProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SelectAdditionProvider>(
    create: (_) => SelectAdditionProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ExploreProvider>(
    create: (_) => ExploreProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ContactUsProvider>(
    create: (_) => ContactUsProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<GetStartedProvider>(
    create: (_) => GetStartedProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ProfileProvider>(
    create: (_) => ProfileProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SettingProvider>(
    create: (_) => SettingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SettingSelectLangProvider>(
    create: (_) => SettingSelectLangProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<AboutUsProvider>(
    create: (_) => AboutUsProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PrivacyPolicyProvider>(
    create: (_) => PrivacyPolicyProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ReturnPolicyProvider>(
    create: (_) => ReturnPolicyProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<BookingHistoryProvider>(
    create: (_) => BookingHistoryProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PackageFilterProvider>(
    create: (_) => PackageFilterProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<TripFilterProvider>(
    create: (_) => TripFilterProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PhoneActivationProvider>(
    create: (_) => PhoneActivationProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ForgotProvider>(
    create: (_) => ForgotProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<EditUserProfileProvider>(
    create: (_) => EditUserProfileProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ChangePasswordProvider>(
    create: (_) => ChangePasswordProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<WalletProvider>(
    create: (_) => WalletProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PackageDetailProvider>(
    create: (_) => PackageDetailProvider(),
    lazy: true,
  ),
];
