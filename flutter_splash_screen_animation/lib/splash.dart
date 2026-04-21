import 'dart:math' as math;

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  static const Color _brandOrange = Color(0xFFF97316);

  late final AnimationController _controller;
  late final Animation<double> _bgFade;
  late final Animation<double> _splitBreak;
  late final Animation<double> _logoFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..forward();

    _bgFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
    );

    _splitBreak = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.10, 0.99, curve: Curves.easeInOutCubic),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.95, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final bgColor = Color.lerp(
            _brandOrange,
            Colors.white,
            _bgFade.value,
          )!;

          return ColoredBox(
            color: bgColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _SplitBreakPainter(
                    breakProgress: _splitBreak.value,
                    panelColor: _brandOrange,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: (1 - _logoFade.value).clamp(0.0, 1.0),
                          child: const Icon(
                            Icons.flutter_dash,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        Opacity(
                          opacity: _logoFade.value,
                          child: const Icon(
                            Icons.flutter_dash,
                            color: _brandOrange,
                            size: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SplitBreakPainter extends CustomPainter {
  const _SplitBreakPainter({
    required this.breakProgress,
    required this.panelColor,
  });

  final double breakProgress;
  final Color panelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = panelColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final diagonal = math.sqrt(w * w + h * h);
    final drawW = diagonal * 1.4;
    final drawH = diagonal * 1.4;
    const stripCount = 6;
    final stripHeight = drawH / stripCount;
    final gapHeight = 0.0;
    final moveDistance = drawW * 1.2 * breakProgress;

    canvas.save();
    canvas.translate(w / 2, h / 2);
    canvas.rotate(50 * math.pi / 180);
    canvas.translate(-drawW / 2, -drawH / 2);

    for (var index = 0; index < stripCount; index++) {
      final top = index * (stripHeight + gapHeight);
      final bottom = top + stripHeight;
      final midY = top + (stripHeight / 2);

      final upperPath = Path()
        ..moveTo(0, top)
        ..lineTo(drawW, top)
        ..lineTo(drawW, midY)
        ..lineTo(0, midY)
        ..close();

      final lowerPath = Path()
        ..moveTo(0, midY)
        ..lineTo(drawW, midY)
        ..lineTo(drawW, bottom)
        ..lineTo(0, bottom)
        ..close();

      canvas.save();
      canvas.translate(-moveDistance, 0);
      canvas.drawPath(upperPath, paint);
      canvas.restore();

      canvas.save();
      canvas.translate(moveDistance, 0);
      canvas.drawPath(lowerPath, paint);
      canvas.restore();
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SplitBreakPainter oldDelegate) {
    return oldDelegate.breakProgress != breakProgress ||
        oldDelegate.panelColor != panelColor;
  }
}
