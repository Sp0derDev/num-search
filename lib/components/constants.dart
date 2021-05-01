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
const Color kLightPurple = Color(0xFFF4EFFF);
const Color kLightBlue = Color(0xFFE9F4FF);
const Color kLightPink = Color(0xFFFFEEFB);
const Color kLightOrange = Color(0xFFFFF2E9);

const LinearGradient kWhitePurpleGradient = LinearGradient(
    colors: [Colors.white, kLightPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
const LinearGradient kWhiteBlueGradient = LinearGradient(
    colors: [Colors.white, kLightBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
const LinearGradient kWhitePinkGradient = LinearGradient(
    colors: [Colors.white, kLightPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
const LinearGradient kWhiteOrangeGradient = LinearGradient(
    colors: [Colors.white, kLightOrange],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
const LinearGradient kRedPurpleGradient = LinearGradient(
    colors: [Color(0xffc31432), Color(0xff240b36)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
const LinearGradient kXGradient = LinearGradient(
    colors: [Color(0xff733151), Color(0xff321F46), Color(0xff1B192A)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
