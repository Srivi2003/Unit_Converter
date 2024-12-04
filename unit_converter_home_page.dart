import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitConverterHomePage extends StatefulWidget {
  @override
  _UnitConverterHomePageState createState() => _UnitConverterHomePageState();
}

class _UnitConverterHomePageState extends State<UnitConverterHomePage> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedConversion = 'Kilometers to Miles';
  double _result = 0.0;

  final Map<String, double Function(double)> _conversions = {
    'Kilometers to Miles': (value) => value * 0.621371,
    'Miles to Kilometers': (value) => value / 0.621371,
    'Kilograms to Pounds': (value) => value * 2.20462,
    'Pounds to Kilograms': (value) => value / 2.20462,
  };

  void _convert() {
    final inputValue = double.tryParse(_inputController.text);
    if (inputValue != null) {
      setState(() {
        _result = _conversions[_selectedConversion]!(inputValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Enter value',
                icon: Icon(Icons.input),
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedConversion,
              items: _conversions.keys
                  .map((conversion) => DropdownMenuItem(
                        value: conversion,
                        child: Text(conversion),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select conversion',
                icon: Icon(Icons.swap_horiz),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result == 0.0
                  ? 'Enter value and select conversion'
                  : 'Result: $_result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
