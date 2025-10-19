import 'dart:convert';

import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:currency_rate_calculator/presentation/features/home/bloc/bloc/currency_convert_bloc.dart';
import 'package:currency_rate_calculator/presentation/widget/animated_chart.dart';
import 'package:currency_rate_calculator/presentation/widget/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fromCurrency = 'AUD';
  String toCurrency = 'EUR';
  double fromAmount = 0;
  double toAmount = 0;

  List<String> currencies = ['AUD', 'EUR', 'USD', 'GBP'];
  bool isSwapped = false;

  void swapCurrencies() {
    setState(() {
      isSwapped = !isSwapped;

      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final double cardHeight = 170;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Converter',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // converter Card
              Center(
                child: SizedBox(
                  height: 2 * cardHeight + 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //from amount
                      BlocConsumer<CurrencyConvertBloc, CurrencyConvertState>(
                        listener: (context, state) {
                          if (state is CurrencyConvertSuccess) {
                            final data = state.data;
                            final resultMap =
                                data['result'] as Map<String, dynamic>?;
                            if (resultMap != null) {
                              final rateValue = resultMap[toCurrency];
                              double rate = 0.0;

                              if (rateValue is double) {
                                rate = rateValue;
                              } else if (rateValue is int) {
                                rate = rateValue.toDouble();
                              } else if (rateValue is String) {
                                rate = double.tryParse(rateValue) ?? 0.0;
                              }

                              setState(() {
                                toAmount = fromAmount * rate;
                              });
                            }
                          }
                          if (state is CurrencyConvertFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            top: isSwapped ? cardHeight + 20 : 0,
                            left: 0,
                            right: 0,
                            child: CurrencyCardWidget(
                              context: context,
                              currencies: currencies,
                              currencyLabel: fromCurrency,
                              currencyCode: "\$",
                              onCurrencyChanged: (value) {
                                setState(() => fromCurrency = value);
                              },
                              amount: fromAmount,
                              onAmountChanged: (value) {
                                setState(() {
                                  fromAmount = double.parse(value);
                                });
                                context.read<CurrencyConvertBloc>().add(
                                  OnCurrencyConvertEvent(
                                    currencyConvertEntity:
                                        CurrencyConvertEntity(
                                          from: fromCurrency,
                                          to: toCurrency,
                                          amount: value.toString(),
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),

                      //to amount
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        top: isSwapped ? 0 : cardHeight + 20,
                        left: 0,
                        right: 0,
                        child: CurrencyCardWidget(
                          amount: toAmount,
                          context: context,
                          currencies: currencies,
                          currencyLabel: toCurrency,
                          currencyCode: "€",
                          onCurrencyChanged: (value) {
                            setState(() => toCurrency = value);
                          },
                          onAmountChanged: (value) {
                            // setState(() => fromCurrency = value);
                            // print(value);
                            // context.read<CurrencyConvertBloc>().add(
                            //   OnCurrencyConvertEvent(
                            //     currencyConvertEntity: CurrencyConvertEntity(
                            //       from: fromCurrency,
                            //       to: toCurrency,
                            //       amount: fromAmount.toString(),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      ),

                      Positioned(
                        top: cardHeight - 15,
                        right: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: swapCurrencies,
                              child: AnimatedRotation(
                                turns: isSwapped ? 1 : 0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.surface.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.swap_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // chart Section
              _headTextWidget(width, text: 'Five day streak', colors: colors),
              AnimatedLineChart(),

              _headTextWidget(
                width,
                text: 'Recent conversions',
                colors: colors,
              ),

              //cached data
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    '${index + 1}, 1 USD to 87 INR',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          Container(width: width * 0.4, height: 2, color: colors.primary),
        ],
      ),
    );
  }
}
