import 'package:bytebank_oficial/models/saldo.dart';
import 'package:bytebank_oficial/screens/dashboard/saldo.dart';
import 'package:flutter/material.dart';

class DashboardInit extends StatelessWidget {
  const DashboardInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bytebank'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SaldoCard(
          saldo: Saldo(15.00),
        ),
      ),
    );
  }
}
