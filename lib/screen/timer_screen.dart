//Author : muhyun-kim
//Modified : 2023/06/04
//Function : タイマーを操作する画面

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:study_app/model/plan_model.dart';
import 'package:study_app/objectbox.g.dart' as objectbox;
import 'package:study_app/widget/timer_button_widget.dart';

class TimerScreen extends HookWidget {
  TimerScreen({
    super.key,
    required this.studyPlanBox,
    required this.fetchStudyPlans,
    required this.studyPlan,
    required this.durationTotalStudyTime,
  });

  final objectbox.Box<PlanModel>? studyPlanBox;
  final Function fetchStudyPlans;
  final PlanModel studyPlan;
  final Duration durationTotalStudyTime;

  Timer? timer;
  final addTime = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final studyTime = useState(durationTotalStudyTime);
    final isTimerRunning = useState(false);

    void timerUp() {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          studyTime.value += addTime;
        },
      );
      isTimerRunning.value = true;
    }

    void stopTimer() {
      timer?.cancel();
      isTimerRunning.value = false;
      studyPlanBox?.put(
        PlanModel(
          id: studyPlan.id,
          title: studyPlan.title,
          totalStudyTime: studyTime.value.inSeconds,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(studyPlan.title),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              fetchStudyPlans();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          )),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.orange,
                        width: 10,
                      )),
                  child: Center(
                    child: Text(
                      studyTime.value.toString().split('.').first,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Center(
                child: isTimerRunning.value == false
                    ? TimerButtonWidget(
                        onPressed: timerUp,
                        buttonText: "start",
                        buttonColor: Colors.grey,
                        buttonTextColor: Colors.black,
                      )
                    : TimerButtonWidget(
                        onPressed: stopTimer,
                        buttonText: "stop",
                        buttonColor: const Color.fromARGB(255, 255, 150, 150),
                        buttonTextColor: Colors.black,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
