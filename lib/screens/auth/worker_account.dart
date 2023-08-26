import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_app/constance/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../users_state.dart';
import '../../widgets/drawe_widget.dart';

class WorkerAccountScreen extends StatefulWidget {
  const WorkerAccountScreen({super.key});

  @override
  State<WorkerAccountScreen> createState() => _WorkerAccountScreenState();
}

// final Uri _url = Uri.parse('https://flutter.dev');
// final Uri _url = Uri.parse('https://flutter.dev');

class _WorkerAccountScreenState extends State<WorkerAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  bool _isloading = false;
  String phoneNumber = "";
  String email = "";
  String name = "";
  String job = "";
  String imageUrl = "";
  String joinedAt = "";
  // ignore: prefer_final_fields, unused_field
  bool _isSameUser = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    _isloading = true;
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc('uBBKYc8ZVLcvXjYxYE1aBnNatll2')
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('Email');
          name = userDoc.get('Name');
          phoneNumber = userDoc.get('PhonrNumber');
          job = userDoc.get('PositionCompany');
          // imageUrl = userDoc.get('UserImageUrl');
          Timestamp joindAtTimeStamp = userDoc.get('CreatedAt');
          var joinedDate = joindAtTimeStamp.toDate();
          joinedAt = '${joinedDate.year}-${joinedDate.month}-${joinedDate.day}';
        });
        User? user = _auth.currentUser;
        // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
        String _uid = user!.uid;
        //TODO check if same user;
      }
    } catch (error) {
      globalServices.errorOccourd(error: '$error', context: context);
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: const EdgeInsets.all(30),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$job from $joinedAt',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Contact Info',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _socialInfo(field: 'Mail', data: email),
                          _socialInfo(field: 'Phone', data: phoneNumber),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _socialButton(
                                  icon: FontAwesome5.whatsapp,
                                  fct: () {
                                    _obenWhatsApp();
                                  },
                                  color: Colors.green),
                              _socialButton(
                                  icon: FontAwesome5.mail_bulk,
                                  fct: () {
                                    _mailto();
                                  },
                                  color: Colors.blue),
                              _socialButton(
                                  icon: FontAwesome5.phone,
                                  fct: () {
                                    __phoneto();
                                  },
                                  color: Colors.red)
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.pink.shade400,
                              onPressed: () {
                                _logout(context);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text('Log Out',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 5,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              image: NetworkImage(
                                'https://i.imgur.com/JdfM8uX.png',
                              ),
                              fit: BoxFit.fill)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _obenWhatsApp() async {
    // ignore: deprecated_member_use
    await launch('https://wa.me/$phoneNumber');
  }

  void _mailto() async {
    var url = 'mailto:$email';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Errors occurd could\'t open link';
    }
    // ignore: deprecated_member_use
  }

  void __phoneto() async {
    var url = 'tel://$phoneNumber';

    // ignore: deprecated_member_use
    await launch(url);

    // ignore: deprecated_member_use
  }

  Widget _socialInfo({required String field, required String data}) {
    return Row(
      children: [
        Text(
          field,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          data,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
      ],
    );
  }

  Widget _socialButton(
      {required Color color, required IconData icon, required Function fct}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white12,
          child: IconButton(
              onPressed: () {
                fct();
              },
              icon: Icon(icon))),
    );
  }

  void _logout(context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(children: [
                Flexible(
                    child: CircleAvatar(
                        child:
                            Image.network('https://i.imgur.com/Spk9BbS.png'))),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Alert'),
                ),
              ]),
              content: const Text(
                'Do You Wanna LogOut?',
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => UserState()));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ))
              ]);
        });
  }
}
