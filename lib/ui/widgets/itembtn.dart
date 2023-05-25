import 'package:flutter/material.dart';
import 'package:network/ui/config/style.dart';

//FirstItem
class FirstItem extends StatelessWidget{

  const FirstItem({
    Key? key,
    this.color,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
    this.press,
  }) : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null),
        super(key: key);

  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;
  final Widget? child;
  final Function? press;

  static const double _defaultElevation = 1.0;

  @override
  Widget build(BuildContext context){

    return GestureDetector(

      onTap: press as void Function()?,
      child: Semantics(
        container: semanticContainer,
        child: Container(
          margin: margin ?? const EdgeInsets.all(4.0),
          child: Material(
            type: MaterialType.card,
            color: couleurSecondaire,
            elevation: elevation ??  _defaultElevation,
            shape: shape ?? const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            borderOnForeground: borderOnForeground,
            clipBehavior: clipBehavior ??  Clip.none,
            child: Semantics(
              explicitChildNodes: !semanticContainer,
              child: child,
            ),
          ),
        ),
      ),

    );

  }

}