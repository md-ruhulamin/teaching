// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:edtech/controller/controller.dart';
import 'package:edtech/model/bookmark.dart';

import 'package:edtech/screen/sign_up.dart';
import 'package:edtech/services/splash_services.dart';
import 'package:edtech/widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  final bookMarkController = BookMarkController();

  loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmartData = prefs.getString('bookmarkedItem');

    if (bookmartData != null) {
      final decodedData = jsonDecode(bookmartData);
      final bookmark = Bookmark.fromJson(decodedData);

      bookMarkController.bookmark.assignAll(decodedData); // Update t
      print(bookmark);
    }
  }

  double mobile = 450;
  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
    bookMarkController.bookmark();
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    print(_width);
    return Scaffold(
        backgroundColor: Colors.green,
        body: SingleChildScrollView(
          child: Container(
            padding: _width > mobile
                ? EdgeInsets.only(left: 40, right: 40)
                : EdgeInsets.only(left: 10, right: 10,top: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Text(
                        "  EDCT",
                        style: TextStyle(
                            fontSize: _width > mobile ? 12 : 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Expanded(child: SizedBox()),
           if(_width>mobile)             SplashButton(text: "Home"),
                      SizedBox(
                        width: defaulstspace,
                      ),
               if(_width>mobile)         SplashButton(text: "Contact Us"),
                      SizedBox(
                        width: defaulstspace,
                      ),
                if(_width>mobile)      SplashButton(text: "About Us"),
                      SizedBox(
                        width: defaulstspace,
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(SignUpScreen());
                          },
                          child: SplashButton(text: "Sign In")),
                      SizedBox(
                        width: defaulstspace,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Education Academy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: _width > mobile ? 53 : 25,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "“Being a student is easy.Learning requires actual work.“\n—William Crawford ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: _width > mobile ? 23 : 12,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          if (_width < mobile)
                            Image.asset(
                              "assets/images/learnimg.png",
                              height: _width > mobile ? 450 : 220,
                              alignment: Alignment.center,
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  alignment: Alignment.center,
                                  width: _width > mobile ? 230 : 220,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 90, 236, 114),
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: BigText(
                                    text: "Get Started",
                                    size:_width>mobile? 22:17,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    if (_width > mobile)
                      Image.asset(
                        "assets/images/learnimg.png",
                        height:  450 ,
                        alignment: Alignment.center,
                      ),
                  ],
                ),

                //  RotatingSquare(),
                // SizedBox(
                //   height: 40,
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       " Learn through practical \nexperience",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         fontFamily: "Montserrat",
                //         fontSize: 18,
                //         color: Color.fromARGB(255, 112, 108, 108),
                //       ),
                //     ),
                //     //   Text(" Every Day",
                //     //       style: TextStyle(
                //     //         fontSize: 18,
                //     //         color: Colors.red,
                //     //       )),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ));
  }
}

class SplashButton extends StatelessWidget {
  final String text;
   SplashButton({
    super.key,
    required this.text,
  });
  double mobile = 450;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
     
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: _width > mobile ? 20 : 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

const double defaulstspace = 10;
