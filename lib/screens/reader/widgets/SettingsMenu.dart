import 'package:flutter/material.dart';
import 'package:flutter_reader/generated/l10n.dart';
import 'package:flutter_reader/states/ReaderState.dart';
import 'package:provider/provider.dart';

class SettingsMenu extends StatefulWidget {
  final AnimationController _animationController;

  SettingsMenu(this._animationController);

  createState() => _SettingsMenu();
}

class _SettingsMenu extends State<SettingsMenu> {
  void onFontChange(BuildContext context, int selectedFont) {
    print("Font changed to ${ReaderState.FontFamilies[selectedFont]}");
    Provider.of<ReaderState>(context, listen: false).fontFamily =
        ReaderState.FontFamilies[selectedFont];
  }

  void onColorChange(BuildContext context, int selectedTheme) {
    Provider.of<ReaderState>(context, listen: false).theme =
        ReaderState.Themes[selectedTheme];
    print("Theme changed to ${ReaderState.Themes[selectedTheme].name}");
  }

  void onSizeChange(BuildContext context, int selectedSize) {
    Provider.of<ReaderState>(context, listen: false).fontSize =
        ReaderState.FontSizes[selectedSize];
    print("Size changed to ${ReaderState.FontSizes[selectedSize]}");
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
          Slider(
            ReaderState.FontFamilies,
            onChange: (int selectedFont) => onFontChange(context, selectedFont),
            defaultElement: ReaderState.FontFamilies.indexOf(
                Provider.of<ReaderState>(context).fontFamily),
          ),
          SizedBox(height: 20),
          Text(
            S.current.BackgroundColor,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 15),
          Slider(
            ReaderState.Themes.map((e) => e.name).toList(),
            onChange: (int selectedColor) =>
                onColorChange(context, selectedColor),
            defaultElement: ReaderState.Themes.indexOf(
                Provider.of<ReaderState>(context).theme),
          ),
          SizedBox(height: 20),
          Text(
            S.current.Size,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 15),
          Container(
            width: 150,
            child: SizeChoice(
              ReaderState.FontSizes.map((e) => e.toString()).toList(),
              onChange: (int selectedSize) =>
                  onSizeChange(context, selectedSize),
              defaultElement: ReaderState.FontSizes.indexOf(
                  Provider.of<ReaderState>(context).fontSize),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color.lerp(
                    Provider.of<ReaderState>(context).theme.textColor,
                    Provider.of<ReaderState>(context).theme.backgroundColor,
                    0.5,
                  ),
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
