import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../common/util/exports.dart';

class LineChartSample8 extends StatelessWidget {
  LineChartSample8({
    Key? key,
    Color? line1Color,
    Color? line2Color,
    Color? betweenColor,
  })  : line1Color = line1Color ?? Colors.transparent,
        line2Color = line2Color ?? AppColors.appTheme,
        betweenColor = betweenColor ?? Colors.transparent,
        super(key: key);

  final Color line1Color;
  final Color line2Color;
  final Color betweenColor;
  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'S';
              break;
            case 2:
              text = 'M';
              break;
            case 3:
              text = 'T';
              break;
            case 4:
              text = 'W';
              break;
            case 5:
              text = 'T';
              break;
            case 6:
              text = 'F';
              break;
            case 7:
              text = 'S';
              break;
            // case 8:
            //   text = 'Aug';
            //   break;
            // case 9:
            //   text = 'Sep';
            //   break;
            // case 10:
            //   text = 'Oct';
            //   break;
            // case 11:
            //   text = 'Nov';
            //   break;
            // case 12:
            //   text = 'Dec';
            //   break;
            // default:
            //   return const SizedBox();
          }

          return Text(text);
        },
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toString(),
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(1, 5),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                ],
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: const [
                  // FlSpot(0, 7),
                  FlSpot(1.7, 4),
                  // FlSpot(1.4, 2),
                  FlSpot(1.7, 4),
                  FlSpot(3.5, 2),
                  // FlSpot(4, 3),
                  // FlSpot(5, 4),
                  // FlSpot(6, 5),
                  // FlSpot(7, 3),
                  // FlSpot(8, 1),
                  FlSpot(6, 3.2),
                  FlSpot(7.5, 5),
                  FlSpot(10, 6),
                ],
                isCurved: false,
                barWidth: 2,
                color: line2Color,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            // betweenBarsData: [
            //   BetweenBarsData(
            //     fromIndex: 0,
            //     toIndex: 1,
            //     color: betweenColor,
            //   )
            // ],
            // minY: 0,
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: bottomTitles),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  interval: 1,
                  reservedSize: 36,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              // checkToShowHorizontalLine: (double value) {
              //   return value == 1 || value == 6 || value == 4 || value == 5;
              // },
            ),
          ),
        ),
      ),
    );
  }
}
