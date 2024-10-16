import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/permission_not_granted.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_state.dart';

@Injectable()
class UiContactBloc extends Bloc<UiContactBlocEvent, UiContactBlocState> {
  late final ContactRepository _contactRepository;
  final logger = Logger();

  UiContactBloc({
    required ContactRepository contactRepository,
  }) : super(UiContactBlocUnknown()) {
    _contactRepository = contactRepository;

    on<SendContacts>(_onSendContact);
  }

  void _onSendContact(
    SendContacts event,
    Emitter<UiContactBlocState> emitter,
  ) async {
    emitter(UiContactBlocLoading());
    logger.i(
      "Init process to consult contact, total contact to consult ${event.contacts.length}",
    );

    try {
      List<ResponseContact> contacts = await _contactRepository.consult(
        event.contacts,
      );
      logger.i(
        "Finished to consult contact, total contact consulted ${contacts.length}",
      );
      emitter(UiContactBlocSuccess(contacts));
    } on PermissionNotGranted catch (e) {
      logger.e("Permissão negada", error: e);
      emitter(UiContactBlocPermissionNotGranted());
    } on Exception catch (e) {
      logger.e("Ocorreu um erro para consultar contato", error: e);
      emitter(UiContactBlocError());
    }
  }
}
