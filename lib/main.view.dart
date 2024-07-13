import 'package:flutter/material.dart';
import 'package:pandabar/fab-button.view.dart';
import 'package:pandabar/model.dart';
import 'package:pandabar/pandabar.dart';

class PandaBar extends StatefulWidget {

  final Color? backgroundColor;
  final List<PandaBarButtonData> buttonData;
  final Widget? fabIcon;
  final bool hasFabIcon;

  final Color? buttonColor;
  final Color? buttonSelectedColor;
  final List<Color>? fabColors;

  final Function(dynamic selectedPage) onChange;
  final VoidCallback? onFabButtonPressed;
  final int? id;

  const PandaBar({
    Key? key,
    required this.buttonData,
    required this.onChange,
    this.backgroundColor,
    this.id,
    this.fabIcon,
    this.hasFabIcon = true,
    this.fabColors,
    this.onFabButtonPressed,
    this.buttonColor,
    this.buttonSelectedColor,
  }) : super(key: key);

  @override
  _PandaBarState createState() => _PandaBarState();
}

class _PandaBarState extends State<PandaBar> {
  final double fabSize = 50;
  final Color unSelectedColor = Colors.grey;

  dynamic selectedId;

  @override
  void initState() {
    if(widget.id !=null){
      selectedId = widget.buttonData.length > 0 ? widget.id  : null;
    }else{
      selectedId = widget.buttonData.length > 0 ? widget.buttonData.first.id : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          padding: EdgeInsets.symmetric(vertical: 10),
          color: widget.backgroundColor ?? Color(0xFF222427),
          child: Builder(builder: (context) {
            List<Widget> leadingChildren = [];
            List<Widget> trailingChildren = [];

            if(widget.hasFabIcon){
              widget.buttonData.asMap().forEach((i, data) {
                Widget btn = PandaBarButton(
                  icon: data.icon,
                  title: data.title,
                  isSelected: data.id != null && selectedId == data.id,
                  unselectedColor: widget.buttonColor,
                  selectedColor: widget.buttonSelectedColor,
                  onTap: () {
                    setState(() {
                      selectedId = data.id;
                    });
                    this.widget.onChange(data.id);
                  },
                );

                if (i < 2) {
                  leadingChildren.add(btn);
                } else {
                  trailingChildren.add(btn);
                }
              });
            }else{
              widget.buttonData.asMap().forEach((i, data) {
                Widget btn = PandaBarButton(
                  icon: data.icon,
                  title: data.title,
                  isSelected: data.id != null && selectedId == data.id,
                  unselectedColor: widget.buttonColor,
                  selectedColor: widget.buttonSelectedColor,
                  onTap: () {
                    setState(() {
                      selectedId = data.id;
                    });
                    this.widget.onChange(data.id);
                  },
                );
                  leadingChildren.add(btn);
              });
            }


            if(widget.hasFabIcon){
              return  Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: leadingChildren,
                    ),
                  ),
                  if(widget.hasFabIcon)
                    Container(width: fabSize),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: trailingChildren,
                    ),
                  ),
                ],
              );
            }else{
              return Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: leadingChildren,
                    ),
                  );
            }
          }),
        ),
        if(widget.hasFabIcon)
          PandaBarFabButton(
            size: fabSize,
            icon: widget.fabIcon,
            onTap: widget.onFabButtonPressed,
            colors: widget.fabColors,
          ),
      ],
    );
  }
}

