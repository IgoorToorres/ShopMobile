import 'package:flutter/material.dart';

class BadgeDefault extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const BadgeDefault({
    super.key,
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return int.tryParse(value) == null || int.parse(value) <= 0
        ? child
        : Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned(
                right: 2,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color ?? Colors.red,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
