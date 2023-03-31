import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/theme/colors/light_colors.dart';
import 'package:scrap_app/pages/user_pages/user_nav_bar_page.dart';


class AddBoxButton extends StatefulWidget {


  const AddBoxButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBoxButton> createState() => _AddBoxButtonState();
}

class _AddBoxButtonState extends State<AddBoxButton> {
  void runToUserAddBoxPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const UserAddBoxPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        runToUserAddBoxPage();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
                  'Add Your Apartment Boxes Id',
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

class UserAddBoxPage extends StatefulWidget {


  const UserAddBoxPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserAddBoxPage> createState() => _UserAddBoxPageState();
}

class _UserAddBoxPageState extends State<UserAddBoxPage> {
  final controller = TextEditingController();

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Center(child: subheading('Add Your Box Id')),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 15),
                const Text('Try 00002 for boxId'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your box ID',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: controller.text.isEmpty ? null : () async {
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({
                        'boxID': controller.text,
                      });
                      controller.text = '';
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                          builder: (context) => const UserNavBar()));
                    },
                    child: const Text('Submit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}