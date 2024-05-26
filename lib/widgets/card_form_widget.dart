import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/palette.dart';
import 'package:rankgroupassignment/models/card_utils.dart';
import 'package:rankgroupassignment/services/card_service.dart';
import 'package:rankgroupassignment/widgets/form_fields.dart';
import 'package:rankgroupassignment/services/card_form_state.dart';
import 'package:rankgroupassignment/widgets/main_card_widget.dart';

class CardFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final CardService cardService;
  final Function _getPayButton;
  final Function _getClearButton;

  const CardFormWidget({
    super.key,
    required this.formKey,
    required this.cardService,
    required Function getPayButton,
    required Function getClearButton,
  })  : _getPayButton = getPayButton,
        _getClearButton = getClearButton;

  @override
  Widget build(BuildContext context) {
    final cardFormState = Provider.of<CardFormState>(context);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: kSpacing20),
          MainCardWidget(
            cardNumber: cardFormState.cardNumber,
            cardHolderName: cardFormState.cardHolderName,
            expiryDate: cardFormState.expiryDate,
            bankIcon: cardService.paymentCard.type != null
                ? CardUtils.getCardIcon(cardService.paymentCard.type)
                : null,
          ),
          const SizedBox(height: kSpacing20),
          NameField(
            controller: cardFormState.nameController,
            onSaved: (value) {
              cardService.paymentCard.name = value;
            },
            onChanged: (value) {
              cardFormState.updateCardHolderName(value);
            },
          ),
          const SizedBox(height: kSpacing32),
          NumberField(
            controller: cardFormState.numberController,
            currentBankIcon:
                CardUtils.getCardIcon(cardService.paymentCard.type),
            onSaved: (value) {
              cardService.paymentCard.number =
                  CardUtils.getCleanedNumber(value!);
            },
            onChanged: (value) {
              cardFormState.updateCardNumber(value);
            },
          ),
          const SizedBox(height: kSpacing32),
          CVVField(
            controller: cardFormState.cvvController,
            onSaved: (value) {
              cardService.paymentCard.cvv = int.parse(value!);
            },
            onChanged: (value) {
              cardFormState.updateCVV(value);
            },
          ),
          const SizedBox(height: kSpacing32),
          ExpiryDateField(
            controller: cardFormState.expiryDateController,
            onSaved: (value) {
              List<int> expiryDate = CardUtils.getExpiryDate(value!);
              cardService.paymentCard.month = expiryDate[0];
              cardService.paymentCard.year = expiryDate[1];
            },
            onChanged: (value) {
              cardFormState.updateExpiryDate(value);
            },
          ),
          const SizedBox(height: kSpacing32),
          IssuingCountryField(
            selectedCountry: cardFormState.issuingCountry,
            onChanged: (newValue) {
              cardFormState.updateIssuingCountry(newValue);
            },
            onSaved: (value) {
              cardService.paymentCard.country = value;
            },
          ),
          const SizedBox(height: kSpacing60),
          Container(
            alignment: Alignment.center,
            child: _getPayButton(),
          ),
          const SizedBox(height: kSpacing32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cardFormState.savedDataList
                .map((data) => Padding(
                      padding: const EdgeInsets.only(bottom: kSpacing12),
                      child: Text(
                        data,
                        style: const TextStyle(
                            fontSize: kSpacing16, color: colourBlack),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: kSpacing12),
          _getClearButton(),
          const SizedBox(height: kSpacing12),
        ],
      ),
    );
  }
}
