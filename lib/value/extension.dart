import 'package:flutter/material.dart';

extension IntToSizedBox on int{
  Widget box(){
    return SizedBox(height: 6,);
  }
}