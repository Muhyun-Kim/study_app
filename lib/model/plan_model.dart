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
}

// class ConvertedPlanModel extends PlanModel {
//   ConvertedPlanModel({
//     required super.title,
//     required super.totalStudyTime,
//   });

//   Duration convertedTotalStudyTime;

//   Duration convertDuration(int value) {
//     return Duration(seconds: value);
//   }
// }
