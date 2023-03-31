import 'package:flutter/material.dart';

class ContinueWithoutLoginPage extends StatefulWidget {
  const ContinueWithoutLoginPage({Key? key}) : super(key: key);

  @override
  State<ContinueWithoutLoginPage> createState() => _ContinueWithoutLoginPageState();
}

class _ContinueWithoutLoginPageState extends State<ContinueWithoutLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Kutu Sayısı'),
          ],
        ),
      ),
    );
  }
}
