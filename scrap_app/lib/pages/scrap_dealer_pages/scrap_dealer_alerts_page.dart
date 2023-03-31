import 'package:flutter/material.dart';

class ScrapDealerAlertsPage extends StatefulWidget {
  const ScrapDealerAlertsPage({Key? key}) : super(key: key);

  @override
  State<ScrapDealerAlertsPage> createState() => _ScrapDealerAlertsPageState();
}

class _ScrapDealerAlertsPageState extends State<ScrapDealerAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('ScrapDealerAlertsPage'),
          ],
        ),
      ),
    );
  }
}
