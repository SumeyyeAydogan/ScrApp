import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrap_app/pages/admin_pages/admin_nav_bar_page.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_nav_bar_page.dart';
import 'package:scrap_app/pages/user_pages/user_nav_bar_page.dart';
import 'package:scrap_app/utilities/login/con_without_login_page.dart';
import 'package:scrap_app/utilities/login/google_sign_in_page.dart';

import 'utilities/constants.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _rememberMe = false;
  bool isFirebaseInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    await isUserLoggedIn();
  }

  Future<void> isUserLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userData['role'] == 'user') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserNavBar()));
      } else if (userData['role'] == 'admin') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const AdminNavBar();
        }));
      } else if (userData['role'] == 'scrap dealer') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ScrapDealerNavBar()));
      }
    }
  }

  void continueWithoutLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ContinueWithoutLoginPage(),
    ));
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF9A0190),
                        Color(0xFF89027C),
                        Color(0xFF7B0272),
                        Color(0xFF680360),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                SizedBox(
                  height: height,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Scrap APP',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        _buildEmailTF(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _continueWithoutLogin(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: const TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
        },
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = true;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(

        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),

        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF680360),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _continueWithoutLogin() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              primary: Colors.red,
              textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ContinueWithoutLoginPage();
            },));
          },
          child: const Text(
            'Continue Without Login',
            style: kLabelStyle,
          ),

        ),
      ],
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: const <Widget>[
        SizedBox(height: 10.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function()? onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () {
            },
            const AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
                () async {
                  await signInWithGoogle();
                      String? name =
                          FirebaseAuth.instance.currentUser!.displayName;
                      String? email = FirebaseAuth.instance.currentUser!.email;
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      DocumentSnapshot<Map<String, dynamic>> toCheckUserData =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .get();

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .set({
                        'name': name,
                        'email': email,
                        'uid': uid,
                        if (toCheckUserData.exists == false)
                          'role': 'user',
                        if (toCheckUserData.exists == true &&
                            toCheckUserData['role'] == 'admin')
                          'role': 'admin',
                        if (toCheckUserData.exists == true &&
                            toCheckUserData['role'] == 'scrap dealer')
                          'role': 'scrap dealer',
                      }, SetOptions(merge: true));
                      isUserLoggedIn();
                },
            const AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

