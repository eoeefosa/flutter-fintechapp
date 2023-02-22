import 'package:fintech_dashboard/data/mock_data.dart';
import 'package:fintech_dashboard/responsive.dart';
import 'package:fintech_dashboard/styles/styles.dart';
import 'package:fintech_dashboard/widgets/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWithTitle extends StatelessWidget {
  final String title;
  final Color barColor;
  final double amount;

  const BarChartWithTitle({
    Key? key,
    required this.title,
    required this.amount,
    required this.barColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Styles.defaultBorderRadius,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(Styles.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 10),
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CurrencyText(
                      currency: "\$",
                      amount: amount,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'on this week',
                      style: TextStyle(
                        color: Styles.defaultGreyColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    CurrencyText(
                      currency: "\$",
                      amount: amount,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'on this week',
                      style: TextStyle(
                        color: Styles.defaultGreyColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 38,
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.grey,
                    getTooltipItem: (a, b, c, d) => null,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: getTitles,
                      reservedSize: Responsive.isMobile(context) ? 45 : 0,
                      showTitles: true,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: MockData.getBarChartitems(
                  barColor,
                  width: Responsive.isMobile(context) ? 10 : 25,
                ),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: Styles.defaultLightGreyColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Mon';
      break;
    case 1:
      text = 'Tue';
      break;
    case 2:
      text = 'Wed';
      break;
    case 3:
      text = 'Thu';
      break;
    case 4:
      text = 'Fri';
      break;
    case 5:
      text = 'Sat';
      break;
    case 6:
      text = 'Sun';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}
