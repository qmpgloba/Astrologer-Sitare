import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class RatePerMinuteScreen extends StatefulWidget {
  const RatePerMinuteScreen({super.key});

  @override
  State<RatePerMinuteScreen> createState() => _RatePerMinuteScreenState();
}

class _RatePerMinuteScreenState extends State<RatePerMinuteScreen> {
  final TextEditingController rateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Per Minute'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: rateController,
                decoration: InputDecoration(
                  labelText: 'Enter the rate per minute(between 0-10)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackColor,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapConfirm(String rate) {
    if (0 < int.parse(rate) && int.parse(rate) < 10) {}
  }
}
