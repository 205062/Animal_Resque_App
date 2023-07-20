import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petzz_project/animals_list.dart';
import 'package:petzz_project/signinscreen.dart';
import 'package:petzz_project/uploadscreen.dart';
import 'color_utils.dart';
import 'reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("FFFFC107"),
              hexStringToColor("FFFFD54F"),
              hexStringToColor("FFFFB300")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget('assets/one.png'),
                  SizedBox(
                    height: 10,
                  ),
                  needButton(context, true, 'In need of Rescue', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => uploadScreen()));
                  }),
                  needButton(context, true, 'Rescue Organization', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AnimalList()));
                  }),
                  SizedBox(
                    height: 100,
                  ),
                  needButton(context, true, 'LogOut', () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signinscreen()));
                    });
                  }),
                ],
              ),
            ))));
  }
}
