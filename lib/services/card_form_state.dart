import 'package:flutter/material.dart';

class CardFormState with ChangeNotifier {
  String _cardNumber = '';
  String _cardHolderName = '';
  String _cvv = '';
  String _expiryDate = '';
  String? _issuingCountry;
  List<String> _savedDataList = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  String get cardNumber => _cardNumber;
  String get cardHolderName => _cardHolderName;
  String get cvv => _cvv;
  String get expiryDate => _expiryDate;
  String? get issuingCountry => _issuingCountry;
  List<String> get savedDataList => _savedDataList;

  TextEditingController get nameController => _nameController;
  TextEditingController get numberController => _numberController;
  TextEditingController get cvvController => _cvvController;
  TextEditingController get expiryDateController => _expiryDateController;

  void updateCardNumber(String number) {
    _cardNumber = number;
    notifyListeners();
  }

  void updateCardHolderName(String name) {
    _cardHolderName = name;
    notifyListeners();
  }

  void updateCVV(String cvv) {
    _cvv = cvv;
    notifyListeners();
  }

  void updateExpiryDate(String expiryDate) {
    _expiryDate = expiryDate;
    notifyListeners();
  }

  void updateIssuingCountry(String? country) {
    _issuingCountry = country;
    notifyListeners();
  }

  void setSavedDataList(List<String> data) {
    _savedDataList = data;
    notifyListeners();
  }

  void reset() {
    _cardNumber = '';
    _cardHolderName = '';
    _cvv = '';
    _expiryDate = '';
    _issuingCountry = null;
    _nameController.clear();
    _numberController.clear();
    _cvvController.clear();
    _expiryDateController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }
}
