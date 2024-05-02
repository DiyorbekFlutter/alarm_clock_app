import 'package:alarm_clock_app/model.dart';
import 'package:alarm_clock_app/setup.dart';
import 'package:alarm_clock_app/sorage_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'alarm.dart';

class Details extends StatefulWidget {
  final Model? model;
  final int? index;
  const Details({this.model, this.index, super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final FixedExtentScrollController hour = FixedExtentScrollController(initialItem: 7);
  final FixedExtentScrollController minute = FixedExtentScrollController(initialItem: 29);
  final Model model = Model(dateTame: '', days: [], enabled: false);
  List<String> days = [];
  bool canVibrate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            color: Colors.grey.withOpacity(0.2),
          ),
          Container(
            height: 350,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (_) {
                      if(canVibrate){
                        Vibration.vibrate(duration: 100);
                      }
                    },
                    controller: hour,
                    itemExtent: 100,
                    diameterRatio: 100,
                    overAndUnderCenterOpacity: 0.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 24,
                      builder: (context, index) => Text(
                          '${index != 23 ? index+1 : '00'}'.padLeft(2, '0'),
                          style: const TextStyle(fontSize: 50)
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                    offset: const Offset(0, -15),
                    child: const Text(":", style: TextStyle(fontSize: 40))
                ),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (_) {
                      if(canVibrate){
                        Vibration.vibrate(duration: 100);
                      }
                    },
                    controller: minute,
                    itemExtent: 100,
                    diameterRatio: 100,
                    overAndUnderCenterOpacity: 0.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) => Text(
                          '${index != 59 ? index+1 : '00'}'.padLeft(2, '0'),
                          style: const TextStyle(fontSize: 50)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 40,
                color: Colors.grey.withOpacity(0.2),
              ),
              Container(
                height: 40,
                decoration: const BoxDecoration(
                    color: Color(0xfff6f6f8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){
                  if(days.contains('D')){
                    days.remove('D');
                  } else {
                    days.add('D');
                  }
                  setState((){});
                },
                icon: Text('D',
                  style: TextStyle(
                    color: days.contains('D') ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('S')){
                    days.remove('S');
                  } else {
                    days.add('S');
                  }
                  setState((){});
                },
                icon: Text('S',
                    style: TextStyle(
                        color: days.contains('S') ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('C')){
                    days.remove('C');
                  } else {
                    days.add('C');
                  }
                  setState((){});
                },
                icon: Text('C',
                    style: TextStyle(
                        color: days.contains('C') ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('P')){
                    days.remove('P');
                  } else {
                    days.add('P');
                  }
                  setState((){});
                },
                icon: Text('P',
                    style: TextStyle(
                        color: days.contains('P') ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('J')){
                    days.remove('J');
                  } else {
                    days.add('J');
                  }
                  setState((){});
                },
                icon: Text('J',
                    style: TextStyle(
                        color: days.contains('J') ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('Sh')){
                    days.remove('Sh');
                  } else {
                    days.add('Sh');
                  }
                  setState((){});
                },
                icon: Text('S',
                    style: TextStyle(
                        color: days.contains('Sh') ? Colors.blue : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              ),
              IconButton(
                onPressed: (){
                  if(days.contains('Y')){
                    days.remove('Y');
                  } else {
                    days.add('Y');
                  }
                  setState((){});
                },
                icon: Text('Y',
                    style: TextStyle(
                        color: days.contains('Y') ? Colors.blue : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                TextButton(
                  onPressed: (){
                    if(days.contains('D')){
                      days.remove('D');
                    } else {
                      days.add('D');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('D')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('monday',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('S')){
                      days.remove('S');
                    } else {
                      days.add('S');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('S')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('tuesday',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('C')){
                      days.remove('C');
                    } else {
                      days.add('C');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('C')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('wednesday',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('P')){
                      days.remove('P');
                    } else {
                      days.add('P');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('P')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('thursday',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('J')){
                      days.remove('J');
                    } else {
                      days.add('J');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('J')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('friday',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('Sh')){
                      days.remove('Sh');
                    } else {
                      days.add('Sh');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('Sh')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('saturday',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if(days.contains('Y')){
                      days.remove('Y');
                    } else {
                      days.add('Y');
                    }
                    setState((){});
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      days.contains('Y')
                          ? const Icon(Icons.check_circle_sharp, color: Colors.blue)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                      const SizedBox(width: 20),
                      const Text('sunday',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20
                        )
                      ).tr(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                  "cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16
                  )
              ).tr(),
            ),
            TextButton(
              onPressed: (){
                model.dateTame =
                    '${(hour.selectedItem != 23 ? hour.selectedItem+1 : 0).toString().padLeft(2, '0')} : '
                    '${(minute.selectedItem != 59 ? minute.selectedItem+1 : 0).toString().padLeft(2, '0')}';
                model.days = days;
                model.enabled = true;

                if(widget.model == null){
                  models.add(model.toJson);
                } else if(widget.index != null){
                  models[widget.index!]['dateTame'] = model.dateTame;
                  models[widget.index!]['days'] = model.days;
                  models[widget.index!]['enabled'] = model.enabled;
                }

                StorageService.storage;
                setupModels();
                alarm(context, Duration(minutes: calculateTimeDifferenceInMinutes(model.dateTame, getCurrentTime())));
                Navigator.pop(context);
              },
              child: const Text(
                "storage",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16
                )
              ).tr(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.model != null) initial();
  }

  @override
  void dispose() {
    super.dispose();
    hour.dispose();
    minute.dispose();
  }

  Future<void> initial() async {
    days = widget.model!.days;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () => setState(() => canVibrate = true));
    Future.delayed(const Duration(milliseconds: 200), (){
      hour.animateToItem(
        int.parse(widget.model!.dateTame.substring(0, 2))-1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut
      );

      minute.animateToItem(
        int.parse(widget.model!.dateTame.substring(5, 7))-1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut
      );
    });
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
