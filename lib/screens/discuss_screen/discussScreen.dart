import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DiscussScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: true,
      progressIndicator: loadingIndicator,
      child: Text('Discussion Screen'),
    );
  }
}
