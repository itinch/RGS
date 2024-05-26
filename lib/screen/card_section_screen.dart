// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/palette.dart';
import 'package:rankgroupassignment/app/strings.dart';
import 'package:rankgroupassignment/models/card_utils.dart';
import 'package:rankgroupassignment/services/card_service.dart';
import 'package:rankgroupassignment/services/shared_preferance_service.dart';
import 'package:rankgroupassignment/widgets/custom_card_listing_widget.dart';
import 'package:rankgroupassignment/widgets/main_card_widget.dart';
import 'package:rankgroupassignment/widgets/form_fields.dart';
import 'package:rankgroupassignment/services/card_form_state.dart';
import 'package:rankgroupassignment/services/banned_countries_service.dart';

class CardSectionScreen extends StatefulWidget {
  const CardSectionScreen({super.key, required this.title});
  final String title;

  @override
  _CardSectionScreenState createState() => _CardSectionScreenState();
}

class _CardSectionScreenState extends State<CardSectionScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final CardService _cardService = CardService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  final BannedCountriesService _bannedCountriesService =
      BannedCountriesService();
  var _autoValidateMode = AutovalidateMode.disabled;
  List<String> _savedDataList = [];
  String? _selectedCountry;
  Widget? _currentBankIcon;

  @override
  void initState() {
    super.initState();
    numberController.addListener(_updateCardType);
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    final cardFormState = Provider.of<CardFormState>(context);
    numberController.text = cardFormState.cardNumber;
    nameController.text = cardFormState.cardHolderName;
    cvvController.text = cardFormState.cvv;
    expiryDateController.text = cardFormState.expiryDate;
    _selectedCountry = cardFormState.issuingCountry;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing16),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: kSpacing20),
              MainCardWidget(
                cardNumber: cardFormState.cardNumber,
                cardHolderName: cardFormState.cardHolderName,
                expiryDate: cardFormState.expiryDate,
                bankIcon: _currentBankIcon,
              ),
              const SizedBox(height: kSpacing4),
              NameField(
                controller: nameController,
                onSaved: (value) {
                  _cardService.paymentCard.name = value;
                },
                onChanged: (value) {
                  cardFormState.updateCardHolderName(value);
                },
              ),
              const SizedBox(height: kSpacing8),
              NumberField(
                controller: numberController,
                currentBankIcon: _currentBankIcon,
                onSaved: (value) {
                  _cardService.paymentCard.number =
                      CardUtils.getCleanedNumber(value!);
                },
                onChanged: (value) {
                  cardFormState.updateCardNumber(value);
                },
              ),
              const SizedBox(height: kSpacing8),
              CVVField(
                controller: cvvController,
                onSaved: (value) {
                  _cardService.paymentCard.cvv = int.parse(value!);
                },
                onChanged: (value) {
                  cardFormState.updateCVV(value);
                },
              ),
              const SizedBox(height: kSpacing8),
              ExpiryDateField(
                controller: expiryDateController,
                onSaved: (value) {
                  List<int> expiryDate = CardUtils.getExpiryDate(value!);
                  _cardService.paymentCard.month = expiryDate[0];
                  _cardService.paymentCard.year = expiryDate[1];
                },
                onChanged: (value) {
                  cardFormState.updateExpiryDate(value);
                },
              ),
              const SizedBox(height: kSpacing20),
              IssuingCountryField(
                selectedCountry: _selectedCountry,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                    cardFormState.updateIssuingCountry(newValue);
                  });
                },
                onSaved: (value) {
                  _cardService.paymentCard.country = value;
                },
              ),
              const SizedBox(height: kSpacing20),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: _getPayButton(),
              ),
              const SizedBox(height: kSpacing32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _savedDataList
                    .map((data) => Padding(
                          padding: const EdgeInsets.only(bottom: kSpacing12),
                          child: CustomCardWidget(data: data),
                        ))
                    .toList(),
              ),
              const SizedBox(height: kSpacing12),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: _getClearButton(),
              ),
              const SizedBox(height: kSpacing12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberController.removeListener(_updateCardType);
    numberController.dispose();
    nameController.dispose();
    cvvController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  void _updateCardType() {
    _cardService.getCardTypeFromNumber(numberController.text);
    setState(() {
      _currentBankIcon = CardUtils.getCardIcon(_cardService.paymentCard.type);
    });
  }

  Future<void> _validateInputs() async {
    final FormState form = _formKey.currentState!;
    final cardFormState = Provider.of<CardFormState>(context, listen: false);
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();

      // Check for banned countries
      if (_bannedCountriesService.bannedCountries.contains(_selectedCountry)) {
        _showInSnackBar('Card cannot be used in the selected country.');
        return;
      }

      String cleanedNumber =
          CardUtils.getCleanedNumber(_cardService.paymentCard.number ?? '');
      if (await _isDuplicateCardNumber(cleanedNumber)) {
        _showInSnackBar('This card number already exists.');
      } else {
        await _saveToLocalStorage();
        await _loadSavedData();
        _showInSnackBar('Payment card is valid and details are saved locally');
        cardFormState.reset();
        numberController.clear();
        nameController.clear();
        cvvController.clear();
        expiryDateController.clear();
      }
    }
  }

  Future<void> _saveToLocalStorage() async {
    String newEntry = '''
    Card Name: ${_cardService.paymentCard.name ?? ''}
    Card Number: ${_cardService.paymentCard.number ?? ''}
    CVV: ${_cardService.paymentCard.cvv ?? 0}
    Expiry Month: ${_cardService.paymentCard.month ?? 0}
    Expiry Year: ${_cardService.paymentCard.year ?? 0}
    Issuing Country: ${_cardService.paymentCard.country ?? ''}
    ''';
    _savedDataList.add(newEntry);
    await _sharedPreferencesService.saveData('savedDataList', _savedDataList);
  }

  Future<void> _loadSavedData() async {
    List<String> savedData =
        await _sharedPreferencesService.getData('savedDataList');
    setState(() {
      _savedDataList = savedData;
    });
  }

  Future<bool> _isDuplicateCardNumber(String cardNumber) async {
    for (String data in _savedDataList) {
      if (data.contains('Card Number: $cardNumber')) {
        return true;
      }
    }
    return false;
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
      ),
    );
  }

  Widget _getPayButton() {
    return ElevatedButton(
      onPressed: _validateInputs,
      style: ElevatedButton.styleFrom(
        shape: kSpaceCorner8(),
      ),
      child: Text(
        Strings.pay.toUpperCase(),
        style: const TextStyle(fontSize: kSpacing16),
      ),
    );
  }

  Widget _getClearButton() {
    return OutlinedButton(
      onPressed: _clearStoredData,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: colourRankRedPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSpacing8),
        ),
      ),
      child: Text(
        Strings.clear.toUpperCase(),
        style: const TextStyle(
          fontSize: kSpacing16,
          color: colourRankRedPrimary,
        ),
      ),
    );
  }

  Future<void> _clearStoredData() async {
    await _sharedPreferencesService.removeData('savedDataList');
    setState(() {
      _savedDataList = [];
    });
    _showInSnackBar('Stored data cleared.');
  }
}
