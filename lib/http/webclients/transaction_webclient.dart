import 'dart:convert';

import 'package:bytebank_oficial/http/webclient.dart';
import 'package:bytebank_oficial/models/contact.dart';
import 'package:bytebank_oficial/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final http.Response response = await client
        .get(Uri.parse(baseURL))
        .timeout(const Duration(seconds: 5));

    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);
    final http.Response response = await client.post(
      Uri.parse(baseURL),
      headers: {"Content-type": "application/json", "password": "1000"},
      body: transactionJson,
    );

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(http.Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Transaction _toTransaction(http.Response response) {
     Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }
}
