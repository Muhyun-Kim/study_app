import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_app/model/plan_model.dart';
import 'package:study_app/objectbox.g.dart' as objectbox;

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
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (_) {
              widget.studyPlanBox?.remove(widget.studyPlan.id);
              widget.fetchStudyPlans();
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
              '${widget.studyPlan.totalStudyTime}',
              style: GoogleFonts.sawarabiGothic(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
