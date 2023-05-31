import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:study_app/model/plan_model.dart';
import 'package:study_app/objectbox.g.dart' as objectbox;
import 'package:study_app/widget/plan_list_widget.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  objectbox.Store? store;
  objectbox.Box<PlanModel>? studyPlanBox;
  List<PlanModel> studyPlans = [];

  Future<void> initialize() async {
    store = await objectbox.openStore();
    studyPlanBox = store?.box<PlanModel>();
    fetchStudyPlans();
  }

  void fetchStudyPlans() {
    studyPlans = studyPlanBox?.getAll() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final titleText = useState("");

    useEffect(() {
      initialize();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study App'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("勉強科目を入力してください"),
                  content: TextField(
                    onChanged: (value) {
                      titleText.value = value;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("キャンセル"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (titleText.value != "") {
                          final studyPlan = PlanModel(
                            title: titleText.value,
                            totalStudyTime: 0,
                          );
                          studyPlanBox?.put(studyPlan);
                          fetchStudyPlans();
                        }
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: studyPlans.length,
        itemBuilder: (context, index) {
          final studyPlan = studyPlans[index];
          return PlanListWidget(studyPlan: studyPlan);
        },
      ),
    );
  }
}

