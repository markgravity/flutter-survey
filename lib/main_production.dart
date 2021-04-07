import 'package:flutter/material.dart';
import 'package:survey/app.dart';
import 'package:survey/core/environment.dart';

void main() {
  Environment.production.set();
  runApp(App());
}
