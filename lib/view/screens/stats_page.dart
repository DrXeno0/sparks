import 'package:flutter/material.dart';
import 'package:sparks/view/components/intern_chart_widget.dart';
import 'package:sparks/view/components/Intern_pie_chart.dart';
import 'package:sparks/view/components/my_custom_button.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          children: [
            // Filter + Add Supervisor Section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: 'Add Custom Stats',
                  iconAsset: 'assets/icons/icon=add.svg',
                  width: 240,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Scrollable area that takes the remaining space
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      // Ensure that the content fills at least the available height.
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Wrap(

                        alignment: WrapAlignment.spaceBetween,
                        spacing: 16, // Optional: horizontal spacing between items
                        runSpacing: 16, // Optional: vertical spacing between rows
                        children: [
                          InternChartCard(),
                          InternPieChartCard(),
                          InternChartCard(),
                          InternChartCard(),
                          InternChartCard(),
                          // Add more cards here as needed.
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}

