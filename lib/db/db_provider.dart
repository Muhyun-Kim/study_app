// ignore_for_file: unused_import

import 'package:riverpod/riverpod.dart';
import 'package:study_app/db/db.dart';
import 'package:study_app/models/study_model.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/db/db_provider.dart';

final studyDatabaseProvider = Provider((ref) => StudyDatabaseRepository(ref));

class StudyDatabaseRepository {
  StudyDatabaseRepository(this.ref);
  final Ref ref;

  static const _db = SqliteLocalDatabase.studyDatabse;

  Future<void> insert(StudyModel studyModel) async {
    await _db.insert(studyModel);
    ref.invalidate(studyDatabaseProvider);
  }

  Future<List<StudyModel>> getAll() async {
    return await _db.getAll();
  }

  Future<StudyModel> getOne(int id) async {
    return await _db.getOne(id);
  }

  Future<int> delete(int id) async {
    return await _db.delete(id);
  }
}
