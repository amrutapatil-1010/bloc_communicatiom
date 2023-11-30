import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants/enum.dart';

part 'internet_cubit_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  //To check the internet is connected or not every time. The variable is used
  StreamSubscription? connectivitySubscription;
//No need to write function to loading,by default it shows InternetLoading state initially
  InternetCubit({
    required this.connectivity,
  }) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        return emitInternetConnected(ConnectionTypes.wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        return emitInternetConnected(ConnectionTypes.mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        return emitInternetDisconnected();
      }
      return emitInternetDisconnected();
    });
  }

  void emitInternetConnected(ConnectionTypes connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivitySubscription!.cancel();
    return super.close();
  }
}
