import 'package:flutter/material.dart';
import 'dart:core';

enum EntryType { Link, Text }

extension EntryTypeExtension on EntryType {
  String get stringType {
    switch (this) {
      case EntryType.Link:
        return 'link';
      case EntryType.Text:
        return 'text';
      default:
        return null;
    }
  }
}

const Color kOGLightgrayBG = Color(0xFFF2F2F2);
const Color kThemeColor = Colors.deepOrangeAccent;
const Color kUnselected = Color(0xFF7C7C7C);
