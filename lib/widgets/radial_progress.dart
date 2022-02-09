import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double dataPercentage;
  final double dataFontSize;
  final String subtitle;
  final double radians;
  final double radiusDenominator;
  final bool blueGradient;
  final String dataUnit;

  RadialProgress(
      {required this.dataPercentage,
      required this.subtitle,
      required this.radians,
      required this.radiusDenominator,
      required this.dataFontSize,
      this.blueGradient = false,
      required this.dataUnit});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? _radialProgressAnimationController;
  Animation<double>? _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double? dataPercentage;

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    dataPercentage = widget.dataPercentage;
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController!, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          // print('deg change');
          progressDegrees =
              (dataPercentage ?? 0) / 100 * _progressAnimation!.value;
        });
      });

    _radialProgressAnimationController!.forward();
  }

  @override
  void didUpdateWidget(RadialProgress oldWidget) {
    if (dataPercentage != widget.dataPercentage) {
      setState(() {
        dataPercentage = widget.dataPercentage;
        progressDegrees =
            (dataPercentage ?? 0) / 100 * _progressAnimation!.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _radialProgressAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200.0,
        width: 200.0,
        // padding: EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: fadeInDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    widget.dataPercentage.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: widget.dataFontSize,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black12,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.dataUnit,
                    style: TextStyle(fontSize: 18.0, color: Color(0xff869EA5)),
                  )
                ],
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 9.0,
                  letterSpacing: 1.5,
                  color: Color(0xff869EA5),
                ),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progressDegrees,
          radians: widget.radians,
          radiusDenominator: widget.radiusDenominator,
          blueGradient: widget.blueGradient),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;
  final double radians;
  final double radiusDenominator;
  final bool blueGradient;

  RadialPainter(this.progressInDegrees,
      {required this.radians,
      required this.radiusDenominator,
      required this.blueGradient});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / (radiusDenominator), paint);

    Paint progressPaint = Paint()
      ..shader = (!blueGradient
              ? kPrimaryLinearGradient
              : kSecondaryLinearGradient)
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawArc(
        Rect.fromCircle(
            center: center, radius: size.width / (radiusDenominator)),
        math.radians(radians),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
