import 'package:flutter/material.dart';
import 'package:scrap_app/pages/scrap_dealer_pages/scrap_dealer_homepage/widgets/announcements_bid_page.dart';

class AnnouncementToBid extends StatelessWidget {
  final Color wasteColor;
  final String wasteWeight;
  final String wasteTitle;
  final String wasteProvince;

  const AnnouncementToBid({
    Key? key,
    required this.wasteColor,
    required this.wasteWeight,
    required this.wasteTitle,
    required this.wasteProvince,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BidPage()));},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        height: 250,
        decoration: BoxDecoration(
          color: wasteColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Text(
                '$wasteWeight KG',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    wasteTitle,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    wasteProvince,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
