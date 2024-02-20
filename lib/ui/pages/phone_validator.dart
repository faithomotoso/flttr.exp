import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';

class PhoneValidatorPage extends StatefulWidget {
  static const String routeName = "phone_validator";

  const PhoneValidatorPage({super.key});

  @override
  State<PhoneValidatorPage> createState() => _PhoneValidatorPageState();
}

class _PhoneValidatorPageState extends State<PhoneValidatorPage> {
  TextEditingController controller = TextEditingController();
  bool? isPhoneValid;
  String? normalizedPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone validator"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              onSubmitted: (v) async {
                validatePhone();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  validatePhone();
                },
                child: Text("Validate phone number")),
            const SizedBox(
              height: 10,
            ),
            if (isPhoneValid != null)
              Text("Phone Number is ${isPhoneValid! ? "Valid" : "Invalid"}"),
            if ((isPhoneValid ?? false) && normalizedPhoneNumber != null)
              Text("Normalized phone number $normalizedPhoneNumber")
          ],
        ),
      ),
    );
  }

  void validatePhone() async {
    String countryCode = "EG";
    setState(() {
      isPhoneValid = null;
    });
    isPhoneValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: controller.text, isoCode: countryCode);
    try {
      normalizedPhoneNumber = await PhoneNumberUtil.normalizePhoneNumber(
              phoneNumber: controller.text, isoCode: countryCode)
          .then((value) async {
        print("Normalizing phone: $value");
        print("Validating after normalizing");
        await PhoneNumberUtil.isValidPhoneNumber(
                phoneNumber: value!, isoCode: countryCode)
            .then((value) {
          print("Is normalized phone number valid: $value");
          return value;
        });
        return value;
      });
    } on Exception catch (e) {
      normalizedPhoneNumber = null;
    }
    setState(() {});
  }
}
