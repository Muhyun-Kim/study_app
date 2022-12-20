import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/db/db_provider.dart';
import 'package:study_app/models/study_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:study_app/screens/update_list_screen.dart';

class StudyListScreen extends ConsumerWidget {
  const StudyListScreen({super.key});

  @override
  //getAllを通じてdbが変わったらそれを伝える
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(studyDatabaseProvider);

    Future<List<StudyModel>> _getList() async {
      return await provider.getAll();
    }

    void deleteRow(int id) {
      provider.delete(id);
    }

    return FutureBuilder<List<StudyModel>>(
        future: _getList(),
        builder: (context, dataSnopShot) {
          if (dataSnopShot.hasData) {
            return ListView.builder(
              itemCount: dataSnopShot.data!.length,
              itemBuilder: (context, index) {
                StudyModel studyModel = dataSnopShot.data![index];
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (_) {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return UpdateListScreen(id: studyModel.id!);
                            },
                          );
                        },
                        backgroundColor: const Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.change_circle,
                        label: '変更',
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          deleteRow(studyModel.id!);
                        },
                        flex: 2,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(studyModel.title),
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
