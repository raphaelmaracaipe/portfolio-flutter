import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

@RoutePage()
class UiMessagePages extends StatefulWidget {
  final ContactEntity contact;

  const UiMessagePages({super.key, required this.contact});

  @override
  State<UiMessagePages> createState() => _UiMessagePagesState();
}

class _UiMessagePagesState extends State<UiMessagePages> {
  final ColorsU _colorsU = GetIt.instance();
  final Logger _logger = Logger();
  final AppLocalization _appLocalizations = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    _logger.i(widget.contact);
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.colorWhite,
      body: _buildBody(),
    );
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
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.colorBlack,
          ),
        ),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/flags/ad.png'),
          radius: 18,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contato",
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "online",
          style: TextStyle(
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
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/background_image_t.svg',
            color: AppColors.colorGray.withOpacity(0.3),
          ),
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "03/11/2024",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxMessageContact() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 50),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
        left: 10,
        right: 10,
      ),
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
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "10:53",
                style: TextStyle(fontSize: 10),
              ),
              SvgPicture.asset(
                "assets/images/icon_check_two.svg",
                color: AppColors.colorBlack,
                width: 20,
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoxMessageYour() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 50, right: 10),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
        left: 20,
        right: 10,
      ),
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
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae nisi quis ante gravida aliquam. Nam erat enim, consectetur eu nulla porta, rhoncus dictum dui. Aenean sit amet aliquet enim, ",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "10:53",
                style: TextStyle(fontSize: 10),
              ),
              SvgPicture.asset(
                "assets/images/icon_check_two.svg",
                color: AppColors.colorBlack,
                width: 20,
                height: 20,
              )
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
        ),
      ),
    );
  }
}
