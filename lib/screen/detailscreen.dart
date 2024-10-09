// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names, must_be_immutable

import 'package:chewie/chewie.dart';

import 'package:edtech/controller/controller.dart';
import 'package:edtech/model/bookmark.dart';
import 'package:edtech/screen/bookmark_screen.dart';
import 'package:edtech/screen/signin_Test.dart';
import 'package:edtech/widget/big_text.dart';
import 'package:edtech/widget/primary_btn.dart';
import 'package:edtech/responsive/responsive.dart';
import 'package:edtech/data/courseList.dart';
import 'package:edtech/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:video_player/video_player.dart';

enum DataSourceType { network, asset, contentUri }

class CourseDetailScreen extends StatefulWidget {
  final int courseid;
  const CourseDetailScreen({super.key, required this.courseid});

  @override
  State<CourseDetailScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // print("Width ${MediaQuery.of(context).size.width}");

    // print("Height ${MediaQuery.of(context).size.height}");

    return Responsive(
      desktop: DetailScreenForDeskTop(courseId: widget.courseid),
      tablet: DetailScreenForTablet(courseId: widget.courseid),
      mobile: DetailScreenForDeskTop2(courseId: widget.courseid),
    );
  }
}

class DetailScreenForDeskTop2 extends StatefulWidget {
  int courseId;

  DetailScreenForDeskTop2({super.key, required this.courseId});

  @override
  State<DetailScreenForDeskTop2> createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreenForDeskTop2> {
  BookMarkController bookMarkController = BookMarkController();
  List<Bookmark> bookmarks = [];
  final TextEditingController _bookmarkController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  //    Uri.parse('https://youtu.be/fDzF_w6iJrQ?si=jVfQl5atylLfzqxJ')

  String videoUrl1 =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  // 'https://www.youtube.com/watch?v=dIwPi6sX2uQ';
//      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  int videoID = 0;
  bool playing = true;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl1));
    _videoPlayerController.play();
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      looping: true,
      autoPlay: true,
      startAt: const Duration(seconds: 0),
      videoPlayerController: _videoPlayerController,
    );

    super.initState();
  }

  void loadProperties(String videoUrl, int index) {
    playing = true;
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      autoPlay: true,
      startAt: const Duration(seconds: 0),
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
    );

    _bookMarkController.selectedItem.value = index + 1;
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    _bookmarkController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  BookMarkController _bookMarkController = BookMarkController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      // appBar: AppBar(
      //     backgroundColor: Colors.transparent,
      //     centerTitle: true,
      //     title: Text(tutorialList[widget.courseId].title.toString()),
      //     titleTextStyle: TextStyle(fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //     fontFamily: "Montserrat",
      //     color: Colors.black),
      //     // actions: [
      //     //   IconButton(
      //     //       onPressed: () {
      //     //         _auth.signOut();
      //     //         Get.off(SignInScreen());
      //     //       },
      //     //       icon: Icon(
      //     //         Icons.logout,
      //     //       )),
      //     // ]

      //     ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 7, right: 7),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          tutorialList[widget.courseId].title.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.black),
                        )
                      ],
                    ),
                    Expanded(
                      child: Chewie(controller: _chewieController),
                    ),
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (0 < selectedIndex) {
                                  selectedIndex--;
                                  videoID = selectedIndex + 1;
                                  loadProperties(videoUrl1, videoID);
                                }
                              });
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image:
                                    AssetImage("assets/images/previous.png"))),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            onTap: () {
                              if (_chewieController.isPlaying) {
                                _chewieController.pause();
                                playing = false;
                              } else {
                                _chewieController.play();
                                playing = true;
                              }
                              setState(() {});
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image: playing
                                    ? AssetImage("assets/images/pause.png")
                                    : AssetImage("assets/images/play.png"))),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (chapterList.length > selectedIndex + 1) {
                                  selectedIndex++;
                                  videoID = selectedIndex + 1;
                                  loadProperties(videoUrl1, videoID);
                                }
                              });
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image: AssetImage("assets/images/next.png"))),
                        //      Expanded(child: SizedBox()),
                        // if (selectedIndex + 1 == chapterList.length)
                        //   SizedBox(
                        //     width: 200,
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         showClaimCertificateMessage(context);
                        //       },
                        //       child: RoundButton(
                        //         title: "Get Certificate",
                        //       ),
                        //     ),
                        //   ),
                        // Expanded(child: SizedBox()),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // GestureDetector(
                        //   onTap: () {
                        //     _chewieController.pause();

                        //     openBottomSheet(context);
                        //   },
                        //   child: RoundButton(
                        //     title: "Bookmark",
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     _chewieController.pause();
                        //     Get.to(BookmarksScreen(
                        //       videoId: videoID,
                        //     ));
                        //   },
                        //   child: RoundButton(
                        //     title: "See all",
                        //   ),
                        // ),
                        //  SizedBox(
                        //     width: 20,
                        //   ),
                        //  ],
                        //  ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //   margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor3,
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeRight: true,
                          child: ListView.builder(
                              itemCount: chapterList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _bookMarkController
                                                .selectedItem.value = videoID;
                                            selectedIndex = index;
                                            videoID = selectedIndex + 1;
                                            loadProperties(videoUrl1, videoID);
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? Colors.green
                                                    : AppColors.paraColor,
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              "${index + 1}. ${chapterList[index].title}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17),
                                            ))));
                              }),
                        )),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Add your bottom sheet content here
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Book Mark Info'),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bookmarkController,
                decoration: InputDecoration(hintText: "Book Mark Info"),
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    Navigator.of(context).pop();

                    _bookmarkController.clear();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    bookMarkController.saveBookMark(
                      videoID,
                      _videoPlayerController.value.position.toString(),
                      _bookmarkController.text.toString(),
                    );

                    _bookMarkController.addDataToFirestore(
                        videoID,
                        _videoPlayerController.value.position.toString(),
                        _bookmarkController.text.toString());
                    Navigator.of(context).pop();
                    _bookmarkController.clear();
                  },
                  child: Text('Save'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  void showClaimCertificateMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Claim Your Certificate'),
        action: SnackBarAction(
          label: 'Claim',
          onPressed: () {
            // Redirect to the dashboard or take appropriate action
            Navigator.of(context).pop(); // Close the Snackbar
            // Redirect logic here
          },
        ),
      ),
    );
  }
}

