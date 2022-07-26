import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GradientContainer extends StatefulWidget {
  final Widget? child;
  final bool? opacity;
  const GradientContainer({required this.child, this.opacity});
  @override
  _GradientContainerState createState() => _GradientContainerState();
}

List<Color> getTransBackGradient() {
  return _transOpt[backGrad];
}

List<Color> getBackGradient() {
  return _backOpt[backGrad];
}

int backGrad = Hive.box('plalist_db').get('backGrad', defaultValue: 2) as int;
final List<List<Color>> _transOpt = [
  [
    Colors.grey[850]!.withOpacity(0.8),
    Colors.grey[900]!.withOpacity(0.9),
    Colors.black.withOpacity(1),
  ],
  [
    Colors.grey[900]!.withOpacity(0.8),
    Colors.grey[900]!.withOpacity(0.9),
    Colors.black.withOpacity(1),
  ],
  [
    Colors.grey[900]!.withOpacity(0.9),
    Colors.black.withOpacity(1),
  ],
  [
    Colors.grey[900]!.withOpacity(0.9),
    Colors.black.withOpacity(0.9),
    Colors.black.withOpacity(1),
  ],
  [
    Colors.black.withOpacity(0.9),
    Colors.black.withOpacity(1),
  ]
];
final List<List<Color>> _backOpt = [
  [
    Colors.grey[850]!,
    Colors.grey[900]!,
    Colors.black,
  ],
  [
    Colors.grey[900]!,
    Colors.grey[900]!,
    Colors.black,
  ],
  [
    Colors.grey[900]!,
    Colors.black,
  ],
  [
    Colors.grey[900]!,
    Colors.black,
    Colors.black,
  ],
  [
    Colors.black,
    Colors.black,
  ]
];

class _GradientContainerState extends State<GradientContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? ((widget.opacity == true)
                  ? getTransBackGradient()
                  : getBackGradient())
              : [
                  const Color(0xfff5f9ff),
                  Colors.white,
                ],
        ),
      ),
      child: widget.child,
    );
  }
}
