import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InternChartCard extends StatelessWidget {
  final List<String> labels = ['Jan', 'Feb', 'Mar', 'Apr', 'Mai', 'Jun'];

  InternChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final aspectRatio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: constraints.maxWidth > 1120 ?
                    (constraints.maxWidth * aspectRatio) / 2 - 30 >= 328
                ? (constraints.maxWidth * aspectRatio) / 2 - 30
                : 328: 328,
            minHeight: 328,


          ),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ]
          )
        ,
          child: AspectRatio(
            aspectRatio: 641 / 328,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.cyan.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, top: 0, right: 24, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Numbers of interns',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        DropdownButton<String>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          value: 'This Week',
                          underline: SizedBox(),
                          items: ['This Week', 'Last Week', 'This Month']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                    // Intern count
                    Text('158 intern',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xff42f7ff),
                            fontFamily: "poppins")),
                    SizedBox(height: 30),
                    // Line chart
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  int index = value.toInt();
                                  return index >= 0 && index < labels.length
                                      ? Center(
                                          child: Text(labels[index],
                                              style: TextStyle(fontSize: 10)),
                                        )
                                      : SizedBox.shrink();
                                },
                                interval: 1,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              axisNameSize: 16,
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 10,
                                  reservedSize: 25),
                            ),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(
                            drawHorizontalLine: true,
                            show: true,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (double a) {
                              return FlLine(
                                color: Colors.black.withOpacity(0.1),
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (double a) {
                              return FlLine(
                                color: Colors.black.withOpacity(0.1),
                                strokeWidth: 1,
                              );
                            },
                            verticalInterval: 1,
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            _lineBar([10, 20, 30, 40, 50, 40], Colors.blue),
                            _lineBar([20, 25, 30, 35, 30, 28], Colors.purple),
                            _lineBar([15, 22, 28, 26, 24, 22], Colors.pink),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _legendItem(Colors.blue, 'Content'),
                        _legendItem(Colors.purple, 'Content'),
                        _legendItem(Colors.pink, 'Content'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  LineChartBarData _lineBar(List<double> data, Color color) {
    return LineChartBarData(
      barWidth: 1,
      isCurved: true,
      color: color.withOpacity(0.5),
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: data
          .asMap()
          .entries
          .map((e) => FlSpot(e.key.toDouble(), e.value))
          .toList(),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
        SizedBox(width: 16),
      ],
    );
  }
}
