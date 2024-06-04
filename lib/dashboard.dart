import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_therapy/alphabet.dart';
import 'package:speech_therapy/classes/language.dart';
import 'package:speech_therapy/classes/language_constants.dart';
import 'package:speech_therapy/feedback%20screen.dart';
import 'package:speech_therapy/food.dart';
import 'package:speech_therapy/game.dart';
import 'package:speech_therapy/material.dart';
import 'package:speech_therapy/numbers.dart';
import 'package:speech_therapy/report_screen.dart';
import 'package:speech_therapy/family.dart';
import 'package:speech_therapy/main.dart';
import 'package:speech_therapy/action.dart';
import 'package:speech_therapy/clothing.dart';
import 'package:speech_therapy/animal.dart';
import 'package:speech_therapy/body_part.dart';
import 'package:speech_therapy/feeling.dart';
import 'package:speech_therapy/reference.dart';
import 'package:speech_therapy/speechs.dart';
import 'package:speech_therapy/color.dart';
import 'package:speech_therapy/utils/logging_util.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  var Height, Width;
  final LoggingUtil loggingUtil = LoggingUtil();

  final List<String> imageData = [
    "images/category/alphabet.png",
    "images/category/numbers.png",
    "images/category/diet.png",
    "images/category/material.png",
    "images/category/clothing.png",
    "images/category/talking.png",
    "images/category/livestock.png",
    "images/category/emotion.png",
    "images/category/colour.png",
    "images/category/reference.png",
    "images/category/action.png",
    "images/category/family.png",
    "images/category/humanoid.png",
  ];

  @override
  Widget build(BuildContext context) {
    Height = MediaQuery.of(context).size.height;
    Width = MediaQuery.of(context).size.width;

    final List<String> titles = [
      translation(context).alphabets,
      translation(context).numbers,
      translation(context).foods,
      translation(context).materials,
      translation(context).clothing,
      translation(context).speechs,
      translation(context).animals,
      translation(context).feelings,
      translation(context).colours,
      translation(context).references,
      translation(context).actions,
      translation(context).family,
      translation(context).body_parts,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Height * 0.20,
              width: Width,
              color: Colors.indigo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 22, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                _openDrawer(context);
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<Language>(
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.language_outlined,
                              color: Colors.white,
                            ),
                            onChanged: (Language? language) async {
                              if (language != null) {
                                Locale _locale =
                                    await setLocale(language.languageCode);
                                MyApp.setLocale(context, _locale);
                              }
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) => DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          e.flag,
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                        Text(e.name)
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      translation(context).dashboard_title,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              width: Width,
              padding: EdgeInsets.only(bottom: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imageData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _logAndNavigate(context, index, titles[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imageData[index],
                            width: 100,
                          ),
                          Text(
                            titles[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                translation(context).dashboard_title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/report.png'),
              title: Text('Report', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen()),
                );
              },
            ),
            SizedBox(height: 15), // Add space between the list items

            ListTile(
              leading: Image.asset('assets/game.png'),
              title: Text('Game', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
            ),
            SizedBox(height: 15), // Add space between the list items
            ListTile(
              leading: Image.asset('assets/feedback.png'),
              title: Text('Feedback', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),
            SizedBox(height: 15), // Add space between the list items
            ListTile(
              leading: Image.asset('assets/logout.png'),
              title: Text('Exit', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
                SystemNavigator.pop(); // Close the app
              },
            ),
          ],
        ),
      ),
    );
  }

  void _logAndNavigate(BuildContext context, int index, String title) {
    _navigateToPage(context, index);
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => alphabet()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => numbers()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => material()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => clothing()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => speechs()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => animal()),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => feeling()),
        );
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => color()),
        );
        break;
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => reference()),
        );
        break;
      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => action()),
        );
        break;
      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => family()),
        );
        break;
      case 12:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => body_part()),
        );
        break;

      default:
        break;
    }
  }
}

void _openDrawer(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
