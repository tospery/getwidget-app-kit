import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter/cupertino.dart';

class FabFloatingWidget extends StatefulWidget {
  @override
  _FabFloatingWidgetState createState() => _FabFloatingWidgetState();
}

class _FabFloatingWidgetState extends State<FabFloatingWidget>
    with TickerProviderStateMixin {
  TextEditingController controller1 = TextEditingController();
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    offset =
        Tween<Offset>(begin: const Offset(0, -0.04), end: const Offset(0, 0.2))
            .animate(controller);
    animation = Tween(begin: 1, end: 0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastLinearToSlowEaseIn));
  }

  AnimationController controller;
  Animation<Offset> offset, offset1;

  bool showfabFloatingWidget = false;

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GFFloatingWidget(
          verticalPosition: MediaQuery.of(context).size.height * 0.4,
          horizontalPosition: MediaQuery.of(context).size.width * 0.444,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: GFIconButton(
                icon:
                    showfabFloatingWidget ? Icon(Icons.close) : Icon(Icons.add),
                shape: GFIconButtonShape.circle,
                color: GFColors.PRIMARY,
                size: 100,
                onPressed: () {
                  setState(() {
                    showfabFloatingWidget = !showfabFloatingWidget;
                  });
                  switch (controller.status) {
                    case AnimationStatus.completed:
                      controller.forward(from: 1);
                      break;

                    case AnimationStatus.dismissed:
                      controller.reverse(from: 1);
                      break;
                    default:
                  }
                }),
          ),
          body: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 40),
                child: GFTypography(
                  text: 'FAB Button as a Floating Widget',
                  type: GFTypographyType.typo5,
                  dividerWidth: 25,
                  dividerColor: Color(0xFF19CA4B),
                ),
              ),
              showfabFloatingWidget
                  ? SlideTransition(
                      position: offset,
                      child: Column(
                        children: <Widget>[
                          GFButtonBar(
                            direction: Axis.vertical,
                            children: <Widget>[
                              GFIconButton(
                                  icon: Icon(Icons.add),
                                  shape: GFIconButtonShape.circle,
                                  color: GFColors.INFO,
                                  onPressed: () {}),
                              GFIconButton(
                                  icon: Icon(Icons.share),
                                  shape: GFIconButtonShape.circle,
                                  color: GFColors.SUCCESS,
                                  onPressed: () {}),
                              GFIconButton(
                                  icon: Icon(Icons.message),
                                  shape: GFIconButtonShape.circle,
                                  color: GFColors.WARNING,
                                  onPressed: () {}),
                              GFIconButton(
                                  icon: Icon(Icons.settings),
                                  shape: GFIconButtonShape.circle,
                                  color: GFColors.SECONDARY,
                                  onPressed: () {}),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
}