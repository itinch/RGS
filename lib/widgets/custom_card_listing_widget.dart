import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/palette.dart';

class CustomCardWidget extends StatelessWidget {
  final String data;

  const CustomCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacing12),
      child: Card(
        color: colourRankBluePrimary.withOpacity(0.8),
        shape: kSpaceCorner8(),
        child: Padding(
          padding: const EdgeInsets.all(kSpacing8),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: kSpacing16,
                  color: colourWhite,
                ),
                children: _parseData(data),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _parseData(String data) {
    final parts = data.split('\n');
    final spans = <TextSpan>[];
    for (var part in parts) {
      final keyValue = part.split(': ');
      if (keyValue.length == 2) {
        spans.add(TextSpan(
          text: '${keyValue[0]}: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
        spans.add(TextSpan(text: keyValue[1]));
        spans.add(const TextSpan(text: '\n'));
      } else {
        spans.add(TextSpan(text: part));
        spans.add(const TextSpan(text: '\n'));
      }
    }
    return spans;
  }
}
