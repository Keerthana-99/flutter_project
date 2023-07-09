import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static Widget hairLineWidget({Color borderColor = const Color(0x88A5A5A5)}) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      color: borderColor,
      height: 1,
    );
  }
}