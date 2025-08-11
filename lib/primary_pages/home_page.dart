import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> motivationalQuotes = [
    "Consistency beats motivation.",
    "Start small. Stay steady. Grow strong.",
    "Your future depends on what you do today.",
    "Don’t break the streak!",
    "You are your only limit.",
  ];

  late String quoteOfTheDay;

  @override
  void initState() {
    super.initState();
    quoteOfTheDay = motivationalQuotes[Random().nextInt(motivationalQuotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Daily Progress',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Your Why?
            const Text("Your Why?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
              ),
              child: const Text(
                "To become 1% better every day.",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),

            // Motivational Quote
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  quoteOfTheDay,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Streak Points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("🔥 Your Streak", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("12 Days", style: TextStyle(fontSize: 16, color: Colors.deepOrange)),
                )
              ],
            ),

            const SizedBox(height: 24),

            // Preview Widgets
            const Text("Quick View", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeCardPreview(title: "Goals", icon: Icons.flag, color: Colors.indigo),
                HomeCardPreview(title: "Exercise", icon: Icons.fitness_center, color: Colors.teal),
                HomeCardPreview(title: "Money Tracker", icon: Icons.attach_money, color: Colors.amber),
                HomeCardPreview(title: "To-Do", icon: Icons.check_box, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCardPreview extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const HomeCardPreview({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color)),
        ],
      ),
    );
  }
}
