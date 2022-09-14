// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_head.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String Player1 = "X";
  static const String Player2 = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = Player1;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""]; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HomeHead(),
            Text(
              "$currentPlayer turn",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            GameContainer(),
            const SizedBox(
              height: 30,
            ),
            RestartButton(),
          ],
        ),
      ),
    );
  }

  

  Widget GameContainer() {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      height: 450,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty) {
          return;
        }

        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          Winner();
          Draw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.grey
            : occupied[index] == Player1
                ? Colors.green
                : Colors.blue,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  RestartButton() {
    return ElevatedButton.icon(
        onPressed: () {
          setState(() {
            GameOverMessage("Game restarted");
            initializeGame();
          });
        },
        icon: const Icon(Icons.restart_alt),
        label: const Text("Restart Game"));
  }

  changeTurn() {
    if (currentPlayer == Player1) {
      currentPlayer = Player2;
    } else {
      currentPlayer = Player1;
    }
  }

  Winner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String Position0 = occupied[winningPos[0]];
      String Position1 = occupied[winningPos[1]];
      String Position2 = occupied[winningPos[2]];

      if (Position0.isNotEmpty) {
        if (Position0 == Position1 &&
            Position0 ==Position2) {
          GameOverMessage("Player $Position0 Won");
          gameEnd = true;
          return;
        }
      }
    }
  }

  Draw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        draw = false;
      }
    }

    if (draw) {
      GameOverMessage("Draw");
      gameEnd = true;
    }
  }

  GameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Game Over \n $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }
}
