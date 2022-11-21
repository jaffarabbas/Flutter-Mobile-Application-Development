import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LineChartExample extends StatefulWidget {
  const LineChartExample({super.key});

  @override
  State<LineChartExample> createState() => _LineChartExampleState();
}

class _LineChartExampleState extends State<LineChartExample> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<Color> gradaintColor2 = [
    const Color(0xff6A3093),
    const Color(0xffA044FF),
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      // height: 320,
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.90,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: gradaintColor2, // red to yellow
                  tileMode:
                      TileMode.clamp, // repeats the gradient over the canvas
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 3,
                  left: 5,
                  top: 3,
                  bottom: 0,
                ),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xffffffff),
      fontSize: 8,
    );

    List<String> l = ['10', '', '20', '', '30', '', '40', '', '50', '', '60'];

    return SideTitleWidget(
      // space: ,
      axisSide: meta.axisSide,
      child: Container(
          // color: Colors.amber,
          // margin: EdgeInsets.only(left: 10),
          // padding: EdgeInsets.only(left: 60),
          child: Text(
        value.toInt() < 11 ? l[value.toInt()] : '',
        style: style,
      )),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xffffffff),
      // fontWeight: FontWeight.bold,
      fontSize: 7,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Alpha';
        break;
      case 3:
        text = 'Theta';
        break;
      case 5:
        text = 'Delta';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xffffffff),
      // fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Left Ear\n70.0 Hz';
        break;
      case 5:
        text = 'Result Ear\n70.0 Hz';
        break;
      case 9:
        text = 'Right Ear\n70.0 Hz';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }


  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2,
        verticalInterval: 3,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xffffffff),
            strokeWidth: 1,
          );
        },
        // getDrawingVerticalLine: (value) {
        //   return FlLine(
        //     color: const Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        // border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(-1, 8),
            FlSpot(2.6, 0),
            FlSpot(4.9, 5),
            FlSpot(6.8, 2.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 7),
          ],
          isCurved: true,
          color: Color(0xffFCFF54),
          barWidth: 1,
          shadow: Shadow(
              color: Color(0xffFCFF54), blurRadius: 10.5, offset: Offset.zero),
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          // belowBarData: BarAreaData(
          //   show: false,
          //   gradient: LinearGradient(
          //     colors: gradientColors
          //         .map((color) => color.withOpacity(0.3))
          //         .toList(),
          //   ),
          // ),
        ),
      ],
    );
  }
}
