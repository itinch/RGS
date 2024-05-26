import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/palette.dart';

class MainCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final Widget? bankIcon;

  const MainCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.bankIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.symmetric(
          horizontal: kSpacing20, vertical: kSpacing20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacing16),
        gradient: const LinearGradient(
          colors: [colourRankBluePrimary, colourRankBlackOffPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kSpacing12),
        child: Stack(
          children: [
            if (bankIcon != null)
              Align(
                alignment: Alignment.topRight,
                child: bankIcon!,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Credit Card',
                  style: TextStyle(
                    color: colourWhite,
                    fontSize: kSpacing12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kSpacing60),
                Center(
                  child: Text(
                    cardNumber,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: colourWhite,
                      fontSize: kSpacing20,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Card Holder',
                          style: TextStyle(
                              color: colourWhite, fontSize: kSpacing12),
                        ),
                        const SizedBox(height: kSpacing4),
                        Text(
                          cardHolderName,
                          style: const TextStyle(
                            color: colourWhite,
                            fontSize: kSpacing12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry Date',
                          style: TextStyle(
                            color: colourWhite,
                            fontSize: kSpacing12,
                          ),
                        ),
                        const SizedBox(height: kSpacing4),
                        Text(
                          expiryDate,
                          style: const TextStyle(
                            color: colourWhite,
                            fontSize: kSpacing12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
