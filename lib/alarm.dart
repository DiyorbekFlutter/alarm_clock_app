import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'data.dart';

Future<void> alarm(BuildContext context, Duration duration) async {
  Future.delayed(duration, () async {
    snackBar(context);
    await Data.player.play(AssetSource('audio/samsung_alarm.mp3'));
  });
}

Future<void> snackBar(BuildContext context) async {
  Vibration.vibrate(duration: 1000);
  Future.delayed(const Duration(seconds: 1));
  Vibration.vibrate(duration: 1000);
  // Future.delayed(const Duration(seconds: 1));
  // Vibration.vibrate(duration: 1000);
  // await Future.delayed(const Duration(seconds: 1));
  // await Vibration.vibrate(duration: 1000);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextButton(
        onPressed: (){
          Data.player.pause();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: const Text("O'chirish", style: TextStyle(color: Colors.white)),
      ),
      duration: const Duration(seconds: 14),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).size.height - 200
      ),
    )
  );
}
