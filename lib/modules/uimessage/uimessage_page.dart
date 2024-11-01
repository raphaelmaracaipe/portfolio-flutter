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
      backgroundColor: _getBackgroundColor(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 100,
      titleSpacing: 0,
      backgroundColor: _getBackgroundColor(context, isAppBar: true),
      leading: _buildLeadingRow(),
      title: _buildTitle(),
    );
  }

  Color _getBackgroundColor(BuildContext context, {bool isAppBar = false}) {
    return _colorsU.checkColorsWhichIsDarkMode(
      context: context,
      light: isAppBar ? AppColors.colorPrimary : AppColors.colorWhite,
      dark: AppColors.colorBlack,
    );
  }

  Widget _buildLeadingRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "online",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(child: _buildMessageList()),
        _buildMessageInputRow(),
      ],
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return const ListTile(title: Text("a"));
      },
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/icon_smile.svg",
                color: AppColors.colorGray,
                width: 30,
                height: 30,
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
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 5, bottom: 10),
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
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
