import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../widget/base_background.dart';
import 'difficulty_selection.dart';

class TopicSelectionScreen extends StatefulWidget {
  const TopicSelectionScreen({super.key});

  static const routeName = '/topic-selection';

  @override
  State<TopicSelectionScreen> createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _topics = [
    '역사',
    '음악',
    '기본상식',
    '과학',
    '속담',
    '대중문화',
    '넌센스',
    '수도',
    '음악',
  ];

  final Random _random = Random();
  final Map<String, Offset> _positions = {};
  final Map<String, Offset> _velocities = {};
  late final Ticker _ticker;
  Size _screenSize = Size.zero;

  static const double _margin = 40.0;
  static const double _topBarrierHeight = 140.0;
  static const double _speedMin = 50.0;
  static const double _speedMax = 90.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  void _initialize() {
    _screenSize = MediaQuery.of(context).size;
    _setInitialPositionsAndVelocities();
  }

  void _setInitialPositionsAndVelocities() {
    for (final topic in _topics) {
      final dx =
          _margin + _random.nextDouble() * (_screenSize.width - _margin * 2);
      final dy = _topBarrierHeight +
          _margin +
          _random.nextDouble() *
              (_screenSize.height - _topBarrierHeight - _margin * 2);
      final speed = _speedMin + _random.nextDouble() * (_speedMax - _speedMin);
      final angle = _random.nextDouble() * 2 * pi;
      final vx = cos(angle) * speed;
      final vy = sin(angle) * speed;
      _positions[topic] = Offset(dx, dy);
      _velocities[topic] = Offset(vx, vy);
    }
  }

  void _onTick(Duration elapsed) {
    if (!mounted || _screenSize == Size.zero) return;
    const dt = 1 / 60;

    setState(() {
      for (final topic in _topics) {
        final pos = _positions[topic] ?? Offset.zero;
        final vel = _velocities[topic] ?? Offset.zero;
        Offset next = pos + vel * dt;

        double vx = vel.dx;
        double vy = vel.dy;

        if (next.dx < _margin) {
          next = Offset(_margin, next.dy);
          vx = vx.abs();
        } else if (next.dx > _screenSize.width - _margin) {
          next = Offset(_screenSize.width - _margin, next.dy);
          vx = -vx.abs();
        }

        const topLimit = _topBarrierHeight + _margin * 0.5;
        final bottomLimit = _screenSize.height - _margin;
        if (next.dy < topLimit) {
          next = Offset(next.dx, topLimit);
          vy = vy.abs();
        } else if (next.dy > bottomLimit) {
          next = Offset(next.dx, bottomLimit);
          vy = -vy.abs();
        }

        _positions[topic] = next;
        _velocities[topic] = Offset(vx, vy);
      }
    });
  }

  void _onTopicTap(String topic) {
    Navigator.pushNamed(
      context,
      DifficultySelectionScreen.routeName,
      arguments: topic,
    );
  }

  void _handleResize(Size newSize) {
    if (_screenSize == newSize) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _screenSize = newSize;
        _clampPositions();
      });
    });
  }

  void _clampPositions() {
    for (final topic in _topics) {
      final pos = _positions[topic];
      if (pos == null) continue;
      final clampedX = pos.dx.clamp(_margin, _screenSize.width - _margin);
      final clampedY = pos.dy
          .clamp(_topBarrierHeight + _margin * 0.5, _screenSize.height - _margin);
      _positions[topic] = Offset(clampedX, clampedY);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          _handleResize(Size(constraints.maxWidth, constraints.maxHeight));
          return BaseBackground(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: _topBarrierHeight,
                  child: Container(
                    color: Colors.black.withOpacity(0.12),
                    alignment: Alignment.center,
                    child: Text(
                      '주제',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                ),
                ..._topics.map(
                  (topic) => Positioned(
                    left: _positions[topic]?.dx ?? -100,
                    top: _positions[topic]?.dy ?? -100,
                    child: GestureDetector(
                      onTap: () => _onTopicTap(topic),
                      child: Text(
                        topic,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: SafeArea(
                    child: IconButton(
                      iconSize: 32,
                      color: Colors.black,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
