import 'package:mnit_canteen_app/screens/admin_page.dart';

import './authenticationScreen.dart';
import './homeScreen.dart';
import '../widgets/authScreenForm.dart';
import 'package:flutter/material.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  final titleOfApp = "Canteen MNIT";
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("img6", "Welcome to MNIT canteen"),
                    onBoardPage("img2", "Place your order Now"),
                    onBoardPage("img2", "Lorem ipsum "),
                  ],
                  onPageChanged: (value) => {setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/path.png'),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: openLoginPage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 9),
                            blurRadius: 20,
                            spreadRadius: 3)
                      ]),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AuthenticationScreen(titleOfApp)));
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                    },
                    child: Text(
                      "Login as admin",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardPage(String img, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(140),
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$img.jfif'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        //   child: Text(
        //     "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
        //     style: TextStyle(fontSize: 16, color: Colors.grey),
        //     textAlign: TextAlign.center,
        //   ),
        // )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  openLoginPage() {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
}
