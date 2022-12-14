import 'package:expectations/main.dart';
import 'package:expectations/ui/auth/check_email_screen.dart';
import 'package:expectations/ui/auth/forget_password_screen.dart';
import 'package:expectations/ui/auth/login_screen.dart';
import 'package:expectations/ui/auth/packages_screen.dart';
import 'package:expectations/ui/auth/register_screen.dart';
import 'package:expectations/ui/auth/subscribe_screen.dart';
import 'package:expectations/ui/boarding_screen.dart';
import 'package:expectations/ui/home/home_screen.dart';
import 'package:expectations/ui/home/search_screen.dart';
import 'package:expectations/ui/live/all_live_screen.dart';
import 'package:expectations/ui/live/live_screen.dart';
import 'package:expectations/ui/match/awards_screen.dart';
import 'package:expectations/ui/match/match_expection_screen.dart';
import 'package:expectations/ui/match/match_show_expection_screen.dart';
import 'package:expectations/ui/match/winners_screen.dart';
import 'package:expectations/ui/notifications_screen.dart';
import 'package:expectations/ui/profile/edit_profile_screen.dart';
import 'package:expectations/ui/profile/profile_screen.dart';
import 'package:expectations/ui/settings/about_us_screen.dart';
import 'package:expectations/ui/settings/application_advantages.dart';
import 'package:expectations/ui/settings/contact_us_screen.dart';
import 'package:expectations/ui/settings/privacy_policy_screen.dart';
import 'package:expectations/ui/settings/reset_password_screen.dart';
import 'package:expectations/ui/settings/user_policy_screen.dart';
import 'package:expectations/ui/splash_screen.dart';
import 'package:expectations/ui/started_screen.dart';
import 'package:expectations/utils/bindings/awards_binding.dart';
import 'package:expectations/utils/bindings/change_password_binding.dart';
import 'package:expectations/utils/bindings/expection_binding.dart';
import 'package:expectations/utils/bindings/forget_password_binding.dart';
import 'package:expectations/utils/bindings/home_binding.dart';
import 'package:expectations/utils/bindings/login_binding.dart';
import 'package:expectations/utils/bindings/register_binding.dart';
import 'package:expectations/utils/bindings/winners_binding.dart';
import 'package:get/get.dart';

import '../ui/settings/change_language.dart';

class AppRoutes {
  static final routesPages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.language, page: () => ChangeLanguagee()),
    GetPage(name: Routes.boarding, page: () => BoardingScreen()),
    GetPage(name: Routes.started, page: () => StartedScreen()),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        bindings: [LoginBinding(), HomeBinding()]),
    GetPage(
        name: Routes.register,
        page: () => RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: Routes.packages,
        page: () => PackagesScreen()),
    GetPage(name: Routes.subscribe, page: () => SubscribeScreen()),
    GetPage(
        name: Routes.home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: Routes.search, page: () => SearchScreen()),
    GetPage(
        name: Routes.matchPrediction,
        page: () {
          ExpectionScreen expectionScreen = Get.arguments;
          print('Going to a new page');
          return expectionScreen;
        },
        binding: ExpectionBinding()),
    GetPage(
        name: Routes.showMatchPrediction,
        page: () {
          ShowExpectionScreen expectionScreen = Get.arguments;
          print('Going to a new page');
          return expectionScreen;
        }),
    GetPage(name: Routes.notifications, page: () => NotificationsScreen()),
    GetPage(name: Routes.profile, page: () => ProfileScreen()),
    GetPage(name: Routes.editProfile, page: () => EditProfileScreen()),
    GetPage(name: Routes.contactUs, page: () => ContactUsScreen()),
    GetPage(name: Routes.aboutUs, page: () => AboutUsScreen()),
    GetPage(name: Routes.privacyPolicy, page: () => PrivacyPolicyScreen()),
    GetPage(name: Routes.userPolicy, page: () => UserPolicyScreen()),
    GetPage(
        name: Routes.winners,
        page: () {
          WinnersScreen screen = Get.arguments;
          return screen;
        },
        binding: WinnersBinding()),
    GetPage(
        name: Routes.awards,
        page: () {
          AwardsScreen screen = Get.arguments;
          return screen;
        },
        binding: AwardsBinding()),
    GetPage(
        name: Routes.resetPassword,
        page: () => ResetPasswordScreen(),
        binding: ResetPasswordBinding()),
    GetPage(
        name: Routes.forgetPassword,
        page: () => ForgetPasswordScreen(),
        binding: ForgetPasswordBinding()),
    GetPage(name: Routes.checkEmail, page: () => CheckEmailScreen()),
    GetPage(name: Routes.allLive, page: () => AllLiveScreen()),
    GetPage(name: Routes.live, page: () => LiveScreen()),
    GetPage(name: Routes.appAdvantages, page: () => AppAdvantagesScreen()),
  ];
}

class Routes {
  static const splash = '/splash';
  static const language = '/lang'; // new
  static const boarding = '/boarding';
  static const started = '/started';
  static const login = '/login';
  static const register = '/register';
  static const packages = '/packages';
  static const subscribe = '/subscribe';
  static const home = '/home';
  static const search = '/search';
  static const matchPrediction = '/match_prediction';
  static const showMatchPrediction = '/show_match_prediction';
  static const profile = '/profile';
  static const editProfile = '/edit_profile';
  static const notifications = '/notifications';
  static const contactUs = '/contact_us';
  static const aboutUs = '/about_us';
  static const privacyPolicy ='/privacy_policy';
  static const userPolicy ='/user_policy';
  static const winners = '/winners';
  static const awards = '/awards';
  static const resetPassword = '/reset_password';
  static const forgetPassword = '/forget_password';
  static const checkEmail = '/check_email';
  static const allLive = '/all_live';
  static const live = '/live';
  static const appAdvantages = '/application_advantages';
  static const contestRules = '/contest_rules';
}
