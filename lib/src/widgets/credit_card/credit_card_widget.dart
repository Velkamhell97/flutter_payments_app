import 'package:flutter/material.dart';
import 'dart:math';

class CreditCardWidget extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;
  final bool clickable;

  const CreditCardWidget({Key? key, required this.frontWidget, required this.backWidget, this.clickable = true}) : super(key: key);

  @override
  State<CreditCardWidget> createState() => CreditCardWidgetState();
}

class CreditCardWidgetState extends State<CreditCardWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool showFront = true;

  void flip() {
    if(_controller.isAnimating) return;

    if(_controller.isCompleted){
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clickable ? flip : null,
      child: AnimatedBuilder(
        animation: _controller, 
        builder: (_, __) {
          final firstHalf = _controller.value < 0.5;
          final animation = firstHalf ? _controller.value : 1.0 - _controller.value;

          //-Forma 1 aprovechando el tilt de diferente manera (muy parecido)
          // final child = firstHalf ? const _Widget1() : _widget2 ;
          // final rotation = -pi * _controller.value;

          // -Forma 2 con un valor de animacion que llega hasta 0.5 y vuelve
          final child = firstHalf ? widget.frontWidget : widget.backWidget;
          final rotation = pi * animation;
          final tilt = firstHalf ? animation * -0.003 : animation * 0.003;
    
          return Transform(
            // -Para este caso se llega en x hasta 90 grados y despues se devuelve, el tilt inicia negativo
            // -y luego se devuelve positivo para dar efeto de la perspectiva
            transform: Matrix4.rotationX(rotation)..setEntry(3, 1, tilt),
            // transform: Matrix4.identity()..setEntry(3, 2, 0.0012)..rotateX(rotation),
            alignment: Alignment.center,
            child: child,
          );
        }
      ),
    );
  }
}

