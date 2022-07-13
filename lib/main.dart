import 'dart:ffi';
import 'dart:ui';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:google_nav_bar/google_nav_bar.dart';

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7353B445-780B-457B-AF62-A6F374136A3B';
const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
var response;
List<double> bitcoinprice = [];

double bitprice = 0.0;
double difference = 0.0;
void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  getdata() async {
    response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/INR?apikey=$apiKey#'));
    print(response.body);
    print(jsonDecode(response.body)['rate']);
    bitprice = jsonDecode(response.body)['rate'];
    setState(() {
      bitprice;
      bitcoinprice.add(bitprice);
      bitcoinprice;
      print(bitcoinprice);
      difference = bitcoinprice[(bitcoinprice.length) - 1] - bitcoinprice[0];
      print('Difference=$difference');
    });
    print(bitcoinprice);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 10),
                    child: Icon(
                      Icons.money,
                      size: 50,
                      color: Color(0xfff9911c),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 18, top: 10),
                    child: Text(
                      "Crypto Tracker",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25)],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Align(
                  child: Row(children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_bitcoin_outlined,
                                size: 38,
                                color: Color(0xfff9911c),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Bitcoin BTC     ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 9),
                            padding: EdgeInsets.all(10),
                            height: 76,
                            width: 170,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87),
                                borderRadius: BorderRadius.circular(12)),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("$bitprice")),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "$difference",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_upward_outlined,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Image.asset(
                      'images/graph.png',
                      width: 150,
                      height: 130,
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                onPressed: () {
                  getdata();
                },
                height: 50,
                minWidth: 50,
                color: Colors.black,
              ),

              /*   Container(
                padding: EdgeInsets.only(right: 185, top: 40),
                child: Text(
                  "Select Currency",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              /*GNav(
                  rippleColor:
                      Colors.grey, // tab button ripple color when pressed
                  hoverColor: Colors.black12, // tab button hover color
                  haptic: true, // haptic feedback
                  tabBorderRadius: 15,
                  tabActiveBorder: Border.all(
                      color: Colors.black, width: 1), // tab button border
                  tabBorder: Border.all(
                      color: Colors.grey, width: 1), // tab button border
                  tabShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), blurRadius: 8)
                  ], // tab button shadow
                  curve: Curves.easeOutExpo, // tab animation curves
                  duration:
                      Duration(milliseconds: 900), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: Colors.grey[800], // unselected icon color
                  activeColor: Colors.purple, // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor: Colors.purple
                      .withOpacity(0.1), // selected tab background color
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5), // navigation bar padding
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      onPressed: () {
                        btcinr();
                      },
                    ),
                    GButton(
                      icon: Icons.heart_broken,
                      text: 'Likes',
                      onPressed: () {
                        btcinr();
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                      onPressed: () {
                        btcinr();
                      },
                    ),
                    GButton(
                      icon: Icons.people,
                      text: 'Profile',
                      onPressed: () {
                        print("object");
                        btcinr();
                      },
                    )
                  ])*/

              /* GestureDetector(
                child: SalomonBottomBar(
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                  items: [
                    SalomonBottomBarItem(
                      icon: Icon(LineIcons.indianRupeeSign),
                      title: Text("INR"),
                      selectedColor: Colors.purple,
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(LineIcons.dollarSign),
                      title: Text("USD"),
                      selectedColor: Colors.pink,
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(LineIcons.yenSign),
                      title: Text("JYP"),
                      selectedColor: Colors.orange,
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(LineIcons.euroSign),
                      title: Text("EUR"),
                      selectedColor: Colors.teal,
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
