import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_event.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_state.dart';

@Injectable()
class UIMessageBloc extends Bloc<UiMessageBlocEvent, UIMessageBlocState> {
  late final ContactRepository _contactRepository;
  final Logger logger = Logger();

  UIMessageBloc({
    required ContactRepository contactRepository,
  }) : super(const UIMessageBlocEventUnknown()) {
    _contactRepository = contactRepository;

    on<UiMessageBlocEventHeIsOnline>(_onUiMessageBlocEventHeIsOnline);
    on<UIMessageEventBlocConnect>(_onConnect);
    on<UIMessageEventBlocDisconnect>(_onDisconnect);
  }

  FutureOr<void> _onUiMessageBlocEventHeIsOnline(
    UiMessageBlocEventHeIsOnline event,
    Emitter<UIMessageBlocState> emitter,
  ) async {
    // // TODO: APENAS PARA TESTE REMOVER DEPOIS
    _contactRepository.onIAmOnline(
      phoneNumber: event.phone,
    );

    _contactRepository.checkStatus(phoneNumber: event.phone);
    await _contactRepository.onIsHeOnline(
      phoneNumber: event.phone,
      callback: () => {
        emitter(const UIMessageBlocEventHeIsOnline()),
      },
    );
  }

  FutureOr<void> _onConnect(
    UIMessageEventBlocConnect event,
    Emitter<UIMessageBlocState> emitter,
  ) async {
    await _contactRepository.connect();
    emitter(const UIMessageBlocEventConnected());
  }

  Future<void> _onDisconnect(
    UIMessageEventBlocDisconnect event,
    Emitter<UIMessageBlocState> emitter,
  ) async {
    _contactRepository.disconnect();
    emitter(const UIMessageBlocEventDisconnected());
  }
}
