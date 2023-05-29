import 'package:objectbox/objectbox.dart';

@Entity()
class PlanModel {
  PlanModel({
    required this.title,
  });

  int id = 0;

  String title;
}
