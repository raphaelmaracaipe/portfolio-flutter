import 'package:flutter/material.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

class ListViewWidget extends StatelessWidget {
  final List<ResponseContact> contacts;
  final ColorsU colorsU;

  const ListViewWidget({
    required this.contacts,
    required this.colorsU,
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
          return Row(
            children: [
              _viewToImage(),
              Column(
                children: [
                  Text(
                    "a => ${contacts[index].phone}",
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
                    "a => ${contacts[index].phone}",
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
            ],
          );
        },
      ),
    );
  }

  Widget _viewToImage() {
    final String location = "assets/images/flags/bl.png";
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 10,
        right: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          location,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
