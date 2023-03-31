import 'package:flutter/material.dart';

class UserAlertsPage extends StatefulWidget {
  const UserAlertsPage({Key? key}) : super(key: key);

  @override
  State<UserAlertsPage> createState() => _UserAlertsPageState();
}

class _UserAlertsPageState extends State<UserAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('UserAlertsPage'),
          ],
        ),
      ),
    );
  }
}
