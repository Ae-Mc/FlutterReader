import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/style.dart';

class InputTextField extends StatefulWidget {
  final IconData leftIcon;
  final List<IconData> rightIcons;
  final String hintText;
  final bool obscureText;
  final Function(String text) onChanged;
  final Function(String text) onSubmitted;

  InputTextField({
    this.leftIcon,
    this.hintText,
    this.rightIcons,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
  });

  createState() => _InputTextField();
}

class _InputTextField extends State<InputTextField> {
  bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            offset: Offset(0, 15),
            blurRadius: 30,
            spreadRadius: -5,
          )
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          widget.leftIcon == null
              ? SizedBox()
              : Icon(
                  widget.leftIcon,
                  color: Theme.of(context).buttonColor,
                ),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              style: signInInputFieldsStyle,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyText1,
                border: InputBorder.none,
              ),
              obscureText: obscureText,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          SizedBox(width: 5),
          widget.rightIcons == null
              ? SizedBox()
              : GestureDetector(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: Icon(
                    widget.rightIcons[obscureText ? 0 : 1],
                    color: Theme.of(context).buttonColor,
                  ),
                ),
        ],
      ),
    );
  }
}
