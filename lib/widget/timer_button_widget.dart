import 'package:flutter/material.dart';

class TimerButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const TimerButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.15,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 30,
                color: buttonTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