class DetailScreenForDeskTop extends StatefulWidget {
  int courseId;

  DetailScreenForDeskTop({super.key, required this.courseId});

  @override
  State<DetailScreenForDeskTop> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreenForDeskTop> {
  BookMarkController bookMarkController = BookMarkController();
  List<Bookmark> bookmarks = [];
  final TextEditingController _bookmarkController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  //    Uri.parse('https://youtu.be/fDzF_w6iJrQ?si=jVfQl5atylLfzqxJ')

  String videoUrl1 =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  // 'https://www.youtube.com/watch?v=dIwPi6sX2uQ';
//      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  int videoID = 0;
  bool playing = true;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl1));
    _videoPlayerController.play();
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      looping: true,
      autoPlay: true,
      startAt: const Duration(seconds: 0),
      videoPlayerController: _videoPlayerController,
    );

    super.initState();
  }

  void loadProperties(String videoUrl, int index) {
    playing = true;
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      autoPlay: true,
      startAt: const Duration(seconds: 0),
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
    );

    _bookMarkController.selectedItem.value = index + 1;
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    _bookmarkController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  BookMarkController _bookMarkController = BookMarkController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(tutorialList[widget.courseId].title.toString()),
          titleTextStyle: TextStyle(fontSize: 35, color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Get.off(SignInScreen());
                },
                icon: Icon(
                  Icons.logout,
                )),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              if (_width > 450)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor3,
                      borderRadius: BorderRadius.circular(10)),
                  width: 350,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: 20, right: 10, top: 5, bottom: 5),
                        //   child: BigText(
                        //     text: "List of Content",
                        //     color: Colors.white,
                        //     size: 23,
                        //   ),
                        // ),
                        Expanded(
                            child: MediaQuery.removePadding(
                          context: context,
                          removeRight: true,
                          child: ListView.builder(
                              itemCount: chapterList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _bookMarkController
                                                .selectedItem.value = videoID;
                                            selectedIndex = index;
                                            videoID = selectedIndex + 1;
                                            loadProperties(videoUrl1, videoID);
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? Colors.greenAccent
                                                    : AppColors.paraColor,
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              "${index + 1}. ${chapterList[index].title}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ))));
                              }),
                        )),
                      ]),
                ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Chewie(controller: _chewieController),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (0 < selectedIndex) {
                                  selectedIndex--;
                                  videoID = selectedIndex + 1;
                                  loadProperties(videoUrl1, videoID);
                                }
                              });
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image:
                                    AssetImage("assets/images/previous.png"))),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            onTap: () {
                              if (_chewieController.isPlaying) {
                                _chewieController.pause();
                                playing = false;
                              } else {
                                _chewieController.play();
                                playing = true;
                              }
                              setState(() {});
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image: playing
                                    ? AssetImage("assets/images/pause.png")
                                    : AssetImage("assets/images/play.png"))),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (chapterList.length > selectedIndex + 1) {
                                  selectedIndex++;
                                  videoID = selectedIndex + 1;
                                  loadProperties(videoUrl1, videoID);
                                }
                              });
                            },
                            child: Image(
                                height: 50,
                                width: 50,
                                image: AssetImage("assets/images/next.png"))),
                        //      Expanded(child: SizedBox()),
                        // if (selectedIndex + 1 == chapterList.length)
                        //   SizedBox(
                        //     width: 200,
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         showClaimCertificateMessage(context);
                        //       },
                        //       child: RoundButton(
                        //         title: "Get Certificate",
                        //       ),
                        //     ),
                        //   ),
                        // Expanded(child: SizedBox()),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // GestureDetector(
                        //   onTap: () {
                        //     _chewieController.pause();

                        //     openBottomSheet(context);
                        //   },
                        //   child: RoundButton(
                        //     title: "Bookmark",
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     _chewieController.pause();
                        //     Get.to(BookmarksScreen(
                        //       videoId: videoID,
                        //     ));
                        //   },
                        //   child: RoundButton(
                        //     title: "See all",
                        //   ),
                        // ),
                        //  SizedBox(
                        //     width: 20,
                        //   ),
                        //  ],
                        //  ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Add your bottom sheet content here
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Book Mark Info'),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bookmarkController,
                decoration: InputDecoration(hintText: "Book Mark Info"),
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    Navigator.of(context).pop();

                    _bookmarkController.clear();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    bookMarkController.saveBookMark(
                      videoID,
                      _videoPlayerController.value.position.toString(),
                      _bookmarkController.text.toString(),
                    );

                    _bookMarkController.addDataToFirestore(
                        videoID,
                        _videoPlayerController.value.position.toString(),
                        _bookmarkController.text.toString());
                    Navigator.of(context).pop();
                    _bookmarkController.clear();
                  },
                  child: Text('Save'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  void showClaimCertificateMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Claim Your Certificate'),
        action: SnackBarAction(
          label: 'Claim',
          onPressed: () {
            // Redirect to the dashboard or take appropriate action
            Navigator.of(context).pop(); // Close the Snackbar
            // Redirect logic here
          },
        ),
      ),
    );
  }
}

