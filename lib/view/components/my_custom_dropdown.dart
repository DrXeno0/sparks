import 'package:flutter/material.dart';
import 'package:sparks/view/theme.dart';

class MyDropdown extends StatefulWidget {
  final String title;

  final List<String> items;
  final Color backgroundColor;
  final Color borderColor;
  final double defaultBorderWidth;
  final double clickedBorderWidth;
  final double borderRadius;
  final Duration animationDuration;
  final TextStyle? textStyle;

  final ValueChanged<String>? onItemSelected;

  final double? width;

  const MyDropdown({
    super.key,
    required this.title,
    required this.items,
    this.backgroundColor = const Color(0xffeeeeee),
    this.borderColor = darkGray,
    this.defaultBorderWidth = 3.0,
    this.clickedBorderWidth = 0.0,
    this.borderRadius = 13,
    this.animationDuration = const Duration(milliseconds: 300),
    this.textStyle,
    this.onItemSelected,
    this.width,
  });

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  bool isExpanded = false;
  String? selectedItem;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  TextStyle get _defaultTextStyle =>
      widget.textStyle ??
      const TextStyle(
        fontFamily: "calibri",
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: darkGray,
        decoration: TextDecoration.none,
      );

  void toggleDropdown() {
    if (isExpanded) {
      removeOverlay();
    } else {
      showOverlay();
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    // Get size of the header widget.
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 2,
            child: Container(

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.borderColor.withOpacity(0.25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                        isExpanded = false;
                      });
                      widget.onItemSelected?.call(item);
                      removeOverlay();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: _defaultTextStyle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: AnimatedContainer(
          width: widget.width,
          duration: widget.animationDuration,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border(
              bottom: BorderSide(
                color: widget.borderColor.withOpacity(0.25),
                width: isExpanded
                    ? widget.clickedBorderWidth
                    : widget.defaultBorderWidth,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedItem ?? widget.title,
                style: _defaultTextStyle,
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: widget.animationDuration,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
