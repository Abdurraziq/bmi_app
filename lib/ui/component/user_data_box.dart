import 'package:flutter/material.dart';

/// [UserDataBox] A Widget to display user data such as height and weight.
class UserDataBox extends StatelessWidget {
  const UserDataBox({
    Key? key,
    required this.field,
    required this.value,
    required this.unit,
    required this.color,
  }) : super(key: key);

  final String field;
  final String value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(field, style: const TextStyle(color: Colors.white)),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " $unit",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
