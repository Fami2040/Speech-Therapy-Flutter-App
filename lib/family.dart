import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_therapy/classes/language_constants.dart';
import 'package:speech_therapy/controllers/family_am_controller.dart';
import 'package:speech_therapy/controllers/family_en_controller.dart';
import 'package:speech_therapy/custom%20Widget/custom%20widget.dart';
import 'package:speech_therapy/dashboard.dart';
import 'package:speech_therapy/utils/logging_util.dart';

class family extends StatefulWidget {
  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<family> {
  final LoggingUtil loggingUtil = LoggingUtil();

  var Height, Width;
  bool isEnglish = true; // Initially English

  final List<String> imageData = [
    "images/family/father.png",
    "images/family/mother.png",
    "images/family/brother.png",
    "images/family/sister.png",
    "images/family/uncle.png",
    "images/family/aunt.png",
    "images/family/grand_father.png",
    "images/family/grand_mother.png",
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String assetPath) async {
    try {
      await _audioPlayer.setAsset(assetPath);
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio source: $e");
    }
  }
  void _logUsage(String feature) {
    loggingUtil.logScreenUsage(feature, Duration(seconds: 1), 'Family Categories');
  }


  @override
  Widget build(BuildContext context) {
    Height = MediaQuery.of(context).size.height;
    Width = MediaQuery.of(context).size.width;

    final List<String> titles = isEnglish
        ? [
            translation(context).family_father,
            translation(context).family_mother,
            translation(context).family_brother,
            translation(context).family_sister,
            translation(context).family_uncle,
            translation(context).family_aunt,
            translation(context).family_grand_father,
            translation(context).family_grand_mother,
          ]
        : [
            "አባት",
            "እናት",
            "ወንድም",
            "እህት",
            "ኣጎት",
            "አክስት",
            "አያት",
            "አያት",
          ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 68, 133, 71),
          width: Width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: Height * 0.20,
                width: Width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 30, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          IconWithText(
                            icon: Icons.speaker_phone,
                            text: isEnglish
                                ? 'Change to Amharic'
                                : 'ወደ እንግሊዝኛ ቀይር',
                            onPressed: () {
                              setState(() {
                                isEnglish = !isEnglish;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isEnglish ? translation(context).family : "ቤተሰብ",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: Width,
                  padding: EdgeInsets.only(),
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
                          _playAudio(
                            isEnglish
                                ? FamilyEnList[index].audio
                                : FamilyAmList[index].audio,
                          );
                          _logUsage(titles[index]);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
