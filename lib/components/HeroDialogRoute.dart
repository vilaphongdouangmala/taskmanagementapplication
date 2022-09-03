import 'dart:ffi';

import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => 'Popup dialog open';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }
}//ec
