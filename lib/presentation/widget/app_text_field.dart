import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPassVisible = false;

  @override
  void initState() {
    isPassVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: isPassVisible,
      enableSuggestions: !isPassVisible,
      autocorrect: !isPassVisible,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          gapPadding: 12,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          gapPadding: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          gapPadding: 12,
        ),
        errorStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        hintText: widget.hintText,
        prefixStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,

        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
        suffixIcon: widget.isPassword
            ? isPassVisible
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isPassVisible = false;
                        });
                      },
                      child: Icon(Icons.visibility_off_outlined),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          isPassVisible = true;
                        });
                      },
                      child: Icon(Icons.visibility_outlined),
                    )
            : SizedBox.shrink(),
      ),
    );
  }
}
