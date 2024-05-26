import 'package:rankgroupassignment/models/card_type.dart';

class PaymentCard {
  CardType? type;
  String? number;
  String? name;
  String? country;
  int? month;
  int? year;
  int? cvv;

  PaymentCard({
    this.type,
    this.number,
    this.name,
    this.country,
    this.month,
    this.year,
    this.cvv,
  });

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }
}
