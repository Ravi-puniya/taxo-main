import 'package:flutter/material.dart';

class CustomPanelModel {
  CustomPanelModel({
    required this.index,
    required this.title,
    this.subtitle,
    required this.child,
    this.icon,
  });

  int index;
  String title;
  Widget? subtitle;
  IconData? icon;
  Widget child;
}
