import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double batteryPercentage;

  RadialProgress({this.batteryPercentage});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double batteryPercentage;

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    batteryPercentage = widget.batteryPercentage;
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          print('deg change');
          progressDegrees =
              (batteryPercentage ?? 0) / 100 * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void didUpdateWidget(RadialProgress oldWidget) {
    if (batteryPercentage != widget.batteryPercentage) {
      setState(() {
        batteryPercentage = widget.batteryPercentage;
        progressDegrees =
            (batteryPercentage ?? 0) / 100 * _progressAnimation.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200.0,
        width: 200.0,
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: fadeInDuration,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      widget.batteryPercentage != null
                          ? widget.batteryPercentage.toStringAsFixed(1)
                          : '--',
                      style: TextStyle(
                        fontSize: 48.0,
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
                      '%',
                      style:
                          TextStyle(fontSize: 18.0, color: Color(0xff869EA5)),
                    )
                  ],
                ),
                Text(
                  'BATTERY LEVEL',
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
      ),
      painter: RadialPainter(progressDegrees),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
              colors: [Color(0xffC464FF), Color(0xffFB4ABF), Color(0xffFB4A4A)],
              stops: [0.0, 0.4976, 0.9768])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
