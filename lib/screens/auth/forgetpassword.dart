import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationcontroller;
  // ignore: unused_field
  late Animation<double> _animation;
  // ignore: non_constant_identifier_names
  final TextEditingController _ForgetPasswordcontroller =
      TextEditingController();
  // ignore: non_constant_identifier_names
  final _ForgetPasswordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _animationcontroller.dispose();
    _ForgetPasswordcontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationcontroller, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationcontroller.reset();
              _animationcontroller.forward();
            }
          });
    _animationcontroller.forward();
  }

  void onsubmetform() {
    final isvaild = _ForgetPasswordKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvaild) {
      // ignore: avoid_print
      print('pressed');
    } else {
      // ignore: avoid_print
      print('un pressed');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('company app'),
      // ),
      body: Stack(children: [
        CachedNetworkImage(
          imageUrl: "https://i.imgur.com/Spk9BbS.png",
          placeholder: (context, url) => Image.asset(
            "assets/CA.png",
            fit: BoxFit.fill,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: FractionalOffset(_animation.value, 0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              const Text(
                "ForgetPassword",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Email Address",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: _ForgetPasswordcontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink.shade400)),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.pink.shade400,
                onPressed: onsubmetform,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Reset Password',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
