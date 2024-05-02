import 'package:alarm_clock_app/model.dart';
import 'package:alarm_clock_app/setup.dart';
import 'package:alarm_clock_app/sorage_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> deleteDialog(BuildContext context, int index) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("do_you_want_to_delete",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ).tr(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: (){
                  models.removeAt(index);
                  StorageService.storage;
                  setupModels();
                  Navigator.pop(context);
                },
                child: const Text("deleted",
                    style: TextStyle(
                        color: Color(0xffCE4342),
                        fontWeight: FontWeight.bold
                    )
                ).tr(),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("cancel",
                  style: TextStyle(
                    color: Color(0xff5793C3),
                    fontWeight: FontWeight.bold
                  ),
                ).tr(),
              ),
            ],
          )
        ],
      ),
    ),
  );
}