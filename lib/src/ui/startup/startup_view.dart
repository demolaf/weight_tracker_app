import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/ui/home/weight_tracker/weight_tracker_view.dart';
import 'package:weight_tracker_app/src/ui/startup/startup_viewmodel.dart';

import '../auth/login/login_view.dart';

class StartupView extends ConsumerWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(startupViewModel.notifier).currentUser == null) {
      return const LoginView();
    } else {
      return const WeightTrackerView();
    }
  }
}
