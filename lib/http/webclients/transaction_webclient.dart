import 'dart:convert';

import 'package:bytebank_oficial/http/webclient.dart';
import 'package:bytebank_oficial/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final http.Response response = await client
        .get(Uri.parse(baseURL))
        .timeout(const Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final http.Response response = await client.post(
      Uri.parse(baseURL),
      headers: {"Content-type": "application/json", "password": "1000"},
      body: transactionJson,
    );

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
