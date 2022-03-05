import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker_app/src/ui/auth/login/login_view.dart';
import 'package:weight_tracker_app/src/ui/home/edit_weight_item/edit_weight_item_view.dart';
import 'package:weight_tracker_app/src/ui/startup/startup_view.dart';

import '../ui/home/weight_tracker/weight_tracker_view.dart';

/// Routes
class Routes {
  static const startupView = '/startup_view';
  static const loginView = '/login_view';
  static const weightTrackerView = '/weight_tracker_view';
  static const editWeightItemView = '/edit_weight_item_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (!Platform.isIOS) {
      switch (settings.name) {
        case startupView:
          return MaterialPageRoute(
            builder: (_) => const StartupView(),
          );
        case loginView:
          return MaterialPageRoute(
            builder: (_) => const LoginView(),
          );
        case weightTrackerView:
          return MaterialPageRoute(
            builder: (_) => const WeightTrackerView(),
          );
        case editWeightItemView:
          return MaterialPageRoute(
            builder: (_) => const EditWeightItemView(),
          );
        default:
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
      }
    } else {
      switch (settings.name) {
        case startupView:
          return CupertinoPageRoute(
            builder: (_) => const StartupView(),
          );
        case loginView:
          return CupertinoPageRoute(
            builder: (_) => const LoginView(),
          );
        case weightTrackerView:
          return CupertinoPageRoute(
            builder: (_) => const WeightTrackerView(),
          );
        case editWeightItemView:
          return CupertinoPageRoute(
            builder: (_) => const EditWeightItemView(),
          );
        default:
          return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
      }
    }
  }
}
