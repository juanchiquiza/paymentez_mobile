import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  @override
  ConfigState get initialState =>
      DevModeState("IOS-CO-CLIENT", "AKKqsezFDHtanNv1G0ARyxb8DiYARE");

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    if (event is SetEnvironment) {
      yield* _mapSetEnvironmentToState(event.testMode,
          event.paymentezClientAppCode, event.paymentezClientAppKey);
    }
  }

  Stream<ConfigState> _mapSetEnvironmentToState(String testMode,
      String paymentezClientAppCode, String paymentezClientAppKey) async* {
    switch (testMode.toLowerCase()) {
      case 'prod':
        yield ProdModeState(paymentezClientAppCode, paymentezClientAppKey);
        break;
      case 'qa':
        yield QaModeState(paymentezClientAppCode, paymentezClientAppKey);
        break;
      case 'stg':
        yield StgModeState(paymentezClientAppCode, paymentezClientAppKey);
        break;
      case 'dev':
        yield DevModeState(paymentezClientAppCode, paymentezClientAppKey);
        break;
      default:
        yield DevModeState(paymentezClientAppCode, paymentezClientAppKey);
    }
  }
}
