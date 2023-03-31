import 'package:flutter/material.dart';

class BoxesBidPage extends StatelessWidget {
  const BoxesBidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Gorunum(title: ''),
    );
  }
}

class Gorunum extends StatefulWidget {
  const Gorunum({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Gorunum> createState() => _GorunumState();
}

class _GorunumState extends State<Gorunum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/box_types/paper.png'),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 50,left: 50),
                        child: Row(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.green,
                                ),
                                Text(" Ankara",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                Text(" Etimesgut",
                                    style: TextStyle(
                                        fontSize: 19, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                children: const [
                  Text(
                    "Explanation",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "This box is an apartment box. The offers you make as a scrap dealer will be evaluated by the apartment manager.",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your offer',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('SEND'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size.fromHeight(40), // NEW
                        primary: const Color(0xFF680360),
                        textStyle: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
