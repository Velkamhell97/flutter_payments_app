import 'package:flutter/material.dart';

class DialogModel {
  final Icon icon;
  final String title;
  final String body;
  final String mainButton;
  final String? secondaryButton;

  const DialogModel({
    required this.icon, 
    required this.title, 
    required this.body, 
    required this.mainButton, 
    this.secondaryButton
  });
}