import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class CircularProgressBarWidget extends StatefulWidget {
  final double percentage;
  final double size;
  final String text;

  final bool countdown;

  const CircularProgressBarWidget({
    super.key,
    required this.percentage,
    required this.size,
    this.text = '',
    this.countdown = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CircularProgressBarWidgetState createState() =>
      _CircularProgressBarWidgetState();
}

class _CircularProgressBarWidgetState extends State<CircularProgressBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (widget.countdown) {
      _controller = AnimationController(
        duration: const Duration(seconds: 60),
        vsync: this,
      );
      _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      )..addListener(() {
          setState(() {});
        });
      _controller.forward();
    } else {
      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
      _animation = Tween<double>(begin: 0, end: widget.percentage).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOutCirc,
        ),
      )..addListener(() {
          setState(() {});
        });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondary,
              width: 3,
            ),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Opacity(
                          opacity:
                              0.5, // Reduce opacity to make it look like a shadow
                          child: SizedBox(
                            width: widget.size * 0.55,
                            height: widget.size * 0.55,
                            child: CircularProgressIndicator(
                              value: _animation.value,
                              strokeWidth: widget.size * 0.15,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.tertiary),
                              strokeCap: StrokeCap.round,
                              strokeAlign: 0.1,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: widget.size * 0.55,
                          height: widget.size * 0.55,
                          child: CircularProgressIndicator(
                            value: _animation.value,
                            strokeWidth: widget.size * 0.1,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.complementary),
                            strokeCap: StrokeCap.round,
                            strokeAlign: 0.2,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        widget.countdown
                            ? '${(60 - (_animation.value * 60)).toStringAsFixed(0)}s'
                            : '${(_animation.value * 100).toStringAsFixed(0)}%',
                        style: widget.countdown
                            ? TextStyles.headline0(context)
                            : TextStyles.headline2(context),
                      )),
                    ],
                  ),
                ),
              ),
              if (widget.text.isNotEmpty)
                Text(
                  widget.text,
                  style: TextStyles.headline3(context),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
