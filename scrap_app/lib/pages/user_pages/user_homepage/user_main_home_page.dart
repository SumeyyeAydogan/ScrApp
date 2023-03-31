import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/call_scrap_dealer/call_scrap_dealer_button.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/user_home_page_widget/user_add_box_page.dart';

import 'theme/colors/light_colors.dart';
import 'user_home_page_widget/box_card.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Poppins'),
      ),
      home: const UserScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.paperBox,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4),
    );
  }

  String boxID = '';
  String? boxesData;
  Map<String, dynamic>? boxesConvertedData;
  List? boxesValuesList;
  List? boxesKeysList;

  @override
  void initState() {
    getboxID();
    super.initState();
  }

  Future<void> getboxID() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    boxID = userData['boxID'];
    getBoxData();
  }

  void getBoxData() {
    DatabaseReference boxesTaskRef =
        FirebaseDatabase.instance.ref('/allboxes/box$boxID/boxes/');
    boxesTaskRef.onValue.listen((event) {
      setState(() {
        boxesData = jsonEncode(event.snapshot.value);
        boxesConvertedData = jsonDecode(boxesData!);
        boxesValuesList = boxesConvertedData!.values.toList();
        boxesKeysList = boxesConvertedData!.keys.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: subheading('Apartment Boxes'),
            ),
            Expanded(
              child: boxesValuesList != null &&
                      boxesKeysList != null
                  ? GridView.builder(
                      itemCount: boxesValuesList!.length,
                      itemBuilder: (context, index) => BoxRow(
                        boxesKeysList![index],
                        boxesValuesList![index].toString(),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 220,
                        crossAxisCount: 2,
                      ),
                    )
                  : Center(
                      child: boxID.isEmpty
                          ? const Text('Please Add Your Box ID')
                          : const CircularProgressIndicator()),
            ),
            boxID.isEmpty ? const AddBoxButton() : Column(),
            const CallScrapDealer(),
          ],
        ),
      ),
    );
  }
}

class BoxRow extends StatelessWidget {
  String keyIndex;
  String valueIndex;

  BoxRow(
    this.keyIndex,
    this.valueIndex, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Row(
              children: <Widget>[
                BoxCard(
                  boxColor: keyIndex == 'Glass Box'
                      ? LightColors.glassBox
                      : keyIndex == 'Plastic Box'
                          ? LightColors.plasticBox
                          : keyIndex == 'Electronic  Box'
                              ? LightColors.electronicBox
                              : keyIndex == 'Metal Box'
                                  ? LightColors.metalBox
                                  : keyIndex == 'Oil Box'
                                      ? LightColors.oilBox
                                      : keyIndex == 'Paper Box'
                                          ? LightColors.paperBox
                                          : LightColors.paperBox,
                  loadingPercent: int.parse(valueIndex) / 100,
                  boxTitle: keyIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
