import 'package:flutter/material.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/theme/colors/light_colors.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/announcements_card_types.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/announcements_to_bid.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_nav_bar_page.dart';

class CallAnnouncements extends StatelessWidget {
  const CallAnnouncements({Key? key}) : super(key: key);

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

  List province = ['Çankaya', 'Keçiören', 'Etimesgut', 'Sincan'];
  List typeOfScrap = [
    'Paper Scrap',
    'Metal Scrap',
    'Glass Scrap',
    'Electronic Scrap'
  ];
  List weight = ['15', '30', '13', '28'];

  // @override
  // Future<void> initState() async {
  //   DocumentSnapshot<Map<String, dynamic>> announcements = await FirebaseFirestore.instance
  //       .collection('announcements')
  //       .doc()
  //       .get();
  //   print(announcements);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const ScrapDealerNavBar()));
        },
        child: const Icon(Icons.water_damage_outlined),
      ),
      backgroundColor: LightColors.kLightWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  subheading('Types of Announcements'),
                ],
              ),
              const TypesOfBoxes(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: Row(
                  children: [
                    subheading('Announcements To Bid'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: province != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 220,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                        ),
                        itemCount: typeOfScrap.length,
                        itemBuilder: (context, index) => OpenedBoxesGrid(
                          weight[index],
                          typeOfScrap[index],
                          province[index],
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
  String weightIndex;
  String typeIndex;
  String provinceIndex;

  OpenedBoxesGrid(
    this.weightIndex,
    this.typeIndex,
    this.provinceIndex, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnouncementToBid(
      wasteColor: typeIndex == 'Glass Scrap'
          ? LightColors.glassBox
          : typeIndex == 'Plastic Scrap'
              ? LightColors.plasticBox
              : typeIndex == 'Electronic Scrap'
                  ? LightColors.electronicBox
                  : typeIndex == 'Metal Scrap'
                      ? LightColors.metalBox
                      : typeIndex == 'Oil Scrap'
                          ? LightColors.oilBox
                          : typeIndex == 'Paper Scrap'
                              ? LightColors.paperBox
                              : LightColors.electronicBox,
      wasteWeight: weightIndex,
      wasteTitle: typeIndex,
      wasteProvince: provinceIndex,
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
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.glassBox,
              title: 'Glass',
              subtitle: '2 glass posts',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.plasticBox,
              title: 'Plastic',
              subtitle: '18 plastic posts',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.electronicBox,
              title: 'Electronic',
              subtitle: '2 electronic posts',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.metalBox,
              title: 'Metal',
              subtitle: '2 metal posts',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.oilBox,
              title: 'Oil',
              subtitle: '2 oil posts',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnnouncementsCardsTypes(
              icon: Icons.recycling,
              iconBackgroundColor: LightColors.paperBox,
              title: 'Paper',
              subtitle: '2 paper posts',
            ),
          ),
        ],
      ),
    );
  }
}
