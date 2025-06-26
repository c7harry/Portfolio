import 'package:flutter/material.dart';
import 'dart:math' as math;

class ContinuousBackground extends StatefulWidget {
  final Widget child;
  final double? height;

  const ContinuousBackground({super.key, required this.child, this.height});

  @override
  State<ContinuousBackground> createState() => _ContinuousBackgroundState();
}

class _ContinuousBackgroundState extends State<ContinuousBackground>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _waveController;
  late AnimationController _particleController;
  late ScrollController _scrollController;

  double _scrollOffset = 0.0;
  double _maxScrollExtent = 1.0;

  @override
  void initState() {
    super.initState();

    // Continuous floating animation
    _floatingController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    // Particle system animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    // Find the scroll controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _findScrollController();
    });
  }

  void _findScrollController() {
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      _scrollController = scrollable.widget.controller ?? ScrollController();
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = _scrollController.offset;
        _maxScrollExtent = _scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _waveController.dispose();
    _particleController.dispose();
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Calculate scroll progress (0.0 to 1.0)
    final scrollProgress =
        _maxScrollExtent > 0
            ? (_scrollOffset / _maxScrollExtent).clamp(0.0, 1.0)
            : 0.0;

    return Container(
      height: widget.height,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _floatingController,
          _waveController,
          _particleController,
        ]),
        builder: (context, child) {
          return CustomPaint(
            painter: AnimatedBackgroundPainter(
              isDark: isDark,
              floatingProgress: _floatingController.value,
              waveProgress: _waveController.value,
              particleProgress: _particleController.value,
              scrollProgress: scrollProgress,
              scrollOffset: _scrollOffset,
            ),
            child: Container(
              width: double.infinity,
              height: widget.height,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class AnimatedBackgroundPainter extends CustomPainter {
  final bool isDark;
  final double floatingProgress;
  final double waveProgress;
  final double particleProgress;
  final double scrollProgress;
  final double scrollOffset;

  AnimatedBackgroundPainter({
    required this.isDark,
    required this.floatingProgress,
    required this.waveProgress,
    required this.particleProgress,
    required this.scrollProgress,
    required this.scrollOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dynamic gradient that shifts with scroll
    final gradientShift = scrollProgress * 0.3;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDark
              ? [
                Color.lerp(
                  const Color.fromARGB(255, 5, 8, 12),
                  const Color.fromARGB(255, 8, 12, 18),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromARGB(255, 8, 12, 18),
                  const Color.fromARGB(255, 12, 16, 22),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromARGB(255, 12, 16, 22),
                  const Color.fromARGB(255, 16, 20, 26),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromARGB(255, 16, 20, 26),
                  const Color.fromARGB(255, 20, 24, 30),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromARGB(255, 8, 12, 18),
                  const Color.fromARGB(255, 12, 16, 22),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromARGB(255, 5, 8, 12),
                  const Color.fromARGB(255, 8, 12, 18),
                  gradientShift,
                )!,
              ]
              : [
                Color.lerp(
                  const Color.fromRGBO(252, 254, 255, 1),
                  const Color.fromRGBO(248, 252, 255, 1),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromRGBO(248, 252, 255, 1),
                  const Color.fromRGBO(244, 248, 254, 1),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromRGBO(244, 248, 254, 1),
                  const Color.fromRGBO(240, 245, 252, 1),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromRGBO(240, 245, 252, 1),
                  const Color.fromRGBO(235, 242, 250, 1),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromRGBO(248, 252, 255, 1),
                  const Color.fromRGBO(244, 248, 254, 1),
                  gradientShift,
                )!,
                Color.lerp(
                  const Color.fromRGBO(252, 254, 255, 1),
                  const Color.fromRGBO(248, 252, 255, 1),
                  gradientShift,
                )!,
              ],
      stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Animated layers with parallax
    _drawAnimatedParticleField(canvas, size);
    _drawMorphingGeometry(canvas, size);
    _drawParallaxWaves(canvas, size);
    _drawInteractiveGrid(canvas, size);
    _drawScrollReactiveElements(canvas, size);
  }

  void _drawAnimatedParticleField(Canvas canvas, Size size) {
    final random = math.Random(42);

    // Create floating particles that move with scroll and time
    for (int i = 0; i < 30; i++) {
      final baseX = size.width * random.nextDouble();
      final baseY = size.height * random.nextDouble();

      // Parallax movement based on scroll
      final parallaxFactor = 0.3 + (i % 3) * 0.2;
      final scrollInfluence = scrollOffset * parallaxFactor * 0.1;

      // Floating animation
      final floatOffset = math.sin(floatingProgress * 2 * math.pi + i) * 15;
      final horizontalDrift =
          math.cos(floatingProgress * math.pi + i * 0.5) * 10;

      final x = baseX + horizontalDrift - scrollInfluence;
      final y = baseY + floatOffset;

      // Skip if out of bounds
      if (x < -50 || x > size.width + 50 || y < -50 || y > size.height + 50)
        continue;

      final opacity = (0.005 +
              math.sin(particleProgress * 2 * math.pi + i) * 0.003)
          .clamp(0.0, 0.02);

      final paint =
          Paint()
            ..color = (isDark ? Colors.white : Colors.black).withOpacity(
              opacity,
            )
            ..style = PaintingStyle.fill;

      final radius = 8 + math.sin(particleProgress * 2 * math.pi + i * 2) * 4;

      // Draw particle with glow effect
      _drawGlowingParticle(canvas, Offset(x, y), radius, paint);
    }
  }

  void _drawMorphingGeometry(Canvas canvas, Size size) {
    for (int i = 0; i < 12; i++) {
      final baseX = size.width * (0.1 + (i % 4) * 0.25);
      final baseY = size.height * (0.2 + (i ~/ 4) * 0.3);

      // Parallax effect
      final parallaxX = scrollProgress * 50 * ((i % 3) - 1);
      final parallaxY = scrollProgress * 30 * ((i % 2) - 0.5);

      final x =
          baseX + parallaxX + math.sin(floatingProgress * 2 * math.pi + i) * 20;
      final y =
          baseY + parallaxY + math.cos(floatingProgress * 2 * math.pi + i) * 15;

      if (x < -100 || x > size.width + 100) continue;

      // Morphing size and rotation
      final baseSize = 30 + (i % 3) * 15;
      final morphedSize =
          baseSize + math.sin(floatingProgress * 4 * math.pi + i) * 8;
      final rotation =
          floatingProgress * 2 * math.pi + scrollProgress * math.pi;

      // Dynamic opacity
      final baseOpacity = isDark ? 0.015 : 0.02;
      final dynamicOpacity =
          baseOpacity + math.sin(particleProgress * 2 * math.pi + i) * 0.005;

      final paint =
          Paint()
            ..color = _getShapeColor(
              i,
            ).withOpacity(dynamicOpacity.clamp(0.0, 0.03))
            ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      // Draw different morphing shapes
      switch (i % 4) {
        case 0:
          _drawMorphingHexagon(canvas, morphedSize, paint);
          break;
        case 1:
          _drawMorphingTriangle(canvas, morphedSize, paint);
          break;
        case 2:
          _drawMorphingDiamond(canvas, morphedSize, paint);
          break;
        case 3:
          _drawMorphingCircle(canvas, morphedSize, paint);
          break;
      }

      canvas.restore();
    }
  }

  void _drawParallaxWaves(Canvas canvas, Size size) {
    // Multiple wave layers with different parallax speeds
    for (int layer = 0; layer < 4; layer++) {
      final waveHeight = 25.0 + layer * 15;
      final frequency = 0.002 + layer * 0.0005;
      final speed = 1.0 + layer * 0.3;
      final parallaxSpeed = 0.1 + layer * 0.05;

      // Scroll-based parallax
      final scrollParallax = scrollOffset * parallaxSpeed;

      final path = Path();
      final baseY = size.height * (0.2 + layer * 0.2);

      path.moveTo(-scrollParallax, baseY);

      for (double x = -scrollParallax; x <= size.width + 100; x += 3) {
        final timeOffset = waveProgress * speed * 2 * math.pi;
        final scrollInfluence = scrollProgress * math.pi * 0.5;

        final y =
            baseY +
            waveHeight * math.sin(x * frequency + timeOffset) +
            waveHeight *
                0.3 *
                math.sin(x * frequency * 2.5 + timeOffset * 1.3) +
            waveHeight * 0.2 * math.sin(scrollInfluence + x * frequency * 0.5);

        path.lineTo(x, y);
      }

      final opacity = (isDark ? 0.008 : 0.012) * (1.0 - layer * 0.2);
      final paint =
          Paint()
            ..color = _getWaveColor(layer).withOpacity(opacity)
            ..strokeWidth = 1.5 + layer * 0.5
            ..style = PaintingStyle.stroke;

      canvas.drawPath(path, paint);
    }
  }

  void _drawInteractiveGrid(Canvas canvas, Size size) {
    final baseSpacing = 100.0;
    final dynamicSpacing = baseSpacing + scrollProgress * 20;

    // Grid lines that react to scroll
    final paint =
        Paint()
          ..color = (isDark ? Colors.white : Colors.black).withOpacity(
            0.003 + scrollProgress * 0.002,
          )
          ..strokeWidth = 0.3 + scrollProgress * 0.2
          ..style = PaintingStyle.stroke;

    // Diagonal grid with scroll influence
    final gridOffset = scrollOffset * 0.05;

    for (
      double i = -size.height - gridOffset;
      i <= size.width + size.height + gridOffset;
      i += dynamicSpacing
    ) {
      // Animated diagonal lines
      final animationOffset =
          math.sin(floatingProgress * 2 * math.pi + i * 0.01) * 5;

      canvas.drawLine(
        Offset(i + animationOffset, 0),
        Offset(i - size.height + animationOffset, size.height),
        paint,
      );

      canvas.drawLine(
        Offset(i + animationOffset, 0),
        Offset(i + size.height + animationOffset, size.height),
        paint,
      );
    }
  }

  void _drawScrollReactiveElements(Canvas canvas, Size size) {
    // Elements that specifically react to scroll position
    final progress = scrollProgress;

    // Reactive accent lines
    for (int i = 0; i < 5; i++) {
      final startY = size.height * (0.1 + i * 0.2);
      final lineProgress = (progress - i * 0.2).clamp(0.0, 1.0);

      if (lineProgress > 0) {
        final startX = -100.0;
        final endX = size.width * lineProgress;

        final paint =
            Paint()
              ..color = (isDark ? Colors.cyan : Colors.indigo).withOpacity(
                0.1 * lineProgress,
              )
              ..strokeWidth = 2.0
              ..style = PaintingStyle.stroke;

        canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint);

        // Add particle at the end
        if (lineProgress > 0.1) {
          final particlePaint =
              Paint()
                ..color = (isDark ? Colors.cyan : Colors.indigo).withOpacity(
                  0.3 * lineProgress,
                )
                ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(endX, startY), 3.0, particlePaint);
        }
      }
    }
  }

  // Helper methods for advanced drawing
  void _drawGlowingParticle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    // Create glow effect with multiple circles
    final glowPaint =
        Paint()
          ..color = paint.color.withOpacity(paint.color.opacity * 0.3)
          ..style = PaintingStyle.fill;

    // Outer glow
    canvas.drawCircle(center, radius * 2, glowPaint);
    // Main particle
    canvas.drawCircle(center, radius, paint);
  }

  Color _getShapeColor(int index) {
    final colors =
        isDark
            ? [Colors.white, Colors.blue, Colors.cyan, Colors.purple]
            : [Colors.black, Colors.indigo, Colors.blue, Colors.deepPurple];
    return colors[index % colors.length];
  }

  Color _getWaveColor(int layer) {
    final colors =
        isDark
            ? [Colors.cyan, Colors.blue, Colors.purple, Colors.indigo]
            : [Colors.blue, Colors.indigo, Colors.deepPurple, Colors.blueGrey];
    return colors[layer % colors.length];
  }

  void _drawMorphingHexagon(Canvas canvas, double size, Paint paint) {
    final path = Path();
    final sides = 6;
    final morph = math.sin(floatingProgress * 4 * math.pi) * 0.1;

    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi / sides) * i;
      final radius = size * (1 + morph * math.sin(i.toDouble()));
      final x = radius * math.cos(angle);
      final y = radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawMorphingTriangle(Canvas canvas, double size, Paint paint) {
    final morph = math.sin(floatingProgress * 3 * math.pi) * 0.15;
    final path = Path();

    path.moveTo(0, -size * (1 + morph));
    path.lineTo(-size * math.cos(math.pi / 6) * (1 - morph), size * 0.5);
    path.lineTo(size * math.cos(math.pi / 6) * (1 + morph), size * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawMorphingDiamond(Canvas canvas, double size, Paint paint) {
    final morph = math.sin(floatingProgress * 5 * math.pi) * 0.2;
    final path = Path();

    path.moveTo(0, -size * (1 + morph));
    path.lineTo(size * (1 - morph), 0);
    path.lineTo(0, size * (1 + morph));
    path.lineTo(-size * (1 - morph), 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawMorphingCircle(Canvas canvas, double size, Paint paint) {
    final morph = math.sin(floatingProgress * 6 * math.pi) * 0.3;
    final radius = size * (1 + morph);
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedBackgroundPainter oldDelegate) {
    return oldDelegate.floatingProgress != floatingProgress ||
        oldDelegate.waveProgress != waveProgress ||
        oldDelegate.particleProgress != particleProgress ||
        oldDelegate.scrollProgress != scrollProgress ||
        oldDelegate.scrollOffset != scrollOffset;
  }
}
