import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class LongTermGoal {
  final String title;
  final String description;

  LongTermGoal({required this.title, required this.description});
}

class ShortTermGoal {
  final String task;
  final bool isDone;
  final String? category;

  ShortTermGoal({required this.task, this.isDone = false, this.category});
}

class _GoalsPageState extends State<GoalsPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<LongTermGoal> longTermGoals = [
    LongTermGoal(
      title: "Become a CEO",
      description: "Build and lead my own company.",
    ),
    LongTermGoal(
      title: "Travel the World",
      description: "Visit every continent.",
    ),
  ];

  List<ShortTermGoal> shortTermGoals = [
    ShortTermGoal(
      task: "Write business plan",
      isDone: true,
      category: "Become a CEO",
    ),
    ShortTermGoal(task: "Gym 3x this week", isDone: false),
    ShortTermGoal(
      task: "Study leadership",
      isDone: false,
      category: "Become a CEO",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Goals"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Optional: Page indicator (dots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPageDot(0),
              const SizedBox(width: 6),
              buildPageDot(1),
            ],
          ),

          const SizedBox(height: 10),

          // Swipable Pages
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => currentPage = index),
              children: [buildShortTermPage(), buildLongTermPage()],
            ),
          ),
        ],
      ),

      // FAB depends on page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentPage == 0) {
            // TODO: Add short-term goal
          } else {
            // TODO: Add long-term goal
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 180, 180, 187),
      ),
    );
  }

  Widget buildPageDot(int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Colors.deepPurple : Colors.grey[300],
      ),
    );
  }

  // ------------------ Short-Term Page ------------------
  Widget buildShortTermPage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 100),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF9F9F9),
                    Color(0xFFECECEC),
                  ], // soft neutral gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Short-Term Milestones",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...shortTermGoals.map(buildShortTermGoalCard).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildShortTermGoalCard(ShortTermGoal goal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF5F5F5),
            Color(0xFFE0E0E0),
          ], // soft neutral gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (goal.category != null)
            Text(
              "🌟 From: ${goal.category}",
              style: const TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
          Row(
            children: [
              Icon(
                goal.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                color: goal.isDone ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  goal.task,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: goal.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------ Long-Term Page ------------------
  Widget buildLongTermPage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 100),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF4F4F4), Color(0xFFDADADA)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Life Visions",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...longTermGoals.map(buildLongTermVisionCard).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLongTermVisionCard(LongTermGoal goal) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to breakdown steps page
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEDEDED), Color(0xFFD6D6D6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              goal.description,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            const Text(
              "View Steps",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
