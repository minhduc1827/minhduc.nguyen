import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

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

  /// Get the corresponding Bloc instance from Provider
  /// This Bloc must be registered before in MyApp.build()
  T providerOfBloc<T extends PropertyChangeNotifier>({bool listen = false}) {
    PropertyChangeModel<T> model = PropertyChangeProvider.of<T>(
      context,
      listen: listen,
    );
    return model.value;
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
