import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/config/app_router.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_status.dart';

class UiValidCodePages extends StatefulWidget {
  const UiValidCodePages({super.key});

  @override
  State<StatefulWidget> createState() => _UiValidCodePages();
}

class _UiValidCodePages extends State<UiValidCodePages> {
  final AppLocalization _appLocalizations = Modular.get();
  late Timer _timer;

  final UiValidCodeBloc _uiValidCodeBloc = Modular.get();
  final Loading _loading = Modular.get();
  final TextEditingController _inputCodeController = TextEditingController();

  int _secondsRemaining = 60;
  String _hourConverted = "01:00";
  String _textMsgError = "";
  bool _enabledButton = false;

  @override
  Widget build(BuildContext context) {
    _appLocalizations.context = context;

    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop();
        return false;
      },
      child: Scaffold(
        key: const Key("uiValidCodePage"),
        appBar: AppBar(
          title: Text(
            (_appLocalizations.localization?.validCodeTitle ?? ""),
            style: const TextStyle(
              fontFamily: AppFonts.openSans,
            ),
          ),
        ),
        body: Stack(
          children: [
            _body(),
            _blocBuild(),
          ],
        ),
      ),
    );
  }

  Widget _blocBuild() {
    return BlocBuilder<UiValidCodeBloc, UiValidCodeBlocState>(
      bloc: _uiValidCodeBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiValidCodeBlocStatus.loading:
            return _loading.showLoading(_appLocalizations);
          case UiValidCodeBlocStatus.loaded:
            _timer.cancel();
            Modular.to.pushNamed(AppRouter.uIProfile);
            return Container();
          case UiValidCodeBlocStatus.error:
            _checkWhatsMessageError(state.codeError);
            return Container();
          default:
            return Container();
        }
      },
    );
  }

  void _checkWhatsMessageError(HttpErrorEnum error) {
    if (error == HttpErrorEnum.USER_SEND_CODE_INVALID) {
      _textMsgError = _appLocalizations.localization?.validErrorCode ?? "";
    } else {
      _textMsgError = _appLocalizations.localization?.errorGeneral ?? "";
    }
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  (_appLocalizations.localization?.validCodeText ?? ""),
                  style: const TextStyle(
                    color: AppColors.colorGray,
                    fontFamily: AppFonts.openSans,
                  ),
                ),
              ),
              Visibility(
                visible: (_textMsgError.isNotEmpty),
                child: Container(
                  key: const Key("uiValidCodeContainerMsgError"),
                  margin: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Text(
                    _textMsgError,
                    key: const Key("uiValidCodeMsgError"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.openSans,
                      color: AppColors.colorError,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30, left: 30),
                child: TextField(
                  key: const Key("uiValidCodeTextCode"),
                  controller: _inputCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 60,
                    fontFamily: AppFonts.openSans,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '000000',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Visibility(
                  visible: (_hourConverted != "00:00"),
                  child: Text(
                    _hourConverted,
                    style: const TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Visibility(
              visible: (_hourConverted == "00:00" || _hourConverted.isEmpty),
              child: Text(
                _appLocalizations.localization?.validCodeSendAgain ?? "",
                style: const TextStyle(
                  fontFamily: AppFonts.openSans,
                  color: AppColors.colorGray,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 5,
                right: 20,
                left: 20,
                bottom: 20,
              ),
              width: double.infinity,
              child: ElevatedButton(
                key: const Key("uiValidCodeButton"),
                onPressed: _enabledButton ? sendCodeToServer : null,
                child: Text(
                  (_appLocalizations.localization?.validCodeBtnSend ?? ""),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void sendCodeToServer() {
    final String text = _inputCodeController.text;
    if (text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      _uiValidCodeBloc.add(SendCodeToValidationEvent(code: text));
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimerToValidateCode();
    _inputCodeController.addListener(_listenerCodeController);
  }

  @override
  void dispose() {
    super.dispose();
    _uiValidCodeBloc.close();
    _timer.cancel();
    _inputCodeController.removeListener(_listenerCodeController);
  }

  void _listenerCodeController() {
    final String text = _inputCodeController.text;
    setState(() {
      _enabledButton = text.isNotEmpty;
    });
  }

  void _startTimerToValidateCode() {
    const onSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      onSec,
      (timer) {
        setState(() {
          if (_secondsRemaining < 1) {
            _hourConverted = "";
            timer.cancel();
          } else {
            _secondsRemaining--;
          }

          _hourConverted = _convertMillisecondsToMinutesAndSeconds(
            (_secondsRemaining * 1000),
          );
        });
      },
    );
  }

  String _convertMillisecondsToMinutesAndSeconds(int milliseconds) {
    int minutes = (milliseconds ~/ 60000);
    String minutesInString = (minutes >= 10) ? minutes.toString() : '0$minutes';

    int seconds = ((milliseconds % 60000) ~/ 1000);
    String secondsInString = (seconds >= 10) ? seconds.toString() : '0$seconds';

    return '$minutesInString:$secondsInString';
  }
}
