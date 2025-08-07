import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final double showThreshold;
  final Duration animationDuration;
  final Duration scrollDuration;
  final Curve animationCurve;
  final Curve scrollCurve;
  final double bottomPadding;
  final double rightPadding;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;

  const ScrollToTopButton({
    super.key,
    required this.scrollController,
    this.showThreshold = 200.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.scrollDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.scrollCurve = Curves.easeInOut,
    this.bottomPadding = 20.0,
    this.rightPadding = 20.0,
    this.elevation = 8.0,
    this.backgroundColor,
    this.foregroundColor,
    this.icon = Icons.keyboard_arrow_up,
  });

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final showButton = widget.scrollController.offset > widget.showThreshold;
    if (showButton != _showButton) {
      setState(() {
        _showButton = showButton;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: widget.scrollDuration,
      curve: widget.scrollCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      bottom: _showButton ? widget.bottomPadding : -100,
      right: widget.rightPadding,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: widget.backgroundColor ?? AppTheme.primaryColor,
        foregroundColor: widget.foregroundColor ?? AppTheme.textColor,
        elevation: widget.elevation,
        mini: true,
        child: Icon(widget.icon),
      ),
    );
  }
}
