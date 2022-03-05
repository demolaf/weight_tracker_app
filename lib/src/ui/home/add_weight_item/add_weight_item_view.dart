import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker_app/src/widgets/reusable_size_boxes.dart';
import 'package:weight_tracker_app/src/core/constants/validation_extension.dart';
import 'package:weight_tracker_app/src/core/utils/view_state.dart';
import 'package:weight_tracker_app/src/ui/auth/login/login_view.dart';
import 'package:weight_tracker_app/src/ui/home/add_weight_item/add_weight_item_viewmodel.dart';

import '../../../widgets/reusable_button.dart';

class AddWeightItemView extends HookConsumerWidget {
  const AddWeightItemView({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightTextEditingController = useTextEditingController();
    final weightTextFieldFocusNode = useFocusNode();
    weightTextFieldFocusNode.requestFocus();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Weight To List'),
            kVerticalSpaceRegular,
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: weightTextEditingController,
                      focusNode: weightTextFieldFocusNode,
                      keyboardType: TextInputType.number,
                      validator: context.validateTextField,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '72',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          borderSide: BorderSide(
                            width: 1.5,
                          ),
                        ),
                        suffixText: 'KG',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kVerticalSpaceRegular,
            Align(
              alignment: Alignment.centerRight,
              child: ReusableButton(
                isLoading:
                    ref.watch(addWeightItemViewModel).viewState.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(addWeightItemViewModel.notifier)
                        .addNewWeightToFirestore(
                            weight: double.tryParse(
                                weightTextEditingController.text)!);
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
