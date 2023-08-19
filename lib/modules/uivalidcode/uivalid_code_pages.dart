import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_status.dart';

class UiValidCodePages extends StatefulWidget {
  final AppLocalization _appLocalization = Modular.get();
  final Bottomsheet _bottomSheet = Modular.get();
  final UiValidCodeBloc _uiValidCodeBloc = Modular.get();
  final Loading _loading = Modular.get();

  UiValidCodePages({super.key});

  @override
  State<StatefulWidget> createState() => _UiValidCodePages();
}

class _UiValidCodePages extends State<UiValidCodePages> {
  late Timer _timer;

  final TextEditingController _inputCodeController = TextEditingController();

  int _secondsRemaining = 60;
  String _hourConverted = "01:00";
  String _textMsgError = "";
  bool _enabledButton = false;

  @override
  Widget build(BuildContext context) {
    widget._appLocalization.context = context;

    return WillPopScope(
      onWillPop: () async {
        widget._bottomSheet.show(
          context: context,
          title: (widget._appLocalization.localization?.generalAttention ?? ""),
          text: (widget._appLocalization.localization?.validCancel ?? ""),
          btnText: (widget._appLocalization.localization?.generalYes ?? ""),
          onBtnClick: _goToAuth,
        );
        return false;
      },
      child: Scaffold(
        key: const Key("uiValidCodePage"),
        appBar: AppBar(
          title: Text(
            (widget._appLocalization.localization?.validCodeTitle ?? ""),
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

  void _goToAuth() {
    widget._uiValidCodeBloc.add(CleanRouteSavedEvent());
  }

  Widget _blocBuild() {
    return BlocBuilder<UiValidCodeBloc, UiValidCodeBlocState>(
      bloc: widget._uiValidCodeBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiValidCodeBlocStatus.cleanRoute:
            Modular.to.pop();
            break;
          case UiValidCodeBlocStatus.loading:
            return widget._loading.showLoading(widget._appLocalization);
          case UiValidCodeBlocStatus.loaded:
            _timer.cancel();
            Modular.to.pushNamed(AppRoute.uIProfile);
            return Container();
          case UiValidCodeBlocStatus.error:
            _checkWhatsMessageError(state.codeError);
            return Container();
          default:
            return Container();
        }
        return Container();
      },
    );
  }

  void _checkWhatsMessageError(HttpErrorEnum error) {
    if (error == HttpErrorEnum.USER_SEND_CODE_INVALID) {
      _textMsgError =
          widget._appLocalization.localization?.validErrorCode ?? "";
    } else {
      _textMsgError = widget._appLocalization.localization?.errorGeneral ?? "";
    }
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildTitle(),
              _buildMsgError(),
              _buildInputCodeToValidation(),
              _buildCountDownTime(),
            ],
          ),
        ),
        Column(
          children: [
            _buildLinkToSendAgain(),
            _buildButtonSendToValidation(),
          ],
        )
      ],
    );
  }

  Container _buildButtonSendToValidation() {
    return Container(
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
          (widget._appLocalization.localization?.validCodeBtnSend ?? ""),
        ),
      ),
    );
  }

  Visibility _buildLinkToSendAgain() {
    return Visibility(
      visible: (_hourConverted == "00:00" || _hourConverted.isEmpty),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _secondsRemaining = 60;
            _startTimerToValidateCode();
          });
        },
        child: Text(
          widget._appLocalization.localization?.validCodeSendAgain ?? "",
          style: const TextStyle(
            fontFamily: AppFonts.openSans,
            color: AppColors.colorGray,
            fontSize: 12,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Container _buildCountDownTime() {
    return Container(
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
    );
  }

  Container _buildInputCodeToValidation() {
    return Container(
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
    );
  }

  Visibility _buildMsgError() {
    return Visibility(
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
    );
  }

  Container _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Text(
        (widget._appLocalization.localization?.validCodeText ?? ""),
        style: const TextStyle(
          color: AppColors.colorGray,
          fontFamily: AppFonts.openSans,
        ),
      ),
    );
  }

  void sendCodeToServer() {
    final String text = _inputCodeController.text;
    if (text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      widget._uiValidCodeBloc.add(SendCodeToValidationEvent(code: text));
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
    widget._uiValidCodeBloc.close();
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
