import 'package:flutter/material.dart';

class CurrencyCardWidget extends StatefulWidget {
  const CurrencyCardWidget({
    super.key,
    required this.context,
    required this.currencies,
    required this.currencyLabel,
    required this.currencyCode,
    required this.onCurrencyChanged,
    required this.amount,
    required this.onAmountChanged,
  });

  final BuildContext context;
  final List<String> currencies;

  final String currencyLabel;
  final String currencyCode;
  final double amount;

  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onAmountChanged;

  @override
  State<CurrencyCardWidget> createState() => _CurrencyCardWidgetState();
}

class _CurrencyCardWidgetState extends State<CurrencyCardWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  double amountDemo = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
    amountDemo = widget.amount;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startEditing() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: Duration(milliseconds: 700),
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
            widget.currencyCode,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: colors.surface,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButton<String>(
            value: widget.currencyLabel,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: colors.onSurface,
            items: widget.currencies
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
              if (value != null) widget.onCurrencyChanged(value);
            },
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _startEditing,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Text(
                  widget.amount.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colors.surface,
                  ),
                  textAlign: TextAlign.left,
                ),

                Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        setState(() {});
                      }
                      widget.onAmountChanged(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
