import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fimetlo/Screens/EverythingScreens/Drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fimetlo/Screens/EverythingScreens/PersonalPage.dart';

class FirstScreen extends StatefulWidget {
  final login;
  final guest;
  final fromWhere;
  final darkMode;
  final setIndex;
  FirstScreen({
    super.key,
    this.login,
    this.guest,
    this.darkMode,
    this.fromWhere,
    this.setIndex
  });
  static const routeContact = '/FirstScreen';

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    emailController1.dispose();
    emailController2.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    passwordController3.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  bool obscuretext = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool isLoading = false;
  bool _obscureText = true;
  String _displayText = '';
  bool isValid = true;
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegister = GlobalKey<FormState>();

  String txt = Text(
    "Enter a password of min length 6",
    style: TextStyle(color: Colors.black),
  ).toString();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {}
    if (FirebaseAuth.instance.currentUser != null) {
      if(widget.fromWhere == "personalPage" || widget.fromWhere == "drawer"){
        Navigator.pop(context);
        if(widget.fromWhere == "personalPage"){
         widget.setIndex(2);
      }
      }
      widget.login["setIsLoggedin"]();
    }
  }

  Future signIn() async {
    setState(() {
      isLoading = true;
    });
    if (!_formKeyLogin.currentState!.validate()) {
      setState(() {
        isValid = false;
        isLoading = false;
        emailController1.clear();
        passwordController1.clear();
      });
      return;
    }
    ;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController1.text.trim(),
          password: passwordController1.text.trim());
    } catch (e) {
      setState(() {
        emailController1.clear();
        passwordController1.clear();
        isLoading = false;
      });
    }
    setState(() {
      isValid = true;
      isLoading = false;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      if(widget.fromWhere == "personalPage" || widget.fromWhere == "drawer"){
        Navigator.pop(context);
     if(widget.fromWhere == "personalPage"){
        widget.setIndex(2);
         
      }
      }
      widget.login["setIsLoggedin"]();
  }}

  Future register() async {
    setState(() {
      isLoading = true;
    });
    if (!_formKeyRegister.currentState!.validate()) {
      setState(() {
        emailController2.clear();
        passwordController2.clear();
        passwordController3.clear();
        isLoading = false;
      });
      return;
    }
    ;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController2.text.trim(),
          password: passwordController2.text.trim());
    } catch (e) {
      setState(() {
        emailController2.clear();
        passwordController2.clear();
        passwordController3.clear();
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
     if (FirebaseAuth.instance.currentUser != null) {
      if(widget.fromWhere == "personalPage" || widget.fromWhere == "drawer"){
        Navigator.pop(context);
        if(widget.fromWhere == "personalPage"){
         widget.setIndex(2);
      }
      }
      widget.login["setIsLoggedin"]();
    }
  }

  final emailController1 = TextEditingController();
  final emailController2 = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final passwordController3 = TextEditingController();
  late Size screenSize = MediaQuery.of(context).size;
  late var textSize = MediaQuery.of(context).textScaleFactor;
  late var registerPosition = screenSize.width;
  late var signInPosition = 31 / 412 * screenSize.width;
  bool isRegister = false;
  changeToRegister() {
    setState(() {
      isRegister = true;
      registerPosition = 31 / 412 * screenSize.width;
      signInPosition = -screenSize.width;
    });
  }

  changeToSignIn() {
    setState(() {
      isRegister = false;
      registerPosition = screenSize.width;
      signInPosition = 31 / 412 * screenSize.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Screenshot 2023-04-05 220615.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: !isRegister && widget.guest["getIsGuest"]()
                ? IconButton(
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : null,
            automaticallyImplyLeading:
                !isRegister && widget.guest["getIsGuest"](),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Welcome",
              style:
                  TextStyle(fontFamily: "POPPINS", fontWeight: FontWeight.w500),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (isRegister) {
                _formKeyLogin.currentState!.reset();
                _formKeyRegister.currentState!.reset();
                isValid = true;
                changeToSignIn();
                return false;
              }
              return true;
            },
            child: Stack(children: [
              Container(
                height: screenSize.height,
                width: screenSize.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: Container(
                                width: 200 / 412 * screenSize.width,
                                height: 100 / 732 * screenSize.height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white.withOpacity(0.5)),
                                child: Center(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/FimetloLogo.png')),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 40 / 732 * screenSize.height),
                      Container(
                        height: 430 / 732 * screenSize.height,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Form(
                              key: _formKeyLogin,
                              child: AnimatedPositioned(
                                duration: Duration(milliseconds: 200),
                                height: 430 / 732 * screenSize.height,
                                width: 350 / 412 * screenSize.width,
                                left: signInPosition,
                                child: Container(
                                  height: 430 / 732 * screenSize.height,
                                  width: 350 / 412 * screenSize.width,
                                  decoration: BoxDecoration(),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 30, sigmaY: 30),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15 / 412 * screenSize.width,
                                                0 / 732 * screenSize.height,
                                                15 / 412 * screenSize.width,
                                                0 / 732 * screenSize.height),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height: 5 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      Alignment.topLeft,
                                                  child: Text(
                                                    "Log in",
                                                    style: TextStyle(
                                                        fontSize:
                                                            35 * textSize,
                                                        color: Colors.black,
                                                        fontFamily: "POPPINS",
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      Alignment.topLeft,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                    children: [
                                                      Text(
                                                        "New user?",
                                                        style: TextStyle(
                                                            fontSize:
                                                                17 * textSize,
                                                            color:
                                                                Colors.black,
                                                            fontFamily:
                                                                "POPPINS",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          minimumSize: Size(
                                                              0.0 *
                                                                  screenSize
                                                                      .width,
                                                              0.0 *
                                                                  screenSize
                                                                      .height),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  5 /
                                                                      412 *
                                                                      screenSize
                                                                          .width,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                        ),
                                                        child: Text(
                                                          "Create an account",
                                                          style: TextStyle(
                                                              decorationColor:
                                                                  Color(
                                                                      0xFFC30000),
                                                              fontSize: 16 *
                                                                  textSize,
                                                              color: Color(
                                                                  0xFFC30000),
                                                              fontFamily:
                                                                  "POPPINS",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        onPressed: () {
                                                          FocusScope.of(
                                                                  context)
                                                              .requestFocus(
                                                                  new FocusNode());
                                                          changeToRegister();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10 /
                                                      732 *
                                                      screenSize.height,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme: ThemeData()
                                                          .colorScheme
                                                          .copyWith(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                    ),
                                                    child: TextFormField(
                                                        cursorColor:
                                                            Colors.red,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty ||
                                                              !EmailValidator
                                                                  .validate(
                                                                      value)) {
                                                            return "Enter a valid email";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            emailController1,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 16 *
                                                                textSize),
                                                        decoration:
                                                            InputDecoration(
                                                          errorStyle:
                                                              TextStyle(
                                                            color: Colors
                                                                .red, // Change the font color to red.
                                                            fontSize: 12.0,
                                                            height:
                                                                0.1, // Change the font size to 12.
                                                          ),
                                                          prefixIcon: Icon(
                                                              Icons.mail),
                                                          focusColor:
                                                              Colors.red,
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 20 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                              horizontal: 12 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Email address',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 10 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme: ThemeData()
                                                          .colorScheme
                                                          .copyWith(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                    ),
                                                    child: TextFormField(
                                                        obscureText:
                                                            !obscuretext,
                                                        cursorColor:
                                                            Colors.red,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.length <
                                                                  6) {
                                                            return "Enter a password of min length 6";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            passwordController1,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 16 *
                                                                textSize),
                                                        decoration:
                                                            InputDecoration(
                                                                errorStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red, // Change the font color to red.
                                                                  fontSize:
                                                                      12.0,
                                                                  height:
                                                                      0.1, // Change the font size to 12.
                                                                ),
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .lock),
                                                                focusColor: Colors
                                                                    .red,
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(
                                                                        100)),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .transparent)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(100)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(100)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(100)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 20 /
                                                                        732 *
                                                                        screenSize
                                                                            .height,
                                                                    horizontal: 0 /
                                                                        412 *
                                                                        screenSize.width),
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                hintText: 'Password',
                                                                hintStyle: TextStyle(color: Colors.black),
                                                                suffixIcon: IconButton(
                                                                  icon: obscuretext
                                                                      ? Icon(Icons
                                                                          .visibility)
                                                                      : Icon(Icons
                                                                          .visibility_off),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      obscuretext =
                                                                          !obscuretext;
                                                                    });
                                                                  },
                                                                ))),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: isValid
                                                        ? 23 /
                                                            732 *
                                                            screenSize.height
                                                        : 5 /
                                                            732 *
                                                            screenSize
                                                                .height),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: ElevatedButton(
                                                    onPressed: signIn,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100),
                                                      ),
                                                    ).merge(ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all<Size>(
                                                        Size(
                                                            200 /
                                                                412 *
                                                                screenSize
                                                                    .width,
                                                            50 /
                                                                732 *
                                                                screenSize
                                                                    .height),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      224,
                                                                      0,
                                                                      0)),
                                                    )),
                                                    child: Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                          fontSize:
                                                              17 * textSize),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 20 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              right: 10 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          child: Divider(
                                                            thickness:
                                                                1 * textSize,
                                                            color:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "or continue with",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              16 * textSize,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          child: Divider(
                                                            thickness:
                                                                1 * textSize,
                                                            color:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 15 /
                                                        732 *
                                                        screenSize.height),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: ElevatedButton(
                                                        onPressed:
                                                            signInWithGoogle,
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ).merge(ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all<Size>(
                                                            Size(
                                                                156 /
                                                                    412 *
                                                                    screenSize
                                                                        .width,
                                                                47 /
                                                                    732 *
                                                                    screenSize
                                                                        .height),
                                                          ),
                                                        )),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  'assets/google-png-5a3aafee6ff5c8.9595681415137955664586-removebg-preview.png'),
                                                              width: 24 /
                                                                  412 *
                                                                  screenSize
                                                                      .width,
                                                              height: 24 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                            ),
                                                            SizedBox(
                                                                width: 12 /
                                                                    412 *
                                                                    screenSize
                                                                        .width),
                                                            Text(
                                                              'Google',
                                                              style:
                                                                  TextStyle(
                                                                fontSize: 16 *
                                                                    textSize,
                                                                color: Colors
                                                                    .grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: 12 /
                                                            732 *
                                                            screenSize.width),
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  140,
                                                                  255),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ).merge(ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all<Size>(
                                                            Size(
                                                                156 /
                                                                    412 *
                                                                    screenSize
                                                                        .width,
                                                                47 /
                                                                    732 *
                                                                    screenSize
                                                                        .height),
                                                          ),
                                                        )),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.facebook,
                                                              size: 24 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                            ),
                                                            SizedBox(
                                                                width: 12 /
                                                                    412 *
                                                                    screenSize
                                                                        .width),
                                                            Text(
                                                              'Facebook',
                                                              style:
                                                                  TextStyle(
                                                                fontSize: 16 *
                                                                    textSize,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                            ),
                            Form(
                              key: _formKeyRegister,
                              child: AnimatedPositioned(
                                left: registerPosition,
                                height: 430 / 732 * screenSize.height,
                                width: 350 / 412 * screenSize.width,
                                duration: Duration(milliseconds: 200),
                                child: Container(
                                  height: 430 / 732 * screenSize.height,
                                  width: 350 / 412 * screenSize.width,
                                  decoration: BoxDecoration(),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 30, sigmaY: 30),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15 / 412 * screenSize.width,
                                                0 / 732 * screenSize.height,
                                                15 / 412 * screenSize.width,
                                                0 / 732 * screenSize.height),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height: 10 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      Alignment.topLeft,
                                                  child: Text(
                                                    "Register",
                                                    style: TextStyle(
                                                        fontSize:
                                                            35 * textSize,
                                                        color: Colors.black,
                                                        fontFamily: "POPPINS",
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25 /
                                                      732 *
                                                      screenSize.height,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme: ThemeData()
                                                          .colorScheme
                                                          .copyWith(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                    ),
                                                    child: TextFormField(
                                                        cursorColor:
                                                            Colors.red,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty ||
                                                              !EmailValidator
                                                                  .validate(
                                                                      value)) {
                                                            return "Enter a valid email";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            emailController2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 16 *
                                                                textSize),
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon: Icon(
                                                              Icons.mail),
                                                          focusColor:
                                                              Colors.red,
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorStyle:
                                                              TextStyle(
                                                            color: Colors
                                                                .red, // Change the font color to red.
                                                            fontSize: 12.0,
                                                            height:
                                                                0.1, // Change the font size to 12.
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 20 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                              horizontal: 12 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Email address',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 20 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme: ThemeData()
                                                          .colorScheme
                                                          .copyWith(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                    ),
                                                    child: TextFormField(
                                                        cursorColor:
                                                            Colors.red,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.length <
                                                                  6) {
                                                            return "Enter a password of min. length 6";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            passwordController2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 16 *
                                                                textSize),
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon: Icon(
                                                              Icons.lock),
                                                          focusColor:
                                                              Colors.red,
                                                          errorStyle:
                                                              TextStyle(
                                                            color: Colors
                                                                .red, // Change the font color to red.
                                                            fontSize: 12.0,
                                                            height:
                                                                0.1, // Change the font size to 12.
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 20 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                              horizontal: 12 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Password',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 20 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme: ThemeData()
                                                          .colorScheme
                                                          .copyWith(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                    ),
                                                    child: TextFormField(
                                                        cursorColor:
                                                            Colors.red,
                                                        validator: (value) {
                                                          if (passwordController3
                                                                      .text
                                                                      .trim() !=
                                                                  passwordController2
                                                                      .text
                                                                      .trim() &&
                                                              !(passwordController2
                                                                          .text
                                                                          .trim() ==
                                                                      "" ||
                                                                  passwordController2
                                                                          .text
                                                                          .trim()
                                                                          .length <
                                                                      6)) {
                                                            return 'Enter the same password';
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            passwordController3,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 16 *
                                                                textSize),
                                                        decoration:
                                                            InputDecoration(
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          errorStyle:
                                                              TextStyle(
                                                            color: Colors
                                                                .red, // Change the font color to red.
                                                            fontSize: 12.0,
                                                            height:
                                                                0.1, // Change the font size to 12.
                                                          ),
                                                          prefixIcon: Icon(
                                                              Icons.lock),
                                                          focusColor:
                                                              Colors.red,
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        100)),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 20 /
                                                                  732 *
                                                                  screenSize
                                                                      .height,
                                                              horizontal: 12 /
                                                                  412 *
                                                                  screenSize
                                                                      .width),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Repeat password',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 30 /
                                                        732 *
                                                        screenSize.height),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      register();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100),
                                                      ),
                                                    ).merge(ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all<Size>(
                                                        Size(
                                                            200 /
                                                                412 *
                                                                screenSize
                                                                    .width,
                                                            50 /
                                                                732 *
                                                                screenSize
                                                                    .height),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      224,
                                                                      0,
                                                                      0)),
                                                    )),
                                                    child: Text(
                                                      'Register',
                                                      style: TextStyle(
                                                          fontSize:
                                                              17 * textSize),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0 / 732 * screenSize.height,
                      ),
                      Visibility(
                        visible: !widget.guest["getIsGuest"]() && !isRegister,
                        child: Container(
                          child: TextButton(
                            onPressed: () {
                              widget.guest["setIsGuest"](true);
                            },
                            child: Text(
                              "Continue as guest",
                              style: TextStyle(
                                  fontSize: 17 * textSize,
                                  fontFamily: 'POPPINS',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Visibility(
                visible: isLoading,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}