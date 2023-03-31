import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/pages/user_pages/user_homepage/theme/colors/light_colors.dart';

class CallScrapDealerPage extends StatelessWidget {
  const CallScrapDealerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: const CallScrapDealerScreen(),
      );
}

class CallScrapDealerScreen extends StatefulWidget {
  const CallScrapDealerScreen({Key? key}) : super(key: key);

  @override
  _CallScrapDealerScreenState createState() => _CallScrapDealerScreenState();
}

class _CallScrapDealerScreenState extends State<CallScrapDealerScreen> {
  final formKey = GlobalKey<FormState>();
  String city = '';
  String province = '';
  String weight = '';
  String email = '';

  // typeOfScrap
  String typeOfScrapValue = 'Electronic';
  var items = [
    'Electronic',
    'Paper',
    'Oil',
    'Plastic',
    'Metal Mix',
    'Aluminum',
    'Brass',
    'Carbide',
    'Iron',
    'Titanium',
    'Lead',
    'Chrome',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildCity(),
                const SizedBox(height: 16),
                buildProvince(),
                const SizedBox(height: 32),
                buildWeight(),
                const SizedBox(height: 32),
                buildMail(),
                const SizedBox(height: 32),
                typeOfScrap(),
                const SizedBox(height: 32),
                buildSubmit(),
              ],
            ),
          ),
        ),
      );

  Widget buildCity() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        maxLength: 50,
        onSaved: (value) => setState(() => city = value!),
      );

  Widget buildProvince() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Province',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        maxLength: 50,
        onSaved: (value) => setState(() => province = value!),
      );

  Widget buildWeight() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Estimated Weight In KG',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          const pattern = r'[0-9]';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter a number';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a number';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        onSaved: (value) => setState(() => weight = value!),
      );

  Widget buildMail() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Mail',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => email = value!),
      );

  Widget typeOfScrap() => DropdownButton(
        value: typeOfScrapValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            typeOfScrapValue = newValue!;
          });
        },
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'S U B M I T',
          onClicked: () async {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              const message =
                  'The form is successfully sent';

              await FirebaseFirestore.instance
                  .collection('announcements')
                  .doc()
                  .set({
                'City': city,
                'Province': province,
                'Weight': weight,
                'Email': email,
                'Type Of Scrap': typeOfScrapValue,
              });

              const snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

          },
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          onClicked();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5, top: 5),
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
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
