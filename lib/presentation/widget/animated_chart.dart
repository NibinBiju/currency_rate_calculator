import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AnimatedLineChart extends StatefulWidget {
  const AnimatedLineChart({super.key});

  @override
  AnimatedLineChartState createState() => AnimatedLineChartState();
}

class AnimatedLineChartState extends State<AnimatedLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _lineAnimation;

  final List<DateTime> dates = List.generate(
    5,
    (index) => DateTime.now().subtract(Duration(days: 4 - index)),
  );

  final List<double> values = [10, 13, 9, 15, 12];

  int? touchedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _lineAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get minValue => values.reduce((a, b) => a < b ? a : b);

  double get maxValue => values.reduce((a, b) => a > b ? a : b);

  double get avgValue =>
      values.reduce((a, b) => a + b) / values.length.toDouble();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _lineAnimation,
          builder: (context, child) {
            final animationValue = _lineAnimation.value;
            return Opacity(
              opacity: animationValue,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - animationValue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatChip('Min', minValue),
                    _buildStatChip('Avg', avgValue),
                    _buildStatChip('Max', maxValue),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 250,
          child: AnimatedBuilder(
            animation: _lineAnimation,
            builder: (context, child) {
              return LineChart(
                LineChartData(
                  minY: minValue - 5,
                  maxY: maxValue + 5,
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          String dateStr = DateFormat.yMMMd().format(
                            dates[spot.x.toInt()],
                          );
                          return LineTooltipItem(
                            '$dateStr\n${spot.y.toStringAsFixed(1)}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.lineBarSpots != null) {
                        setState(() {
                          touchedIndex = response.lineBarSpots!.first.x.toInt();
                        });
                      } else {
                        setState(() {
                          touchedIndex = null;
                        });
                      }
                    },
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        values.length,
                        (i) => FlSpot(i.toDouble(), values[i]),
                      ),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.onSurface,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          double opacity =
                              (index <=
                                  (_lineAnimation.value * (values.length - 1)))
                              ? 1.0
                              : 0.0;
                          return FlDotCirclePainter(
                            radius: 5,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: opacity),
                            strokeWidth: 0,
                            strokeColor: Colors.transparent,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  extraLinesData: ExtraLinesData(),
                  gridData: FlGridData(show: true, horizontalInterval: 5),
                  borderData: FlBorderData(show: true),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(String label, double value) {
    return Chip(
      label: Text('$label: ${value.toStringAsFixed(1)}'),
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: 0.2),
      shape: StadiumBorder(),
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
