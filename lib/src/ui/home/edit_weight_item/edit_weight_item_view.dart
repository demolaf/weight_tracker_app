import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker_app/src/widgets/reusable_size_boxes.dart';
import 'package:weight_tracker_app/src/core/constants/validation_extension.dart';
import 'package:weight_tracker_app/src/core/utils/view_state.dart';
import 'package:weight_tracker_app/src/ui/home/edit_weight_item/edit_weight_item_viewmodel.dart';
import 'package:weight_tracker_app/src/widgets/reusable_progress_indicator.dart';

import '../../../widgets/reusable_button.dart';

class EditWeightItemView extends HookConsumerWidget {
  const EditWeightItemView({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editWeightTextEditingController = useTextEditingController();
    final editWeightTextFieldFocusNode = useFocusNode();
    editWeightTextFieldFocusNode.requestFocus();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: kToolbarHeight + 24,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Edit',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(editWeightItemViewModel.notifier)
                  .deleteSelectedWeightItem();
            },
            icon: const Icon(
              Icons.delete,
            ),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Currently editing ${ref.watch(editWeightItemViewModel.notifier).selectedWeight?.weight} '
                      'KG, added on ${DateFormat.yMMMMEEEEd().add_jms().format(
                            DateTime.fromMillisecondsSinceEpoch(ref
                                .watch(editWeightItemViewModel.notifier)
                                .selectedWeight!
                                .dateAdded!),
                          )}',
                    ),
                    kVerticalSpaceRegular,
                    TextFormField(
                      controller: editWeightTextEditingController,
                      focusNode: editWeightTextFieldFocusNode,
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
                    kVerticalSpaceRegular,
                    Align(
                      alignment: Alignment.centerRight,
                      child: ReusableButton(
                        isLoading: ref
                            .watch(editWeightItemViewModel)
                            .viewState
                            .isLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(editWeightItemViewModel.notifier)
                                .updateSelectedWeightItem(
                                    weight: double.tryParse(
                                        editWeightTextEditingController.text)!);
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
