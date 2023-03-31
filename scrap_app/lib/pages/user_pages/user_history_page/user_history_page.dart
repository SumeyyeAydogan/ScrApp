import 'package:flutter/material.dart';
import 'package:scrap_app/utilities/shared_pages/history_page/history_card.dart';

import '../user_homepage/theme/colors/light_colors.dart';



class UserSalesHistoryPage extends StatelessWidget {
  const UserSalesHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Sales History Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Poppins'),
      ),
      home: const SalesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SalesScreen extends StatefulWidget {
  const SalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: subheading('Sales History'),
            ),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => const PlanRow(),
                  itemCount: 4,
                )),
          ],
        ),
      ),
    );
  }
}

class PlanRow extends StatefulWidget {
  const PlanRow({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanRow> createState() => _PlanRowState();
}

class _PlanRowState extends State<PlanRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: const <Widget>[
          HistoryCard(
            text: 'Recent Purchases',
            cardColor: LightColors.paperBox,
          ),
        ],
      ),
    );
  }
}
