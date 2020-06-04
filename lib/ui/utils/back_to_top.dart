import 'package:flutter/material.dart';

backToTop(ScrollController scrollController) async{
  if ( scrollController.positions.isNotEmpty){
    await scrollController.animateTo(
        0,
        curve: Curves.ease,
        duration: Duration(seconds: 2) );
  }
}