class DetailScreenForTablet extends StatefulWidget {
  int courseId;

  DetailScreenForTablet({super.key, required this.courseId});

  @override
  State<DetailScreenForTablet> createState() => _DetailScreenForTabletState();
}

class _DetailScreenForTabletState extends State<DetailScreenForTablet> {
  BookMarkController bookMarkController = BookMarkController();
  List<Bookmark> bookmarks = [];
  TextEditingController _bookmarkController = TextEditingController();
  late VideoPlayerController _videoPlayerController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ChewieController _chewieController;

  //    Uri.parse('https://youtu.be/fDzF_w6iJrQ?si=jVfQl5atylLfzqxJ')

  String videoUrl1 =

      //'https://www.youtube.com/watch?v=dIwPi6sX2uQ';
      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  @override
  int videoID = 0;
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl1));
    _videoPlayerController.play();
    _chewieController = ChewieController(
        looping: true,
        autoPlay: true,
        startAt: const Duration(seconds: 0),
        videoPlayerController: _videoPlayerController,
        aspectRatio: 1);
    setState(() {});
    super.initState();
  }

  void loadProperties(String videoUrl) {
    _chewieController = ChewieController(
        autoPlay: true,
        startAt: const Duration(seconds: 0),
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
        aspectRatio: 1);
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    _bookmarkController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackgroundColor3,
      appBar:
          AppBar(title: const Text("Your Favorite Course is Here "), actions: [
        IconButton(
            onPressed: () {
              _auth.signOut();
              Get.off(SignInScreen());
            },
            icon: Icon(
              Icons.logout,
            )),
      ]),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: Row(
            children: [
              Container(
                width: 220,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BigText(
                        text: "List of Content",
                        color: Colors.white,
                        size: 17,
                      ),
                      Expanded(
                          child: MediaQuery.removePadding(
                        context: context,
                        removeRight: true,
                        child: ListView.builder(
                            itemCount: chapterList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  color: selectedIndex == index
                                      ? Colors.green
                                      : Colors.greenAccent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          //   videoUrl1 = videoUrl1;
                                          selectedIndex = index;
                                          loadProperties(videoUrl1);
                                        });
                                      },
                                      child: Text(chapterList[index].title)));
                            }),
                      )),
                    ]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Chewie(controller: _chewieController),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (0 < selectedIndex) {
                                  selectedIndex--;
                                  loadProperties(videoUrl1);
                                }
                              });
                            },
                            child: const RoundButton(title: "Previous")),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (chapterList.length > selectedIndex + 1) {
                                  selectedIndex++;
                                  loadProperties(videoUrl1);
                                  print(selectedIndex);
                                  print(chapterList.length);
                                }
                              });
                            },
                            child: const RoundButton(title: "Next")),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openBottomSheet(context);
                          },
                          child: RoundButton(
                            title: "Bookmark",
                          ),
                        ),
                        if (selectedIndex + 1 == chapterList.length)
                          GestureDetector(
                              onTap: () {
                                showClaimCertificateMessage(context);
                              },
                              child: RoundButton(
                                title: "Certificate",
                              )),
                        GestureDetector(
                          onTap: () {
                            _chewieController.pause();
                            Get.to(BookmarksScreen(
                              videoId: selectedIndex,
                            ));
                          },
                          child: RoundButton(
                            title: "See all",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Add your bottom sheet content here
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Book Mark Info'),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bookmarkController,
                decoration: InputDecoration(hintText: "Book Mark Info"),
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    Navigator.of(context).pop();

                    _bookmarkController.clear();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bookMarkController.addDataToFirestore(
                      videoID,
                      _videoPlayerController.value.position.toString(),
                      _bookmarkController.text.toString(),
                    );

                    Navigator.of(context).pop();
                    _bookmarkController.clear();
                  },
                  child: Text('Save'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  void showClaimCertificateMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Claim Your Certificate'),
        action: SnackBarAction(
          label: 'Claim',
          onPressed: () {
            // Redirect to the dashboard or take appropriate action
            Navigator.of(context).pop(); // Close the Snackbar
            // Redirect logic here
          },
        ),
      ),
    );
  }
}

