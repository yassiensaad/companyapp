import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:company_app/screens/auth/login.dart';
import '../../constance/constante.dart';
import '../../constance/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<double> _animation;
  final TextEditingController _emailTextcontroller = TextEditingController();
  final TextEditingController _fullNameTextcontroller = TextEditingController();
  final TextEditingController _postionTextcontroller = TextEditingController();
  final TextEditingController _phoneTextcontroller = TextEditingController();
  final TextEditingController _passTextcontroller = TextEditingController();
  bool _obsecureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloading = false;
  File? imageFile;
  // ignore: non_constant_identifier_names
  final _SignUpKey = GlobalKey<FormState>();
  final FocusNode _fullnameFocuseNode = FocusNode();
  final FocusNode _posationFocuseNode = FocusNode();
  final FocusNode _emailFocuseNode = FocusNode();
  final FocusNode _passFocuseNode = FocusNode();
  final FocusNode _phoneFocuseNode = FocusNode();

  File? personimage;
  CroppedFile? croppedImage;
  String? url;

  @override
  void dispose() {
    _animationcontroller.dispose();
    _emailTextcontroller.dispose();
    _passTextcontroller.dispose();
    _fullNameTextcontroller.dispose();
    _postionTextcontroller.dispose();
    _phoneTextcontroller.dispose();
    _phoneFocuseNode.dispose();
    _fullnameFocuseNode.dispose();
    _posationFocuseNode.dispose();
    _emailFocuseNode.dispose();
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

  void onsubmetform() async {
    final isvaild = _SignUpKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvaild) {
      if (imageFile == null) {
        globalServices.errorOccourd(
            error: 'You Should Pick Up Personal Image', context: context);
        return;
      }
      setState(() {
        _isloading = true;
      });
      // ignore: avoid_print
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailTextcontroller.text.toLowerCase().trim(),
            password: _passTextcontroller.text.trim());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('UserImages')
            .child(_uid + '.jpg');
        await ref.putFile(imageFile!);
        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('user').doc('_uid').set({
          'id': _uid,
          'Name': _fullNameTextcontroller.text,
          'Email': _emailTextcontroller.text,
          'UserImageUrl': url,
          'PhonrNumber': _phoneTextcontroller.text,
          'PositionCompany': _postionTextcontroller.text,
          'CreatedAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isloading = false;
        });
        // ignore: avoid_print
        globalServices.errorOccourd(error: error.toString(), context: context);
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
                "SignUp",
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
                    text: 'Already have an account',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const TextSpan(text: '        '),
                TextSpan(
                    text: 'Login',
                    // ignore: avoid_print
                    recognizer: TapGestureRecognizer()
                      // ignore: avoid_print
                      ..onTap = () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())),
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
                key: _SignUpKey,
                child: Column(children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          focusNode: _fullnameFocuseNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_posationFocuseNode),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field Can\'t be empty';
                            }
                            return null;
                          },
                          controller: _fullNameTextcontroller,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'FullName',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400)),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width * 0.24,
                                height: size.width * 0.24,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(16)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: imageFile == null
                                      ? Image.network(
                                          'https://i.imgur.com/JdfM8uX.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          imageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  _showImageDialoge();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        imageFile == null
                                            ? Icons.add_a_photo
                                            : Icons.edit,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Posations Categories',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: SizedBox(
                                width: size.width * 0.9,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: Constance.jobsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          // ignore: avoid_print
                                          setState(() {
                                            _postionTextcontroller.text =
                                                Constance.jobsList[index];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.pink,
                                              size: 15,
                                            ),
                                            Text(
                                              Constance.jobsList[index],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blue[500]),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            );
                          });
                    },
                    child: TextFormField(
                      enabled: false,
                      focusNode: _posationFocuseNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_phoneFocuseNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                      controller: _postionTextcontroller,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Posation',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink.shade400)),
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                    focusNode: _phoneFocuseNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_emailFocuseNode),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    controller: _phoneTextcontroller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'phone',
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
                    focusNode: _emailFocuseNode,
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
                  SizedBox(height: size.height * .02),
                ]),
              ),
              _isloading
                  ? Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.pink.shade400,
                      onPressed: onsubmetform,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('SignUp',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person_add,
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

// Future<XFile?> takePhoto(
//       {ImagePickerCameraDelegateOptions options =
//           const ImagePickerCameraDelegateOptions()}) async {
//     return _takeAPhoto(options.preferredCameraDevice);
//   }
  void _pickImagefromCamera() async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? photo = await picker.pickImage(
    //     source: ImageSource.camera, maxWidth: 1000, maxHeight: 1000);
    try {
      XFile? pickedfile = await ImagePicker().pickImage(
          source: ImageSource.camera, maxWidth: 1000, maxHeight: 1000);
      setState(() {
        imageFile = File(pickedfile!.path);
      });
    } catch (error) {
      globalServices.errorOccourd(error: error.toString(), context: context);
    }
    Navigator.pop(context);
    // _cropImage(pickedfile!.path);
    // ignore: use_build_context_synchronously
  }

  void _pickImagefromgallary() async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? photo = await picker.pickImage(
    //     source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);
    try {
      XFile? pickedfile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);

      setState(() {
        imageFile = File(pickedfile!.path);
      });
    } catch (error) {
      globalServices.errorOccourd(error: error.toString(), context: context);
    }
    Navigator.pop(context);

    // _cropImage(pickedfile!.path);
    // ignore: use_build_context_synchronously

    // PickedFile? pickedfile = await ImagePicker()
    //     .getImage(source: ImageSource.camera, maxwidth: 1000, maxheight: 1000);
  }

  // void _cropImage(filePath) async {
  //   final cropeImage = await ImageCropper()
  //       .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
  //   if (cropeImage != null) {
  //     setState(() {
  //       croppedImage = cropeImage;
  //     });
  //   }
  // }

  void _showImageDialoge() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Choose Your Photo',
              style: TextStyle(fontSize: 18, color: Colors.pink),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: _pickImagefromCamera,
                child: const Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Camera')
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: _pickImagefromgallary,
                child: const Row(
                  children: [
                    Icon(Icons.photo),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Gallary')
                  ],
                ),
              ),
            ]),
          );
        });
  }
}
