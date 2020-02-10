import 'package:flutter/material.dart';

/// Creating base state to manage the states
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ///build the widgets inside localization provider
  Widget buildChild(BuildContext context);

  /// tag to debug
  String tag;

  /// Constructor BaseState
  BaseState() {
    tag = runtimeType.toString();
    print('BaseState:Create new page: $tag');
  }

  @override
  void initState() {
//    Fimber.d('$tag: initState()');
    super.initState();
    print('$tag:initState - Add tokenBloc listener with base state');
  }

  @override
  Widget build(BuildContext context) {
    return buildChild(context);
  }
}