class DetailScreenForMobile extends StatefulWidget {
  int courseId;

  DetailScreenForMobile({super.key, required this.courseId});

  @override
  State<DetailScreenForMobile> createState() => _DetailScreenForMobileState();
}

class _DetailScreenForMobileState extends State<DetailScreenForMobile> {
  BookMarkController bookMarkController = BookMarkController();
  List<Bookmark> bookmarks = [];

  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  //    Uri.parse('https://youtu.be/fDzF_w6iJrQ?si=jVfQl5atylLfzqxJ')

  String videoUrl1 =

      //'https://www.youtube.com/watch?v=dIwPi6sX2uQ';
      //'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  @override
  int videoID = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _bookmarkController = TextEditingController();
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl1));
    _videoPlayerController.play();
    _chewieController = ChewieController(
        looping: true,
        autoPlay: true,
        startAt: const Duration(seconds: 0),
        videoPlayerController: _videoPlayerController,
        aspectRatio: 1);
    setState(() {});
    super.initState();
  }

  void loadProperties(String videoUrl) {
    _chewieController = ChewieController(
        autoPlay: true,
        startAt: const Duration(seconds: 0),
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
        aspectRatio: 1);
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    _bookmarkController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackgroundColor3,
      appBar: AppBar(
          title: BigText(
            text: "Your Favorite Course is Here ",
            size: 14,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Get.off(SignInScreen());
                },
                icon: Icon(
                  Icons.logout,
                )),
          ]),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: Chewie(controller: _chewieController),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (0 < selectedIndex) {
                              selectedIndex--;
                              videoID = selectedIndex + 1;
                              loadProperties(videoUrl1);
                            }
                          });
                        },
                        child: const RoundButton(title: "Previous")),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (chapterList.length > selectedIndex + 1) {
                              selectedIndex++;
                              videoID = selectedIndex + 1;
                              loadProperties(videoUrl1);
                            }
                          });
                        },
                        child: const RoundButton(title: "Next")),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          openBottomSheet(context);
                        });
                      },
                      child: RoundButton(
                        title: "Bookmark",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _chewieController.pause();
                        Get.to(BookmarksScreen(
                          videoId: selectedIndex,
                        ));
                      },
                      child: RoundButton(
                        title: "See all",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (selectedIndex + 1 == chapterList.length)
                  GestureDetector(
                    onTap: () {
                      showClaimCertificateMessage(context);
                    },
                    child: RoundButton(
                      title: "Certificate",
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
      drawer: Container(
        width: 200,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(
                text: "List of Content",
                color: Colors.white,
                size: 17,
              ),
              Expanded(
                  child: MediaQuery.removePadding(
                context: context,
                removeRight: true,
                child: ListView.builder(
                    itemCount: chapterList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          color: selectedIndex == index
                              ? AppColors.paraColor
                              : Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  //   videoUrl1 = videoUrl1;
                                  selectedIndex = index;
                                  loadProperties(videoUrl1);
                                });
                              },
                              child: Text(chapterList[index].title)));
                    }),
              )),
            ]),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Add your bottom sheet content here
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Book Mark Info'),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bookmarkController,
                decoration: InputDecoration(hintText: "Book Mark Info"),
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet if needed
                    Navigator.of(context).pop();

                    _bookmarkController.clear();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bookMarkController.addDataToFirestore(
                      videoID,
                      _videoPlayerController.value.position.toString(),
                      _bookmarkController.text.toString(),
                    );

                    Navigator.of(context).pop();
                    _bookmarkController.clear();
                  },
                  child: Text('Save'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}

void showClaimCertificateMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Congratulations! Claim Your Certificate'),
      action: SnackBarAction(
        label: 'Claim',
        onPressed: () {
          // Redirect to the dashboard or take appropriate action
          Navigator.of(context).pop(); // Close the Snackbar
          // Redirect logic here
        },
      ),
    ),
  );
}
