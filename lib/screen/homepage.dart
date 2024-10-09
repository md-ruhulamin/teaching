// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:edtech/widget/big_text.dart';
import 'package:edtech/responsive/responsive.dart';
import 'package:edtech/data/courseList.dart';
import 'package:edtech/screen/detailscreen.dart';
import 'package:edtech/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget build(BuildContext context) {
    return Responsive(
      mobile: CourseListForMobile(),
      tablet: CourseListFortablet(),
      desktop: CourseListForDeksTop(),
    );
  }
}

class ShowCourseList extends StatelessWidget {
  final int numberofCourse;
  const ShowCourseList({super.key, required this.numberofCourse});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numberofCourse,
            ),
            itemCount: tutorialList.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(
                  10,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor2,
                    borderRadius: BorderRadius.circular(10)),
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        image: AssetImage(tutorialList[index].imgUrl)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      tutorialList[index].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(CourseDetailScreen(
                          courseid: index,
                        ));
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 90, 236, 114),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: "Continue",
                              color: Colors.white,
                              size: 20,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

class CourseListForMobile extends StatelessWidget {
  const CourseListForMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        double _width = MediaQuery.of(context).size.width;
    return Scaffold(
         backgroundColor:  Colors.green,
     
      body: Center(
          child: Container(
       
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
            //    crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  BigText(
                    text: "Enrolled Courses",
                    color: Colors.white,
                    size: 23,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ShowCourseList(numberofCourse: 1)
            ]),
      )),
    );
  }
}

class CourseListFortablet extends StatelessWidget {
  const CourseListFortablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackgroundColor3,
      body: Center(
          child: Container(
        width: 600,
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(children: [
          BigText(
            text: "Enrolled Courses",
            color: Colors.white,
            size: 30,
          ),
          ShowCourseList(numberofCourse: 2)
        ]),
      )),
    );
  }
}

class CourseListForDeksTop extends StatelessWidget {
  const CourseListForDeksTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

             backgroundColor:  Colors.green,
      //   backgroundColor: AppColors.buttonBackgroundColor3,
      body: Center(
          child: Container(
        width: 1000,
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
            //    crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  BigText(
                    text: "Enrolled Courses",
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ShowCourseList(numberofCourse: 3)
            ]),
      )),
    );
  }
}
