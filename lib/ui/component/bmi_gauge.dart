import 'package:bmi_app/data/bmi.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

///
/// [BmiGauge] A widget containing a Radial Gauge that displays the User BMI
/// value and its brief interpretation.
///
class BmiGauge extends StatelessWidget {
  const BmiGauge({
    Key? key,
    required this.bmi,
    this.minValue = 8.0,
    this.maxValue = 37.0,
  }) : super(key: key);

  final Bmi bmi;
  final double minValue;
  final double maxValue;

  Map<String, double> get _indexPoints => Bmi.indexPoints[bmi.gender]!;

  @override
  Widget build(BuildContext context) {
    double underSegmentSize = _indexPoints["min"]! - minValue;
    double normalSegmentSize = _indexPoints["mid"]! - _indexPoints["min"]!;
    double overSegmentSize = _indexPoints["max"]! - _indexPoints["mid"]!;
    double obuseSegmentSize = maxValue - _indexPoints["max"]!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          PrettyGauge(
            gaugeSize: 240,
            minValue: minValue,
            maxValue: maxValue,
            valueWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  bmi.indexValue.toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const Text(" kg/m²"),
              ],
            ),
            segments: [
              GaugeSegment('under', underSegmentSize, Colors.blueAccent),
              GaugeSegment('Normal', normalSegmentSize, Colors.greenAccent),
              GaugeSegment('over', overSegmentSize, Colors.orangeAccent),
              GaugeSegment('Obese', obuseSegmentSize, Colors.redAccent),
            ],
            currentValueDecimalPlaces: 2,
            currentValue: bmi.indexValue,
            displayWidget:
                Text('BMI', style: Theme.of(context).textTheme.subtitle2),
            showMarkers: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._legendInfo("Kurang", Colors.blueAccent),
              ..._legendInfo("Normal", Colors.greenAccent),
              ..._legendInfo("Berlebih", Colors.orangeAccent),
              ..._legendInfo("Obesitas", Colors.redAccent),
            ],
          ),
          Text(
            bmi.weightCondition.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  List<Widget> _legendInfo(String label, Color color) {
    return [
      Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 8.0),
    ];
  }
}
