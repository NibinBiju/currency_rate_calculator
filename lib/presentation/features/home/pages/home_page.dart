import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fromCurrency = 'Australian Dollar';
  String toCurrency = 'Euro';
  double fromAmount = 100.00;
  double toAmount = 62.67;

  List<String> currencies = ['Australian Dollar', 'Euro', 'USD', 'GBP'];

  void swapCurrencies() {
    setState(() {
      final tempCurrency = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = tempCurrency;

      final tempAmount = fromAmount;
      fromAmount = toAmount;
      toAmount = tempAmount;
    });
  }

  Widget buildCurrencyCard({
    required String currencyLabel,
    required String currencyCode,
    required double amount,
    required ValueChanged<String> onCurrencyChanged,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currencyCode,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: colors.surface,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButton<String>(
            value: currencyLabel,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: colors.surface,
            items: currencies
                .map(
                  (currency) => DropdownMenuItem(
                    value: currency,
                    child: Text(
                      currency,
                      style: TextStyle(color: colors.surface),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onCurrencyChanged(value);
            },
          ),
          const SizedBox(height: 8),
          Text(
            amount.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colors.surface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Converter Card
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildCurrencyCard(
                      currencyLabel: fromCurrency,
                      currencyCode: "\$",
                      amount: fromAmount,
                      onCurrencyChanged: (value) {
                        setState(() => fromCurrency = value);
                      },
                    ),
                    const SizedBox(height: 22),
                    buildCurrencyCard(
                      currencyLabel: toCurrency,
                      currencyCode: "€",
                      amount: toAmount,
                      onCurrencyChanged: (value) {
                        setState(() => toCurrency = value);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: swapCurrencies,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colors.onSurface.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(Icons.sync, color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Chart Section
            _headTextWidget(width, text: 'Five day streak', colors: colors),
            Card(
              color: colors.surface,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final labels = ['1', '2', '3', '4', '5'];
                              if (value >= 0 && value < labels.length) {
                                return Text(labels[value.toInt()]);
                              } else {
                                return const Text('');
                              }
                            },
                            interval: 1,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 4,
                      minY: 0,
                      maxY: 80,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 50),
                            FlSpot(1, 60),
                            FlSpot(2, 45),
                            FlSpot(3, 70),
                            FlSpot(4, 62),
                          ],
                          isCurved: true,
                          color: colors.primary,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Recent Conversions
            _headTextWidget(width, text: 'Recent conversions', colors: colors),

            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    '1, 1 USD to 87 INR',
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _headTextWidget(
    double width, {
    required String text,
    required ColorScheme colors,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colors.onSurface,
            ),
          ),
          Container(width: width * 0.4, height: 3, color: colors.primary),
        ],
      ),
    );
  }
}
