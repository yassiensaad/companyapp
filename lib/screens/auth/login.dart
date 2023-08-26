import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_app/screens/auth/forgetpassword.dart';
import 'package:company_app/screens/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../constance/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationcontroller;
  // ignore: unused_field
  late Animation<double> _animation;
  final TextEditingController _emailTextcontroller = TextEditingController();
  final TextEditingController _passTextcontroller = TextEditingController();
  bool _obsecureText = true;
  final _loginKey = GlobalKey<FormState>();
  final FocusNode _passFocuseNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloading = false;

  void onsubmetform() async {
    final isvaild = _loginKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvaild) {
      setState(() {
        _isloading = true;
      });
      // ignore: avoid_print
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailTextcontroller.text.toLowerCase().trim(),
            password: _passTextcontroller.text.trim());
        // ignore: use_build_context_synchronously
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isloading = false;
        });
        // ignore: avoid_print
        globalServices.errorOccourd(error: error.toString(), context: context);
        // ignore: avoid_print
        print('Error when Connecting${error.toString()}');
      }
    } else {
      // ignore: avoid_print
      print('un pressed');
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    _emailTextcontroller.dispose();
    _passTextcontroller.dispose();
    _passFocuseNode.dispose();
    super.dispose();
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
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'Don\'t have any account?',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const TextSpan(text: '        '),
                TextSpan(
                    text: 'Register',
                    // ignore: avoid_print
                    recognizer: TapGestureRecognizer()
                      // ignore: avoid_print
                      ..onTap = () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen())),
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300))
              ])),
              SizedBox(
                height: size.height * .05,
              ),
              Form(
                key: _loginKey,
                child: Column(children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passFocuseNode),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a vailed Email';
                      }
                      return null;
                    },
                    controller: _emailTextcontroller,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade400)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  TextFormField(
                    focusNode: _passFocuseNode,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: onsubmetform,
                    // validator: (value) {
                    //   if (value!.isEmpty || value.contains('@')) {
                    //     return 'Please enter a vailed Email';
                    //   }
                    //   return null;
                    // },
                    controller: _passTextcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obsecureText,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade400)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen())),
                        child: const Text(
                          'Forget Password',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(height: size.height * .02),
                ]),
              ),
              _isloading
                  ? Center(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: 70,
                        height: 70,
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.pink.shade400,
                      onPressed: onsubmetform,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          )
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
