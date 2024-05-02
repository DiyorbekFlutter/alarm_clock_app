import 'dart:convert';

import 'package:alarm_clock_app/model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@immutable
sealed class StorageService {
  static final Box _box = Hive.box('data');
  static get storage => _box.put('data', jsonEncode(models));
  static String get get => _box.get('data') ?? '[]';
}
