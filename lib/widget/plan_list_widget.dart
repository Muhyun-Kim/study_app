//Author : muhyun-kim
//Modified : 2023/06/04
//Function : プランのリスト表示ウィジェット

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_app/model/plan_model.dart';
import 'package:study_app/objectbox.g.dart' as objectbox;
import 'package:study_app/screen/timer_screen.dart';

class PlanListWidget extends StatefulWidget {
  const PlanListWidget({
    super.key,
    required this.studyPlanBox,
    required this.studyPlans,
    required this.studyPlan,
    required this.fetchStudyPlans,
  });

  final objectbox.Box<PlanModel>? studyPlanBox;
  final PlanModel studyPlan;
  final List<PlanModel> studyPlans;
  final Function fetchStudyPlans;

  @override
  State<PlanListWidget> createState() => _PlanListWidgetState();
}

class _PlanListWidgetState extends State<PlanListWidget> {
  @override
  Widget build(BuildContext context) {
    final durationTotalStudyTime =
        widget.studyPlan.createDurationFromInt(widget.studyPlan.totalStudyTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TimerScreen(
              studyPlanBox: widget.studyPlanBox,
              fetchStudyPlans: widget.fetchStudyPlans,
              studyPlan: widget.studyPlan,
              durationTotalStudyTime: durationTotalStudyTime,
            ),
          ),
        );
      },
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              widget.studyPlanBox?.remove(widget.studyPlan.id);
            },
          ),
          children: [
            SlidableAction(
              onPressed: (_) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("本当に削除しますか？"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.studyPlanBox?.remove(widget.studyPlan.id);
                            widget.fetchStudyPlans();
                            Navigator.pop(context);
                          },
                          child: const Text("はい"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("いいえ"),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.studyPlan.title,
                  style: GoogleFonts.sawarabiGothic(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                durationTotalStudyTime.toString().split('.').first,
                style: GoogleFonts.sawarabiGothic(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
