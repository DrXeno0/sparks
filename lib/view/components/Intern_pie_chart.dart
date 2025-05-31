import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class InternPieChartCard extends StatelessWidget {
  final Map<String, double> genderDataMap = {
    "Males": 34,
    "Females": 66,
  };

  final List<Color> colorList = [
    const Color(0xFF7B7BFF), // blueish
    const Color(0xFFFF7BAC), // pinkish
  ];

  InternPieChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints){
        return  Container(
        padding: const EdgeInsets.all(20).copyWith(top: 0),
        constraints: BoxConstraints(

          maxHeight: constraints.maxWidth > 1120 ?
          (constraints.maxWidth * aspectRatio) / 2 - 30 >= 328
              ? (constraints.maxWidth * aspectRatio) / 2 - 30
              : 328: 328,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.cyan.withAlpha(50),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Title and dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Interns By Gender",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'MARWAN',
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'MARWAN',
                        child: Text('MARWAN'),
                      ),
                    ],
                    onChanged: (_) {},
                  )
                ],
              ),
              const SizedBox(height: 0),
              const Text(
                "23 intern",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.cyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              // Chart and legend
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PieChart(
                        dataMap: genderDataMap,
                        animationDuration: const Duration(milliseconds: 800),
                        chartRadius: 150,
                        colorList: colorList,
                        chartType: ChartType.values.firstWhere((element) => element.toString() == "ChartType.ring"),
                        ringStrokeWidth: 35,
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValueBackground: false,
                          decimalPlaces: 0,
                        ),
                        legendOptions: const LegendOptions(
                          showLegends: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Custom legend
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(colorList[0], "Males"),
                          const SizedBox(height: 8),
                          _buildLegendItem(colorList[1], "Females"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );}
      );
  }

  Widget _buildLegendItem(Color color, String title) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
