import 'package:flutter/material.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/call_scrap_dealer/call_scrap_dealer_page.dart';

import 'package:scrap_app/pages/user_pages/user_homepage/theme/colors/light_colors.dart';

class CallScrapDealer extends StatefulWidget {
  const CallScrapDealer({
    Key? key,
  }) : super(key: key);

  @override
  State<CallScrapDealer> createState() => _CallScrapDealerState();
}

class _CallScrapDealerState extends State<CallScrapDealer> {
  void runToCallScrapDealerPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CallScrapDealerPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        runToCallScrapDealerPage();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        height: 50,
        decoration: BoxDecoration(
          color: LightColors.paperBox,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Call Scrap Dealer',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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