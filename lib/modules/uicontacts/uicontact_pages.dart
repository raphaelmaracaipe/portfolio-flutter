import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_status.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/search_widget.dart';

@RoutePage()
class UiContactPages extends StatefulWidget {
  const UiContactPages({super.key});

  @override
  State<StatefulWidget> createState() => _UiContactPages();
}

class _UiContactPages extends State<UiContactPages> {
  final ColorsU _colorsU = GetIt.instance();
  final AppLocalization _appLocalizations = GetIt.instance();
  final UiContactBloc _uiContactBloc = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
        context: context,
        light: AppColors.colorWhite,
        dark: AppColors.colorBlack,
      ),
      body: Stack(children: [
        _body(),
      ]),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
        ),
        child: _buildBloc(),
      ),
    );
  }

  Widget _buildBloc() {
    _uiContactBloc.add(SendContacts(contacts: []));
    return BlocBuilder<UiContactBloc, UiContactBlocState>(
      bloc: _uiContactBloc,
      builder: (
        context,
        state,
      ) {
        if(state.status == UiContactBlocStatus.permissionNotGranted) {
          _buildViewToPermissionNotGranted(context: context);
          return Container();
        }

        return _buildListViewAndSearchView(state.contacts);
      },
    );
  }

  Widget _buildListViewAndSearchView(List<ContactEntity> contacts) {
    return Column(
      children: [
        SearchWidget(
          appLocalization: _appLocalizations,
          contacts: contacts,
          colorsU: _colorsU,
        ),
        Expanded(
          child: ListViewWidget(
            contacts: contacts,
            colorsU: _colorsU,
          ),
        )
      ],
    );
  }

  void _buildViewToPermissionNotGranted({required BuildContext context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _appLocalizations.localization?.contactPermissionNotGrant ?? "",
          ),
        ),
      );
    });
  }
}
