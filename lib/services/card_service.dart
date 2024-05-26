import 'package:rankgroupassignment/app/strings.dart';
import 'package:rankgroupassignment/models/card_model.dart';
import 'package:rankgroupassignment/models/card_type.dart';
import 'package:rankgroupassignment/models/card_utils.dart';

class CardService {
  final PaymentCard _paymentCard = PaymentCard();

  PaymentCard get paymentCard => _paymentCard;

  void getCardTypeFromNumber(String cardNumber) {
    String input = CardUtils.getCleanedNumber(cardNumber);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    _paymentCard.type = cardType;
  }

  String? validateCardNumber(String? value) {
    return CardUtils.validateCardNum(value);
  }

  String? validateCardName(String? value) {
    return value!.isEmpty ? Strings.fieldReq : null;
  }

  String? validateCVV(String? value) {
    return CardUtils.validateCVV(value);
  }

  String? validateExpiryDate(String? value) {
    return CardUtils.validateDate(value);
  }

  void saveCardDetails(String name, String number, String cvv,
      String expiryDate, String country) {
    _paymentCard.name = name;
    _paymentCard.number = CardUtils.getCleanedNumber(number);
    _paymentCard.cvv = int.parse(cvv);
    List<int> expiry = CardUtils.getExpiryDate(expiryDate);
    _paymentCard.month = expiry[0];
    _paymentCard.year = expiry[1];
    _paymentCard.country = country;
  }
}
