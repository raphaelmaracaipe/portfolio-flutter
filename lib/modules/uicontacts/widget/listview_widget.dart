// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

class ListViewWidget extends StatelessWidget {
  final Base64Decoder _base64decoder = const Base64Decoder();
  final List<ContactEntity> contacts;
  final ContactRepository contactRepository;
  final ColorsU colorsU;

  const ListViewWidget({
    required this.contacts,
    required this.colorsU,
    required this.contactRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('listViewWidgetUiContanct'),
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _buildItemListView(index, context);
        },
      ),
    );
  }

  Widget _buildItemListView(int index, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final contact = await contactRepository.getContactByPhone(
          (contacts[index].phone ?? ""),
        );

        AutoRouter.of(context).push(
          UiMessageRoutes(contact: contact),
        );
      },
      child: Row(
        children: [
          _viewToImage(contacts[index]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _showNameOrPhone(contacts[index]),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorsU.checkColorsWhichIsDarkMode(
                      context: context,
                      light: AppColors.colorGray,
                      dark: AppColors.colorWhite,
                    ),
                  ),
                ),
                Text(
                  (contacts[index].reminder ?? ""),
                  style: TextStyle(
                    color: colorsU.checkColorsWhichIsDarkMode(
                      context: context,
                      light: AppColors.colorGray,
                      dark: AppColors.colorWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _showNameOrPhone(ContactEntity contact) {
    if (contact.name != null) {
      return contact.name ?? "";
    }
    return contact.phone ?? "";
  }

  Widget _viewToImage(ContactEntity contact) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 10,
        right: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: _checkImageOfProfile(contact),
      ),
    );
  }

  Widget _checkImageOfProfile(ContactEntity contact) {
    if (contact.photo == null || contact.photo!.isEmpty) {
      return SvgPicture.asset(
        "assets/images/icon_profile.svg",
        color: AppColors.colorGray,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      );
    }

    return Image.memory(
      _base64decoder.convert(contact.photo ?? ""),
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    );
  }
}
