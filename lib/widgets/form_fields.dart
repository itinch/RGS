import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/input_logic.dart';
import 'package:rankgroupassignment/app/palette.dart';
import 'package:rankgroupassignment/app/strings.dart';
import 'package:rankgroupassignment/models/card_utils.dart';
import 'package:rankgroupassignment/models/countries.dart';
import 'package:rankgroupassignment/widgets/custom_text_form_field_widget.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;
  final Function(String) onChanged;

  const NameField({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      hintText: 'Name on the card?',
      labelText: 'Card Holder',
      icon: const Icon(
        Icons.person,
        size: kSpacing42,
        color: colourRankBluePrimary,
      ),
      validator: (String? value) => value!.isEmpty ? Strings.fieldReq : null,
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final Widget? currentBankIcon;

  const NumberField({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
    this.currentBankIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      hintText: 'Number on the card?',
      labelText: 'Account Number',
      icon: currentBankIcon ??
          const Icon(
            Icons.credit_card,
            size: kSpacing42,
            color: colourRankBluePrimary,
          ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberInputFormatter(),
      ],
      validator: CardUtils.validateCardNum,
    );
  }
}

class CVVField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;
  final Function(String) onChanged;

  const CVVField({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      hintText: 'Number behind the card?',
      labelText: 'CVV',
      icon: Image.asset(
        'assets/images/card_cvv.png',
        width: kSpacing42,
        color: colourRankBluePrimary,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      validator: CardUtils.validateCVV,
    );
  }
}

class ExpiryDateField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;
  final Function(String) onChanged;

  const ExpiryDateField({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      hintText: 'MM/YY',
      labelText: 'Expiry Date',
      icon: Image.asset(
        'assets/images/calender.png',
        width: kSpacing42,
        color: colourRankBluePrimary,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardMonthInputFormatter(),
      ],
      validator: CardUtils.validateDate,
    );
  }
}

class IssuingCountryField extends StatelessWidget {
  final String? selectedCountry;
  final Function(String?) onChanged;
  final Function(String?) onSaved;

  const IssuingCountryField({
    super.key,
    this.selectedCountry,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kSpacing16, vertical: kSpacing4),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSpacing8),
          ),
          filled: true,
          labelText: 'Issuing Country',
          isDense: true,
          contentPadding: const EdgeInsets.all(kSpacing8),
        ),
        value: selectedCountry,
        onChanged: (String? newValue) {
          onChanged(newValue);
        },
        onSaved: (String? value) {
          onSaved(value);
        },
        items: countries.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (String? value) => value == null ? Strings.fieldReq : null,
      ),
    );
  }
}
