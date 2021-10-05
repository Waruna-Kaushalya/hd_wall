import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        // backgroundColor: Colors.blueAccent,
        // valueColor: AlwaysStoppedAnimation(Colors.green),
        strokeWidth: 5,
      ),
    );
  }
}

class LinearProgressIndicatorWidgetWidget extends StatelessWidget {
  const LinearProgressIndicatorWidgetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      child: LinearProgressIndicator(
          // backgroundColor: Colors.blueAccent,
          // valueColor: AlwaysStoppedAnimation(Colors.green),
          // minHeight: 5,
          ),
      height: 5,
      width: 100,
    ));
  }
}
