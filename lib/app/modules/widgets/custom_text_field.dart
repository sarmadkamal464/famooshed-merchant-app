import 'package:flutter/material.dart';

import '../../theme/size_config.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.textEditingController,
      this.maxLines,
      this.validator});
  final String title, hintText;
  final TextEditingController textEditingController;
  int? maxLines;
  FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Container(
          // height: getProportionateScreenHeight(44),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: textEditingController,
            style: TextStyle(
              fontSize: getProportionalFontSize(13),
            ),
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusColor: Colors.white,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(
                  color: Colors.black54, fontSize: getProportionalFontSize(12)),
              contentPadding: EdgeInsets.only(
                top: getProportionateScreenHeight(12),
                bottom: getProportionateScreenHeight(12),
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16),
              ),
            ),
            validator: validator,
          ),
        )
      ],
    );
  }
}
