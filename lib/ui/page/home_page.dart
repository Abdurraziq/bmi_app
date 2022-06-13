import 'package:bmi_app/data/bmi.dart';
import 'package:bmi_app/data/gender.dart';
import 'package:bmi_app/ui/page/result_page.dart';
import 'package:flutter/material.dart';

///
/// [MainPage] A page to enter the user's height, weight and gender.
///
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Gender _gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Apps"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih gender Anda.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        _genderRadioButton(
                          value: "Pria",
                          color: Colors.blue,
                          gender: Gender.male,
                        ),
                        _genderRadioButton(
                          value: "Wanita",
                          color: Colors.pink,
                          gender: Gender.female,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Masukkan data tinggi dan berat Anda.",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          validator: (value) =>
                              _textFieldValidator(value, "tinggi"),
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tinggi Anda (cm)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        TextFormField(
                          validator: (value) =>
                              _textFieldValidator(value, "berat"),
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Berat Anda (kg)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const Divider(height: 2.0, color: Colors.black26),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitToCalculate();
                        },
                        child: const Text(
                          "Hitung",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget to select gender
  Widget _genderRadioButton({
    required String value,
    required Color color,
    required Gender gender,
  }) {
    return Expanded(
      child: Container(
        height: 88.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: _gender == gender ? color : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: _gender == gender ? 4.0 : 0,
          ),
          onPressed: () {
            _changeGender(gender);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                gender == Gender.male ? Icons.male : Icons.female,
                size: 48.0,
                color: _gender == gender ? Colors.white : color,
              ),
              Text(
                value,
                style: TextStyle(
                  color: _gender == gender ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Used to validate text fields so that the data has entered by the user is
  /// not empty and only contains valid numbers.
  String? _textFieldValidator(String? value, String field) {
    double? parsedValue = double.tryParse(value!);
    bool isEmpty = value.isEmpty;
    bool isNotNumber = parsedValue == null;
    bool isZero = parsedValue == 0;

    if (isEmpty) {
      return 'Mohon masukkan nilai $field Anda!';
    } else if (isNotNumber) {
      return 'Mohon hanya memasukkan angka!';
    } else if (isZero) {
      return 'Mohon tidak memasukkan angka 0!';
    }
    return null;
  }

  /// The method used by the [_genderRadioButton] widget to change the [_gender]
  /// state.
  void _changeGender(Gender gender) {
    setState(() {
      _gender = gender;
    });
  }

  /// The method that is called when the calculate button is pressed.
  /// This method will try to check whether the user has entered valid data.
  /// After successful validation, the data entered by the user is then sent
  /// to the [ResultPage] page.
  void _submitToCalculate() {
    if (_formKey.currentState!.validate()) {
      double height = double.parse(_heightController.value.text);
      double weight = double.parse(_weightController.value.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResultPage(
              bmi: Bmi(
                height: height,
                weight: weight,
                gender: _gender,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
