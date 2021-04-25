import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/pallete.dart';

class SmallTextInputField extends StatelessWidget {
  const SmallTextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: 1, vertical: 4),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 10),
                child: Icon(
                  icon,
                  size: 20,
                  color: kWhite,
                ),
              ),
              hintText: hint,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}