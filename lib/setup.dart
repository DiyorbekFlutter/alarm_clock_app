import 'dart:convert';
import 'dart:io';

import 'package:alarm_clock_app/model.dart';
import 'package:alarm_clock_app/sorage_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setup()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('data');
  setupModels();
}

void setupModels(){
  models.clear();
  List modelsList = jsonDecode(StorageService.get);
  modelsList.map((map){
    models.add(<String, dynamic>{
      "dateTame": map['dateTame'],
      "days": map['days'],
      "enabled": map['enabled']
    });
  }).toList();
}
