import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatefulWidget {
  final double maxHeight;
  final Color color;
  final bool enabled;
  final dynamic title;
  final Widget child;
  final Function(bool)? onToggled;
  const SlidingPanel({
    Key? key,
    required this.maxHeight,
    required this.color,
    this.enabled = true,
    required this.title,
    required this.child,
    this.onToggled,
  }) : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  final PanelController _controller = PanelController();
  bool _isOpen = false;
  bool _maxSize = false;
  final double _headerHeight = 80;
  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(30);
    return SlidingUpPanel(
      maxHeight:
          _maxSize ? MediaQuery.of(context).size.height : widget.maxHeight,
      boxShadow: null,
      isDraggable: false,
      color: widget.color,
      controller: _controller,
      borderRadius: const BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
      minHeight: _headerHeight,
      panel: Column(
        children: [
          ..._buildHeader(widget.title),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  _buildHeader(dynamic title) {
    const bottomSpacing = 30.0;
    return [
      SizedBox(
        height: _headerHeight - bottomSpacing,
        child: Stack(
          children: [
            Align(
              child: title is String ? Text(title) : title,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _isOpen
                    ? _buildToggleButton('open', true)
                    : _buildToggleButton('close', false),
              ),
            ),
            if (_isOpen)
              IconButton(
                icon: Icon(
                  _maxSize ? Icons.close_fullscreen : Icons.open_in_full,
                  color: Colors.white,
                ),
                onPressed: widget.enabled
                    ? () {
                        setState(() {
                          _maxSize = !_maxSize;
                        });
                      }
                    : null,
              )
          ],
        ),
      ),
      const SizedBox(
        height: bottomSpacing,
      )
    ];
  }

  _buildToggleButton(String key, bool isOpenButton) {
    return Material(
        key: ObjectKey(key),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        child: IconButton(
          icon: Icon(
            isOpenButton ? Icons.expand_more : Icons.expand_less,
            color: Colors.white,
          ),
          onPressed: widget.enabled
              ? () {
                  if (_isOpen) {
                    _controller.close();
                    _maxSize = false;
                  } else {
                    _controller.open();
                  }
                  setState(() {
                    _isOpen = !_isOpen;
                    widget.onToggled?.call(_isOpen);
                  });
                }
              : null,
        ));
  }
}
