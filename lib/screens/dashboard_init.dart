import 'package:bytebank_oficial/components/saldo.dart';
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
        child: Saldo(),
      ),
    );
  }
}
