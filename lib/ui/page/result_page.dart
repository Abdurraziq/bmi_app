import 'package:bmi_app/data/bmi.dart';
import 'package:bmi_app/ui/component/bmi_gauge.dart';
import 'package:bmi_app/ui/component/user_data_box.dart';
import 'package:flutter/material.dart';

///
/// [ResultPage] A page that displays the results of calculating the BMI index,
/// as well as it's interpretation.
/// This page will also display a brief information about the user's weight
/// state, as well as suggestions for maintaining an ideal weight.
///
class ResultPage extends StatelessWidget {
  final Bmi bmi;

  const ResultPage({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BmiGauge(bmi: bmi),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      UserDataBox(
                        field: "Tinggi",
                        value: bmi.height.toString(),
                        unit: "cm",
                        color: Colors.blueAccent.shade400,
                      ),
                      UserDataBox(
                        field: "Berat",
                        value: bmi.weight.toString(),
                        unit: "kg",
                        color: Colors.pinkAccent.shade400,
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    "Info",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(height: 2.0, color: Colors.grey),
                  const SizedBox(height: 8.0),
                  Text(bmi.message),
                  const SizedBox(height: 8.0),
                  const Divider(height: 2.0, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
