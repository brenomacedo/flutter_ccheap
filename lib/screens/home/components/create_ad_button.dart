import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CreateAdButton extends StatefulWidget {

  CreateAdButton(this.scrollController);

  final ScrollController scrollController;

  @override
  _CreateAdButtonState createState() => _CreateAdButtonState();
}

class _CreateAdButtonState extends State<CreateAdButton> with SingleTickerProviderStateMixin{


  AnimationController controller;
  Animation<double> buttonAnimation;

  void scrollChanged() {
    final s = widget.scrollController.position;
    if(s.userScrollDirection == ScrollDirection.forward) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
    );

    buttonAnimation = Tween<double>(begin: 0.0, end: 66.0)
      .animate(CurvedAnimation(parent: controller, curve: Interval(
        0.4, 0.6
      )));

    widget.scrollController.addListener(scrollChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (_, __) {
        return FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(bottom: buttonAnimation.value),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty
                  .all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))
              ),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  Text('Anunciar agora',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ))
                ],
              ),
              onPressed: () {
                GetIt.I<PageStore>().setPage(1);
              },
            ),
          ),
        );
      },
    );
  }
}