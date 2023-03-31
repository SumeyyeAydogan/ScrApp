import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/maded_announcements_page.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/theme/colors/light_colors.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/box_types.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/boxes_open_to_bid.dart';

class ScrapDealerHomePage extends StatelessWidget {
  const ScrapDealerHomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.metalBox,
            displayColor: LightColors.metalBox,
            fontFamily: 'Poppins'),
      ),
      home: const ScrapDealerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScrapDealerScreen extends StatefulWidget {
  const ScrapDealerScreen({Key? key}) : super(key: key);

  @override
  State<ScrapDealerScreen> createState() => _ScrapDealerScreenState();
}

class _ScrapDealerScreenState extends State<ScrapDealerScreen> {
  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.metalBox,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  void initState() {
    findBoxesGT75();
    super.initState();
  }

  String? boxInfoData;
  Map<String, dynamic>? infoConvertedData;
  List? infoValuesList;

  String? allBoxesData;
  Map<String, dynamic>? allBoxesConvertedData;
  List allBoxesKeysGT75 = [];
  List allBoxesValuesGT75 = [];

  void findBoxesGT75() {
    findBoxesInfo();
    findAllBoxesKeys();
  }

  void findBoxesInfo() {
    DatabaseReference infoTaskRef =
        FirebaseDatabase.instance.ref('/allboxes/box00002/info/');
    infoTaskRef.onValue.listen((event) {
      setState(() {
        boxInfoData = jsonEncode(event.snapshot.value);
        infoConvertedData = jsonDecode(boxInfoData!);
        infoValuesList = infoConvertedData!.values.toList();
      });
    });
  }

  void findAllBoxesKeys() {
    final filterTaskRef = FirebaseDatabase.instance.ref('allboxes');
    filterTaskRef.onValue.listen((event) {
      setState(() {
        allBoxesData = jsonEncode(event.snapshot.value);
        allBoxesConvertedData = jsonDecode(allBoxesData!);
        var boxIds = allBoxesConvertedData!.keys.toList();
        visitAllBoxes(boxIds: boxIds);
      });
    });
  }

  void visitAllBoxes({required List<String> boxIds}) {
    allBoxesValuesGT75 = [];
    allBoxesKeysGT75 = [];
    for (final boxId in boxIds) {
      final greaterThan75ValueTaskRef = FirebaseDatabase.instance
          .ref('allboxes/$boxId/boxes/')
          .orderByValue()
          .startAt(75);

      greaterThan75ValueTaskRef.onValue.listen((event) {
        setState(() {
          allBoxesData = jsonEncode(event.snapshot.value);
          allBoxesConvertedData = jsonDecode(allBoxesData!);
          var keysGT75 = allBoxesConvertedData!.keys.toList();
          var valuesGT75 = allBoxesConvertedData!.values.toList();
          allBoxesKeysGT75.addAll(keysGT75);
          allBoxesValuesGT75.addAll(valuesGT75);
        });
      });
    }
  }
  void runToSeeCallAnnouncements() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CallAnnouncements(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        child: const Icon(Icons.whatshot,
        color: Colors.yellow),
        onPressed: () {
          runToSeeCallAnnouncements();
        },
      ),
      backgroundColor: LightColors.kLightWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  subheading('Types of Boxes'),
                ],
              ),
              const TypesOfBoxes(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: Row(
                  children: [
                    subheading('Boxes Open To Bid'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: infoValuesList != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 220,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                        ),
                        itemCount: allBoxesValuesGT75.length,
                        itemBuilder: (context, index) => OpenedBoxesGrid(
                          allBoxesKeysGT75[index],
                          allBoxesValuesGT75[index].toString(),
                          infoValuesList!,
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpenedBoxesGrid extends StatelessWidget {
  String keyIndex;
  String valueIndex;
  List<dynamic> infoValuesList;

  OpenedBoxesGrid(
    this.keyIndex,
    this.valueIndex,
    this.infoValuesList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenedBoxesToBid(
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
                              : LightColors.electronicBox,
      loadingPercent: int.parse(valueIndex) / 100,
      boxTitle: keyIndex,
      boxProvince: infoValuesList[1],
    );
  }
}

class TypesOfBoxes extends StatelessWidget {
  const TypesOfBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.glassBox,
              title: 'Glass',
              subtitle: '2 glass boxes',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.plasticBox,
              title: 'Plastic',
              subtitle: '18 plastic boxes',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.electronicBox,
              title: 'Electronic',
              subtitle: '2 electronic boxes',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.metalBox,
              title: 'Metal',
              subtitle: '2 metal boxes',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.oilBox,
              title: 'Oil',
              subtitle: '2 oil boxes',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: BoxTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.paperBox,
              title: 'Paper',
              subtitle: '2 paper boxes',
            ),
          ),
        ],
      ),
    );
  }
}
