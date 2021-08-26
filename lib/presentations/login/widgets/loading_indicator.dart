import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: SpinKitRipple(
          color: Colors.blue[600],
          size: 60,
        ),
      );
}
