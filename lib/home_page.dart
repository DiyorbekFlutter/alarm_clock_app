import 'package:alarm_clock_app/alarm.dart';
import 'package:alarm_clock_app/delete_dialog.dart';
import 'package:alarm_clock_app/details.dart';
import 'package:alarm_clock_app/model.dart';
import 'package:alarm_clock_app/setup.dart';
import 'package:alarm_clock_app/sorage_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'choose_language.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 350,
            title: const Text("Alarm clock", style: TextStyle(fontSize: 25)),
            flexibleSpace: Container(
              color: const Color(0xfff6f6f8),
              alignment: const Alignment(0, 0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => const Details())
                      ).then((value) => setState((){}));
                    },
                    icon: const Icon(Icons.add),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => chooseLanguage(context),
                        child: const Text("change_language").tr(),
                      )
                    ],
                  ),
                  const SizedBox(width: 20)
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: models.length,
              (context, index) {
                Model model = Model.fromJson(models[index]);
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Details(model: model, index: index))
                    ).then((value) => setState((){}));
                  },
                  onLongPress: () async => await deleteDialog(context, index).then((value) => setState((){})),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(model.dateTame, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            model.days.length == 7 ? const Text("every_day", style: TextStyle(color: Colors.blue, fontSize: 16)).tr() : RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: "D",
                                    style: TextStyle(color: !model.days.contains("D") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " S",
                                    style: TextStyle(color: !model.days.contains("S") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " C",
                                    style: TextStyle(color: !model.days.contains("C") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " P",
                                    style: TextStyle(color: !model.days.contains("P") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " J",
                                    style: TextStyle(color: !model.days.contains("J") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " S",
                                    style: TextStyle(color: !model.days.contains("Sh") ? Colors.grey : null)
                                  ),
                                  TextSpan(
                                    text: " Y",
                                    style: TextStyle(color: !model.days.contains("Y") ? Colors.grey : null)
                                  )
                                ]
                              ),
                            )
                          ],
                        ),
                        Switch(
                          value: model.enabled,
                          onChanged: (_){
                            models[index]['enabled'] = !models[index]['enabled'];
                            StorageService.storage;
                            setupModels();
                            if(models[index]['enabled']) alarm(context, Duration(minutes: calculateTimeDifferenceInMinutes(models[index]['dateTame'], getCurrentTime())));
                            setState((){});
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


int calculateTimeDifferenceInMinutes(String time1, String time2) {
  List<String> parts1 = time1.split(':');
  List<String> parts2 = time2.split(':');

  int hour1 = int.parse(parts1[0]);
  int hour2 = int.parse(parts2[0]);
  int minute1 = int.parse(parts1[1]);
  int minute2 = int.parse(parts2[1]);

  int timeInMinutes1 = hour1 * 60 + minute1;
  int timeInMinutes2 = hour2 * 60 + minute2;

  int differenceInMinutes = timeInMinutes1 - timeInMinutes2;

  return differenceInMinutes;
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  int minute = now.minute;

  String hourNow = '$hour'.padLeft(2, '0');
  String minuteNow = '$minute'.padLeft(2, '0');

  String time = '$hourNow : $minuteNow';

  return time;
}