import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_account_page/scrap_dealer_settings_page.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_history_page/scrap_dealer_purchace_history_page.dart';
import 'package:scrap_app/utilities/login/google_sign_in_page.dart';
import 'package:scrap_app/utilities/login/login_screen.dart';
import 'package:scrap_app/utilities/shared_pages/acc_page/theme.dart';
import 'package:scrap_app/utilities/shared_pages/acc_page/widgets/profile_list_item.dart';




class ScrapDealerAccountPage extends StatelessWidget {
  const ScrapDealerAccountPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: true,
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, designSize: Size(width, height), minTextAdapt: false);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 2),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            FirebaseAuth.instance.currentUser!.displayName.toString().toUpperCase(),
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      const ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScrapDealerHistoryPage()));
                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.history,
                          text: 'Purchase History',
                        ),
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                              builder: (context) => const ScrapDealerSettingsPage()));
                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.cog,
                          text: 'Settings',
                        ),
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                      ),
                      GestureDetector(
                        onTap: () async {
                          await signOutWithGoogle();
                          await Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
