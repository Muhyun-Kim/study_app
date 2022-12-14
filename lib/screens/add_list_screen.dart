import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/db/db_provider.dart';
import 'package:study_app/models/study_model.dart';

class AddListScreen extends ConsumerStatefulWidget {
  const AddListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends ConsumerState<AddListScreen> {
  final TextEditingController _controller = TextEditingController();
  String titleText = "";

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(studyDatabaseProvider);

    return AlertDialog(
      title: const Text('勉強科目を入力'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '科目名',
        ),
        onChanged: (String value) => titleText = value,
        onSubmitted: (String value) => titleText = value,
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
          child: const Text('決定'),
          onPressed: () async {
            provider.insert(StudyModel(title: titleText));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
