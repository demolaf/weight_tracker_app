import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = Provider((ref) => Navigation());

/// Navigation
class Navigation {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<T?>? push<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState?.push(route);
  }

  Future<T?>? pushNamed<T extends Object?>(
    String route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(
      route,
      arguments: arguments,
    );
  }

  Future<T?>? pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> route, {
    TO? result,
  }) {
    return navigatorKey.currentState?.pushReplacement(
      route,
      result: result,
    );
  }

  Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(
    String route, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(
      route,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?>? pushAndRemoveUntil<T extends Object?>(
    Route<T> route,
    bool Function(Route<dynamic>) predicate,
  ) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      route,
      predicate,
    );
  }

  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String route,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      route,
      predicate,
      arguments: arguments,
    );
  }

  void popUntil<T extends Object?>(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
