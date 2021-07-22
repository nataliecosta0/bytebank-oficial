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

  Future<Transaction?> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 10));

    final http.Response response = await client
        .post(
          Uri.parse(baseURL),
          headers: {"Content-type": "application/json", "password": password},
          body: transactionJson,
        )
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String? _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return "Unknown error";
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "there was an error submitting transaction",
    401: "authentication failed",
    409: "transaction already exists",
  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
