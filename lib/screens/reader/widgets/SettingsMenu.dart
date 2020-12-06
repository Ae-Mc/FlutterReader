import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/generated/l10n.dart';

class SettingsMenu extends StatefulWidget {
  final AnimationController _animationController;
  final Function callback;

  SettingsMenu(this._animationController, this.callback);

  createState() => _SettingsMenu();
}

class _SettingsMenu extends State<SettingsMenu> {
  final List<String> fonts = ["Arial", "Barlow", "Times New Roman"];
  final List<String> colors = ["White", "Black", "Sepia"];
  final List<String> sizes = ["8", "16", "24", "32"];
  int selectedFont = 0, selectedColor = 0, selectedSize = 0;

  void onFontChange(int selectedFont) {
    this.selectedFont = selectedFont;
    widget.callback(
      fonts[selectedFont],
      colors[selectedColor],
      int.parse(sizes[selectedSize]),
    );
  }

  void onColorChange(int selectedColor) {
    this.selectedColor = selectedColor;
    widget.callback(
      fonts[selectedFont],
      colors[selectedColor],
      int.parse(sizes[selectedSize]),
    );
  }

  void onSizeChange(int selectedSize) {
    this.selectedSize = selectedSize;
    widget.callback(
      fonts[selectedFont],
      colors[selectedColor],
      int.parse(sizes[selectedSize]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(maxHeight: 350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            spreadRadius: -15,
          )
        ],
        color: Theme.of(context)
            .backgroundColor, // Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            S.current.Typography,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 15),
          Slider(fonts, onChange: onFontChange),
          SizedBox(height: 20),
          Text(
            S.current.BackgroundColor,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 15),
          Slider(colors, onChange: onColorChange,),
          SizedBox(height: 20),
          Text(
            S.current.Size,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 15),
          Container(
            width: 150,
            child: SizeChoice(sizes, onChange: onSizeChange,),
          ),
          SizedBox(height: 20),
          Center(
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).shadowColor,
                  size: 30,
                ),
                onPressed: () {
                  widget._animationController.reverse();
                }),
          ),
        ],
      ),
    );
  }
}

class Slider extends StatefulWidget {
  final List<String> elements;
  final int defaultElement;
  final Function onChange;

  Slider(this.elements, {this.onChange, this.defaultElement = 0});

  createState() {
    _Slider slider = _Slider(elements, onChange);
    slider.currentElement = defaultElement;
    return slider;
  }
}

class _Slider extends State<Slider> {
  final List<String> elements;
  final Function onChange;
  int currentElement;

  _Slider(this.elements, this.onChange);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _slideButton(() {
          setState(() {
            currentElement =
                currentElement > 0 ? currentElement - 1 : elements.length - 1;
          });
          if (onChange != null) onChange(currentElement);
        }),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints.expand(height: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFFEBE8FC)),
            ),
            child: Center(
              child: Text(
                elements[currentElement],
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        _slideButton(() {
          setState(() {
            currentElement =
                currentElement < elements.length - 1 ? currentElement + 1 : 0;
          });
          if (onChange != null) onChange(currentElement);
        }, left: false),
      ],
    );
  }

  Widget _slideButton(Function onTap, {bool left = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xFFEBE8FC)),
        ),
        child: Icon(
          left ? Icons.chevron_left_sharp : Icons.chevron_right_sharp,
          color: Color(0xFF7057F1),
          size: 30,
        ),
      ),
    );
  }
}

class SizeChoice extends StatefulWidget {
  final List<String> elements;
  final int defaultElement;
  final Function onChange;

  SizeChoice(this.elements, {this.onChange, this.defaultElement = 0});

  createState() {
    _SizeChoice slider = _SizeChoice(elements, onChange);
    slider.currentElement = defaultElement;
    return slider;
  }
}

class _SizeChoice extends State<SizeChoice> {
  final List<String> elements;
  final Function onChange;
  int currentElement;

  _SizeChoice(this.elements, this.onChange);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _slideButton(() {
          setState(() {
            currentElement =
                currentElement > 0 ? currentElement - 1 : elements.length - 1;
          });
          if (onChange != null) onChange(currentElement);
        }),
        SizedBox(width: 10),
        Expanded(
          child: Center(
            child: Text(
              elements[currentElement],
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        SizedBox(width: 10),
        _slideButton(() {
          setState(() {
            currentElement =
                currentElement < elements.length - 1 ? currentElement + 1 : 0;
          });
          if (onChange != null) onChange(currentElement);
        }, top: false),
      ],
    );
  }

  Widget _slideButton(Function onTap, {bool top = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xFFEBE8FC)),
        ),
        child: RotatedBox(
          quarterTurns: -1,
          child: Icon(
            top ? Icons.chevron_left_sharp : Icons.chevron_right_sharp,
            color: Color(0xFF7057F1),
            size: 30,
          ),
        ),
      ),
    );
  }
}
