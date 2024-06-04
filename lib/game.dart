import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class Game extends StatefulWidget {
  @override
  _ColorGameState createState() => _ColorGameState();
}

class _ColorGameState extends State<Game> {
  final Map<String, bool> score = {};
  final Map<String, String> choices = {
    'ብርድ': 'images/feeling/cold.png',
    'መራብ': 'images/feeling/hungry.png',
    'ሀዘን': 'images/feeling/sad.png',
    'ደስታ': 'images/feeling/smile.png',
    'ሙቀት': 'images/feeling/hot.png',
    'መረበሽ': 'images/feeling/frustrated.png',
    'ድብርት': 'images/feeling/depression.png',
  };
  int seed = 0;
  final AudioPlayer _player = AudioPlayer();
  bool gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ነጥብ ${score.length} / ${choices.length}',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
            gameOver = false;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'ስሜቶቹን አዛምድ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: choices.keys.map((feeling) {
                        return Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Draggable<String>(
                              data: feeling,
                              child: Image.asset(
                                choices[feeling]!,
                                height: 70,
                                width: 70,
                              ),
                              feedback: Image.asset(
                                choices[feeling]!,
                                height: 70,
                                width: 70,
                              ),
                              childWhenDragging: Container(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: choices.keys.map((feeling) {
                        return DragTarget<String>(
                          builder: (BuildContext context,
                              List<String?> incoming, List<dynamic> rejected) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: score[feeling] == true
                                    ? Color.fromARGB(255, 82, 146, 5)
                                    : Color.fromARGB(255, 176, 15, 87),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              height: 100,
                              width: double.infinity,
                              child: Center(
                                child: score[feeling] == true
                                    ? Text(
                                        'ትክክል',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    : Text(
                                        feeling,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                            );
                          },
                          onWillAccept: (data) => data == feeling && !gameOver,
                          onAccept: (data) {
                            setState(() {
                              score[feeling] = true;
                              _player.play(AssetSource('success.mp3'));
                              if (score.length == choices.length) {
                                gameOver = true;
                                _showResultDialog(true);
                              }
                            });
                          },
                          onLeave: (data) {},
                        );
                      }).toList()
                        ..shuffle(Random(seed)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog(bool win) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(win ? 'እንኳን ደስ አላችሁ!' : 'አበቃለት'),
          content: Text(win ? 'አሸንፈሃል!' : 'ተሸንፈሃል!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('እሺ'),
            ),
          ],
        );
      },
    );
  }
}
