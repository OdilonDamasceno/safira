import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final ValueChanged<int>? onTap;
  final double elevation;

  const CustomBottomNavigationBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.elevation = 12,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
          elevation: widget.elevation,
          color: widget.backgroundColor ??
              _theme.bottomNavigationBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.items
                  .asMap()
                  .map(
                    (key, value) => MapEntry(
                        key,
                        GestureDetector(
                          onTap: () => widget.onTap?.call(key),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _theme.colorScheme.primary,
                                    _theme.colorScheme.secondary
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                        color: widget.backgroundColor ??
                                            _theme.scaffoldBackgroundColor,
                                      ),
                                      child: value.icon,
                                    ),
                                    AnimatedSize(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                        child: Text(
                                          '${value.label}',
                                          style: TextStyle(
                                            color: widget.backgroundColor ??
                                                _theme.scaffoldBackgroundColor,
                                            fontSize: key == widget.currentIndex
                                                ? _theme
                                                    .bottomNavigationBarTheme
                                                    .selectedLabelStyle
                                                    ?.fontSize
                                                : 0,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                  .values
                  .toList(),
            ),
          )),
    );
  }
}
