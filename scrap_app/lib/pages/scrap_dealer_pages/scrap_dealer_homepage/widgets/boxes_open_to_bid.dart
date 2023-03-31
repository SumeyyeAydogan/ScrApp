import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/boxes_offer_page.dart';

class OpenedBoxesToBid extends StatelessWidget {
  final Color boxColor;
  final double loadingPercent;
  final String boxTitle;
  final String boxProvince;

  const OpenedBoxesToBid({Key? key,
    required this.boxColor,
    required this.loadingPercent,
    required this.boxTitle,
    required this.boxProvince,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BoxesBidPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        height: 250,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: CircularPercentIndicator(
                animation: true,
                radius: 40,
                percent: loadingPercent,
                lineWidth: 5.0,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white10,
                progressColor: Colors.white,
                center: Text(
                  '${(loadingPercent*100).round()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  boxTitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  boxProvince,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
