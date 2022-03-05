import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker_app/src/widgets/reusable_size_boxes.dart';
import 'package:weight_tracker_app/src/model/weight.dart';
import 'package:weight_tracker_app/src/ui/home/add_weight_item/add_weight_item_view.dart';
import 'package:weight_tracker_app/src/ui/home/weight_tracker/weight_tracker_viewmodel.dart';
import 'package:weight_tracker_app/src/widgets/reusable_progress_indicator.dart';

class WeightTrackerView extends ConsumerWidget {
  const WeightTrackerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: kToolbarHeight + 24,
        title: Row(
          children: const [
            Expanded(
              child: Text(
                'Here\'s what you told us to keep track of',
                style: TextStyle(
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black),
            child: PopupMenuButton(
              iconSize: 32,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      await ref.read(weightTrackerViewModel.notifier).signOut();
                    },
                    child: const Text(
                      'Sign out',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpaceLarge,
            SizedBox(
              height: 500,
              child: Consumer(
                builder: (context, streamRef, child) {
                  final weightList = streamRef.watch(weightListStreamProvider);
                  return weightList.when(
                    data: (List<WeightDataModel> weightList) {
                      weightList.sort(
                        (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
                      );
                      return ListView.builder(
                          itemCount: weightList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(weightTrackerViewModel.notifier)
                                    .saveSelectedWeightItem(weightList[index]);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${weightList[index].weight.toString()} KG',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            DateFormat.yMMMMEEEEd()
                                                .add_jms()
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        weightList[index]
                                                            .dateAdded!)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  kVerticalSpaceRegular,
                                ],
                              ),
                            );
                          });
                    },
                    error: (_, __) {
                      return const Center(
                        child: Text('An Error Occurred'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: ReusableProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return const AddWeightItemView();
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
