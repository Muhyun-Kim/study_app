import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/db/db_provider.dart';
import 'package:study_app/models/study_model.dart';

class UpdateListScreen extends ConsumerStatefulWidget {
  const UpdateListScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  ConsumerState<UpdateListScreen> createState() => _UpdateListScreenState();
}

class _UpdateListScreenState extends ConsumerState<UpdateListScreen> {
  int get id => widget.id;
  final TextEditingController _controller = TextEditingController();

  String titleText = "";

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(studyDatabaseProvider);

    return AlertDialog(
      title: const Text('変更するタイトル名を入力'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '科目名',
        ),
        onChanged: (text) => titleText = text,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('変更'),
          onPressed: () async {
            print(titleText);
            provider.update(StudyModel(id: id, title: titleText));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
