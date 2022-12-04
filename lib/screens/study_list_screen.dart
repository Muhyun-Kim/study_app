import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/db/db_provider.dart';
import 'package:study_app/models/study_model.dart';

class StudyListScreen extends ConsumerWidget {
  const StudyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<StudyModel>> _getList() async {
      return await ref.watch(studyDatabaseProvider).getAll();
    }

    return FutureBuilder<List<StudyModel>>(
        future: _getList(), // a previously-obtained Future<String> or null
        builder: (context, dataSnopShot) {
          if (dataSnopShot.hasData) {
            return ListView.builder(
              itemCount: dataSnopShot.data!.length,
              itemBuilder: (context, index) {
                StudyModel studyModel = dataSnopShot.data![index];
                return ListTile(
                  title: Text(studyModel.title),
                  subtitle: Text(
                    studyModel.id.toString(),
                  ),
                );
              },
              padding: const EdgeInsets.all(9),
            );
          } else {
            return Container();
          }
        });
  }
}
