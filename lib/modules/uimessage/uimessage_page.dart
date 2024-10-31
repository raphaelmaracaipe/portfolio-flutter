import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
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

  @override
  Widget build(BuildContext context) {
    _logger.i(widget.contact);
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
        context: context,
        light: AppColors.colorWhite,
        dark: AppColors.colorBlack,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text("a"),
              );
            },
            itemCount: 20,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'a',
            ),
          ),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leadingWidth: 100,
      titleSpacing: 0,
      backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
        context: context,
        light: AppColors.colorPrimary,
        dark: AppColors.colorBlack,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/flags/ad.png'),
            radius: 18,
          )
        ],
      ),
      title: const Column(
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
