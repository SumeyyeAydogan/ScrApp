import 'package:flutter/material.dart';

class ScrapDealerMapPage extends StatefulWidget {
  const ScrapDealerMapPage({Key? key}) : super(key: key);

  @override
  State<ScrapDealerMapPage> createState() => _ScrapDealerMapPageState();
}

class _ScrapDealerMapPageState extends State<ScrapDealerMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(padding: EdgeInsets.all(25)),
            Text('ScrapDealerMapPage'),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
