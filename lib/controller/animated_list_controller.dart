import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

enum AnimationListState{
  idle,
  clearing,
  adding
}

class AnimatedListController{
  AnimatedListController({required  GlobalKey<AnimatedListState>  listKey}):
        _listKey = listKey;

  final GlobalKey<AnimatedListState> _listKey;

  AnimatedListState? get _animatedList => _listKey.currentState;

  Timer? _timer;
  int _increaseCount = 0;
  int _listCount = 0;

  AnimationListState lisState = AnimationListState.idle;

  int get _totalCount => _increaseCount + _listCount;


  void populateAnimatedList(int childCount) {
    if(lisState == AnimationListState.clearing) return;
    _increaseCount = childCount - _totalCount;
    if (lisState != AnimationListState.adding) {
      lisState = AnimationListState.adding;
      _timer = Timer.periodic(const Duration(milliseconds: 125), (timer) {
        if(lisState != AnimationListState.clearing){
          _animatedList!.insertItem(_listCount);
          _listCount++;
          _increaseCount--;
          if (_increaseCount < 1) {
            lisState = AnimationListState.idle;
            timer.cancel();
          }
        }
      });
    }
  }

  void clearAnimatedList()  {
    if( lisState == AnimationListState.clearing) return;
    lisState = AnimationListState.clearing;
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    while(_listCount > 0) {
      _animatedList!.removeItem(
        0,
            (BuildContext context, Animation<double> animation) {
          return const SizedBox.shrink();
        },
      );

      _listCount--;
    }
    _increaseCount = 0;
    lisState = AnimationListState.idle;
  }

}