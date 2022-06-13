import 'dart:math';

import 'package:bmi_app/data/bmi_state.dart';
import 'package:bmi_app/data/gender.dart';

/// [Bmi] class
class Bmi {
  double height;
  double weight;
  Gender gender;

  Bmi({
    required this.height,
    required this.weight,
    required this.gender,
  });

  /// A collection of index points to determine the weight condition.
  static const Map<Gender, Map<String, double>> indexPoints = {
    Gender.female: {
      'min': 17.0,
      'mid': 23.0,
      'max': 27.0,
    },
    Gender.male: {
      'min': 18.0,
      'mid': 25.0,
      'max': 27.0,
    }
  };

  /// Convert User height in cm to meter.
  double get _heightInMeter => height / 100;

  /// User BMI value
  double get indexValue => weight / pow(_heightInMeter, 2);

  /// Minimum ideal of weight based on User height [_heightInMeter]
  double get minIdealWeight {
    return indexPoints[gender]!["min"]! * pow(_heightInMeter, 2);
  }

  /// Maximum ideal of weight based on User height [_heightInMeter]
  double get maxIdealWeight {
    return indexPoints[gender]!["mid"]! * pow(_heightInMeter, 2);
  }

  /// User BMI state based on BMI value [indexValue]
  BmiState get indexState {
    if (indexValue <= indexPoints[gender]!["min"]!) {
      return BmiState.underweight;
    } else if (indexValue <= indexPoints[gender]!["mid"]!) {
      return BmiState.normal;
    } else if (indexValue <= indexPoints[gender]!["max"]!) {
      return BmiState.overweight;
    }
    return BmiState.obese;
  }

  /// User weight condition based on BMI state [indexState].
  String get weightCondition {
    switch (indexState) {
      case BmiState.underweight:
        return "kurang";
      case BmiState.normal:
        return "normal";
      case BmiState.overweight:
        return "berlebih";
      case BmiState.obese:
        return "sangat berlebih (obesitas)";
    }
  }

  /// A short suggestions related to weight condition based on [indexState].
  String get _suggestionForWightCondition {
    switch (indexState) {
      case BmiState.underweight:
        return "menambah";
      case BmiState.normal:
        return "mempertahankan";
      case BmiState.overweight:
        return "menurunkan";
      case BmiState.obese:
        return "menurunkan";
    }
  }

  /// An informational message about the User BMI value, weight condition and
  /// a brief advice regarding his weight.
  String get message {
    String messageTemplate = "Index massa tubuh Anda $weightCondition. "
        "Dengan tinggi Anda yang sekarang ($height cm), Anda perlu "
        "$_suggestionForWightCondition berat Anda, pada kisaran "
        "${minIdealWeight.toStringAsFixed(2)} kg sampai "
        "${maxIdealWeight.toStringAsFixed(2)} kg.";

    return messageTemplate;
  }
}
