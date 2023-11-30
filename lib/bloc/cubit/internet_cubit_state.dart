part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionTypes connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
