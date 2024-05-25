import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityCheckerView extends StatefulWidget {
  const ConnectivityCheckerView({super.key});

  @override
  State<ConnectivityCheckerView> createState() => _ConnectivityCheckerViewState();
}

class _ConnectivityCheckerViewState extends State<ConnectivityCheckerView> {

  late StreamSubscription internetStream;
  late int isConnected;


  @override
  void initState() {
    super.initState();
    isConnected = 0;
    internetStream = Connectivity().onConnectivityChanged.listen(checkConnectivity);
  }

  @override
  void dispose() {
    internetStream.cancel();
    super.dispose();
  }


  void checkConnectivity(List<ConnectivityResult> connectivity){
    switch(connectivity){
      case [ConnectivityResult.wifi]:
        setState(() {
          isConnected = 1;
        });
        break;

      case [ConnectivityResult.mobile]:
        setState(() {
          isConnected = 2;
        });
        break;

      default:
        setState(() {
          isConnected = 0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isConnected==1 ? Icons.wifi : isConnected == 2
                               ? Icons.switch_right : Icons.close,
                color: isConnected==0 ? Colors.red : Colors.green,
              ),
              Text(isConnected==1 ? "Connected to WIFI" : isConnected == 2
                  ? "Connected to MOBILE" : "No Internet Access",)
            ],
          ),
        ),
      ),
    );
  }
}
