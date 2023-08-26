import 'package:company_app/firebase_options.dart';
import 'package:company_app/users_state.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final emulatorHost =
  //     (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
  //         ? '10.0.2.2'
  //         : 'localhost';

  // await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Text(
                    'App Is Loading',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ));
          } else if (snapshot.hasError) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Text(
                    'Their is an error ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ));
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xffede7dc),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: UserState());
        });

    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       scaffoldBackgroundColor: const Color(0xffede7dc),
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //       useMaterial3: true,
    //     ),
    //     home: const LoginScreen());
  }
}
