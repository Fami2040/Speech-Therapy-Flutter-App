import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_therapy/classes/language_constants.dart';
import 'package:speech_therapy/controllers/Latinalphabet_en_controller.dart';
import 'package:speech_therapy/custom%20Widget/custom%20widget.dart';
import 'package:speech_therapy/dashboard.dart';
import 'package:speech_therapy/utils/logging_util.dart';

class alphabet extends StatefulWidget {
  @override
  _AlphabetPageState createState() => _AlphabetPageState();
}

class _AlphabetPageState extends State<alphabet> {
  final LoggingUtil loggingUtil = LoggingUtil();

  var Height, Width;
  bool isEnglish = true; // Initially English

  final List<String> imageData = [
    "images/alphabets/letter-a.png",
    "images/alphabets/letter-b.png",
    "images/alphabets/letter-c.png",
    "images/alphabets/letter-d.png",
    "images/alphabets/letter-e.png",
    "images/alphabets/letter-f.png",
    "images/alphabets/letter-g.png",
    "images/alphabets/letter-h.png",
    "images/alphabets/letter-i.png",
    "images/alphabets/letter-j.png",
    "images/alphabets/letter-k.png",
    "images/alphabets/letter-l.png",
    "images/alphabets/letter-m.png",
    "images/alphabets/letter-n.png",
    "images/alphabets/letter-o.png",
    "images/alphabets/letter-p.png",
    "images/alphabets/letter-q.png",
    "images/alphabets/letter-r.png",
    "images/alphabets/letter-s.png",
    "images/alphabets/letter-t.png",
    "images/alphabets/letter-u.png",
    "images/alphabets/letter-v.png",
    "images/alphabets/letter-w.png",
    "images/alphabets/letter-x.png",
    "images/alphabets/letter-y.png",
    "images/alphabets/letter-z.png"
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
    loggingUtil.logScreenUsage(
        feature, Duration(seconds: 1), 'Alphabets Categories');
  }

  @override
  Widget build(BuildContext context) {
    Height = MediaQuery.of(context).size.height;
    Width = MediaQuery.of(context).size.width;

    final List<String> titles = isEnglish
        ? [
            translation(context).a,
            translation(context).b,
            translation(context).c,
            translation(context).d,
            translation(context).e,
            translation(context).f,
            translation(context).g,
            translation(context).h,
            translation(context).i,
            translation(context).j,
            translation(context).k,
            translation(context).l,
            translation(context).m,
            translation(context).n,
            translation(context).o,
            translation(context).p,
            translation(context).q,
            translation(context).r,
            translation(context).s,
            translation(context).t,
            translation(context).u,
            translation(context).v,
            translation(context).w,
            translation(context).x,
            translation(context).y,
            translation(context).z
          ]
        : [
            "አ",
            "ቢ",
            "ሲ",
            "ዲ",
            "ኢ",
            "ኤፍ",
            "ጂ",
            "ኤች",
            "አይ",
            "ጄ",
            "ኬ",
            "ኤል",
            "ኤም",
            "ኤን",
            "ኦ",
            "ፒ",
            "ኩ",
            "አር",
            "ኤስ",
            "ቲ",
            "ዩ",
            "ቪ",
            "ዳብልዩ",
            "ኤክስ",
            "ዋይ",
            "ዘ"
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
                              size: 25,
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
                            isEnglish ? translation(context).alphabets : "ፊደላት",
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
                                ? LatinAlphabetEnList[index].audio
                                : LatinAlphabetEnList[index].audio,
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
