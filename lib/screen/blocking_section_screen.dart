// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/models/countries.dart';
import 'package:rankgroupassignment/services/banned_countries_service.dart';

class BlockingSectionScreen extends StatefulWidget {
  final String title;

  const BlockingSectionScreen({super.key, required this.title});

  @override
  _BlockingSectionScreenState createState() => _BlockingSectionScreenState();
}

class _BlockingSectionScreenState extends State<BlockingSectionScreen> {
  final BannedCountriesService _bannedCountriesService =
      BannedCountriesService();
  String? _countryToAddOrRemove;
  List<String> _bannedCountries = [];

  @override
  void initState() {
    super.initState();
    _loadBannedCountries();
  }

  Future<void> _loadBannedCountries() async {
    await _bannedCountriesService.loadBannedCountries();
    setState(() {
      _bannedCountries = _bannedCountriesService.bannedCountries;
    });
  }

  void _addCountryToBannedList() {
    if (_countryToAddOrRemove != null) {
      _bannedCountriesService.addCountry(_countryToAddOrRemove!);
      setState(() {
        _countryToAddOrRemove = null;
        _loadBannedCountries();
      });
      _showInSnackBar('Country added to banned list.');
    } else {
      _showInSnackBar('Country is already in the banned list or not selected.');
    }
  }

  void _removeCountryFromBannedList() {
    if (_countryToAddOrRemove != null) {
      _bannedCountriesService.removeCountry(_countryToAddOrRemove!);
      setState(() {
        _countryToAddOrRemove = null;
        _loadBannedCountries();
      });
      _showInSnackBar('Country removed from banned list.');
    } else {
      _showInSnackBar('Country is not in the banned list or not selected.');
    }
  }

  void _showBannedCountries() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Banned Countries'),
          content: SingleChildScrollView(
            child: ListBody(
              children:
                  _bannedCountries.map((country) => Text(country)).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kSpacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kSpacing8),
                  ),
                  filled: true,
                  labelText: 'Select Country',
                  isDense: true,
                  contentPadding: const EdgeInsets.all(kSpacing8),
                ),
                value: _countryToAddOrRemove,
                onChanged: (String? newValue) {
                  setState(() {
                    _countryToAddOrRemove = newValue;
                  });
                },
                items: countries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: kSpacing20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addCountryToBannedList,
                  style: ElevatedButton.styleFrom(
                    shape: kSpaceCorner8(),
                  ),
                  child: const Text(
                    'Add Country',
                    style: TextStyle(fontSize: kSpacing16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _removeCountryFromBannedList,
                  style: ElevatedButton.styleFrom(
                    shape: kSpaceCorner8(),
                  ),
                  child: const Text(
                    'Remove Country',
                    style: TextStyle(fontSize: kSpacing16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacing20),
            ElevatedButton(
              onPressed: _showBannedCountries,
              style: ElevatedButton.styleFrom(
                shape: kSpaceCorner8(),
              ),
              child: const Text(
                'Show Banned Countries',
                style: TextStyle(fontSize: kSpacing16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
