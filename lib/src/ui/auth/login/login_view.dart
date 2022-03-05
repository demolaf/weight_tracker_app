import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/widgets/reusable_size_boxes.dart';
import 'package:weight_tracker_app/src/core/utils/view_state.dart';
import 'package:weight_tracker_app/src/ui/auth/login/login_viewmodel.dart';

import '../../../widgets/reusable_button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Login to get started'),
            kVerticalSpaceRegular,
            ReusableButton(
              isLoading: ref.watch(loginViewModel).viewState.isLoading,
              onPressed: () async {
                await ref.read(loginViewModel.notifier).loginAnonWithFirebase();
              },
              child: const Text(
                'login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
