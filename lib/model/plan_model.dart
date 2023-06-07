//Author : muhyun-kim
//Modified : 2023/06/04
//Function : プランののモデルを定義

import 'package:objectbox/objectbox.dart';

@Entity()
class PlanModel {
  @Id()
  int id;
  String title;
  int totalStudyTime;

  PlanModel({
    this.id = 0,
    required this.title,
    required this.totalStudyTime,
  });

  Duration createDurationFromInt(int totalStudyTime) {
    final hours = totalStudyTime ~/ 3600;
    final minutes = (totalStudyTime % 3600) ~/ 60;
    final seconds = totalStudyTime % 60;
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }
}
