import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_event.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_state.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_status.dart';

@RoutePage()
class UiMessagePages extends StatefulWidget {
  final ContactEntity contact;

  const UiMessagePages({super.key, required this.contact});

  @override
  State<UiMessagePages> createState() => _UiMessagePagesState();
}

class _UiMessagePagesState extends State<UiMessagePages> {
  // ignore: unused_field
  final ColorsU _colorsU = GetIt.instance();
  final Logger _logger = Logger();
  final AppLocalization _appLocalizations = GetIt.instance();
  final UIMessageBloc _uIMessageBloc = GetIt.instance();
  late final AppLifecycleListener _listener;
  String _status = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _calculateStatus();
    _startPeriodicRequest();
    _uIMessageBloc.add(UIMessageEventBlocConnect());
    _listener = AppLifecycleListener(onStateChange: _onStateChanged);
  }

  void _startPeriodicRequest() {
    _timer = Timer.periodic(const Duration(minutes: 28), (timer) {
      _logger.i("start consult status contact");
      _uIMessageBloc.add(UIMessageEventBlocConnect());
    });
  }

  void _calculateStatus() {
    final contact = widget.contact;
    final localization = _appLocalizations.localization;
    final timeNow = DateTime.now().millisecondsSinceEpoch;
    final lastOnline = contact.lastOnline ?? 0;
    final duration = Duration(milliseconds: timeNow - lastOnline);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    String messageStatus = (localization?.messageStatusOnline ?? "");
    if (minutes > 30 || hours > 0) {
      final time = hours > 0 ? "${hours}h" : "${minutes}m";
      messageStatus = localization?.messageStatusSeeWhen(time) ?? "";
    }

    setState(() {
      _status = messageStatus;
    });
  }

  @override
  void dispose() {
    _listener.dispose();
    _timer?.cancel();
    _uIMessageBloc.add(UIMessageEventBlocDisconnect());
    _uIMessageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.i(widget.contact);
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.colorWhite,
      body: Stack(
        children: [
          _buildBody(),
          _buildBloc(),
        ],
      ),
    );
  }

  FutureOr<void> _onStateChanged(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        _uIMessageBloc.add(UIMessageEventBlocConnect());
        _startPeriodicRequest();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _uIMessageBloc.add(UIMessageEventBlocDisconnect());
        _timer?.cancel();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 100,
      titleSpacing: 0,
      backgroundColor: AppColors.colorWhite,
      leading: _buildLeadingRow(),
      title: _buildTitle(),
    );
  }

  Widget _buildLeadingRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: AppColors.colorBlack),
        ),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/flags/ad.png'),
          radius: 18,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contato",
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _status,
          style: const TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(color: AppColors.colorBackgroundMessage),
        ),
        Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInputRow(),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return _buildBoxMessageContact();
        } else if (index % 3 == 0) {
          return _buildBoxDate();
        } else {
          return _buildBoxMessageYour();
        }
      },
    );
  }

  Widget _buildBoxDate() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "03/11/2024",
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildBoxMessageContact() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 50),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("10:53", style: TextStyle(fontSize: 10)),
              SvgPicture.asset(
                "assets/images/icon_check_two.svg",
                color: AppColors.colorBlack,
                width: 20,
                height: 20,
                cacheColorFilter: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoxMessageYour() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 50, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: AppColors.colorMessage,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            // ignore: lines_longer_than_80_chars
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae nisi quis ante gravida aliquam. Nam erat enim, consectetur eu nulla porta, rhoncus dictum dui. Aenean sit amet aliquet enim, ",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("10:53", style: TextStyle(fontSize: 10)),
              SvgPicture.asset(
                "assets/images/icon_check_two.svg",
                color: AppColors.colorBlack,
                width: 20,
                height: 20,
                cacheColorFilter: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputRow() {
    return Row(
      children: [
        Expanded(child: _buildMessageInput()),
        _buildSendButton(),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/icon_smile.svg",
              color: AppColors.colorGray,
              width: 20,
              height: 20,
              cacheColorFilter: true,
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    _appLocalizations.localization?.messageInputHint ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        left: 5,
        bottom: 10,
        top: 10,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.colorPrimary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          "assets/images/icon_send.svg",
          color: AppColors.colorWhite,
          width: 40,
          height: 40,
          cacheColorFilter: true,
        ),
      ),
    );
  }

  Widget _buildBloc() {
    return BlocListener<UIMessageBloc, UIMessageBlocState>(
      bloc: _uIMessageBloc,
      listener: (context, state) {
        if (state.status == UiMessageBlocStatus.connected) {
          _uIMessageBloc.add(UiMessageBlocEventHeIsOnline(
            widget.contact.phone ?? "",
          ));
        } else if (state.status == UiMessageBlocStatus.heIsOnline) {
          setState(() {
            _status =
                (_appLocalizations.localization?.messageStatusOnline ?? "");
          });
        }
      },
      child: BlocBuilder<UIMessageBloc, UIMessageBlocState>(
        bloc: _uIMessageBloc,
        builder: (context, state) {
          _logger.d(state.status);
          return Container();
        },
      ),
    );
  }
}
