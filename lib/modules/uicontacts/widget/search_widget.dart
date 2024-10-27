import 'package:flutter/material.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/listview_widget.dart';

class SearchWidget extends StatefulWidget {
  final AppLocalization appLocalization;
  final List<ContactEntity> contacts;
  final ColorsU colorsU;

  const SearchWidget({
    required this.appLocalization,
    required this.contacts,
    required this.colorsU,
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      viewBackgroundColor: Colors.white,
      barHintText: widget.appLocalization.localization?.contactTitleSarch ?? "",
      barBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.colorSearch.withOpacity(0.8);
          }
          return AppColors.colorSearch;
        },
      ),
      barElevation: WidgetStateProperty.resolveWith<double>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return 4.0;
          }
          return 0.0;
        },
      ),
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) {
        return List<Widget>.generate(
          1,
          (int index) => _buildItemListSearch(index, widget.colorsU),
        );
      },
    );
  }

  Widget _buildItemListSearch(int index, ColorsU colorsU) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: 20,
              left: 20,
            ),
            child: ListViewWidget(
              contacts: widget.contacts,
              colorsU: colorsU,
            ),
          )
        ],
      ),
    );
  }
}
