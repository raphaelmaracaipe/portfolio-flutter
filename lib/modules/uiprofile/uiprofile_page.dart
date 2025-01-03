import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/utils/files.dart';
import 'package:portfolio_flutter/modules/core/utils/images.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_state.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_status.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

@RoutePage()
class UiProfilePage extends StatefulWidget {
  const UiProfilePage({super.key});

  @override
  State<UiProfilePage> createState() => _UiProfilePageState();
}

class _UiProfilePageState extends State<UiProfilePage> {
  Image? _imageProfile;
  bool _profileObtain = false;
  RequestProfile _requestProfile = RequestProfile(name: "", photo: "");
  List<Map<String, String>> items = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ColorsU _colorsU = GetIt.instance();
  final Loading _loading = GetIt.instance();
  final Images _images = GetIt.instance();
  final UiProfileBloc _uiProfileBloc = GetIt.instance();
  final AppLocalization _appLocalizations = GetIt.instance();
  final Files _files = GetIt.instance();
  final Bottomsheet _bottomSheetToChooseTypeCapture = GetIt.instance();
  final Bottomsheet _bottomSheetAlertWhenDataOfProfile = GetIt.instance();
  final Bottomsheet _bottomSheetError = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    _loadingItemsToChooseTheCapture();
    _requestProfileSaved();
    return Stack(
      key: const Key("uiProfileContainer"),
      children: [
        _scaffod(),
        _buildBloc(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _uiProfileBloc.close();
  }

  _buildBloc() {
    return BlocBuilder<UiProfileBloc, UiProfileBlocState>(
      bloc: _uiProfileBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiProfileBlocStatus.error:
            _showMessageErrorOfRequest();
            return Container(key: const Key('UiProfilePageMessageError'));
          case UiProfileBlocStatus.updateWithSuccess:
            context.router.popAndPush(const UiContactRoutes());
            return Container();
          case UiProfileBlocStatus.loading:
            return _loading.showLoading(_appLocalizations, _colorsU);
          case UiProfileBlocStatus.profileSaved:
            _takeCareImageRescued(state);
            return Container();
          default:
            return Container();
        }
      },
    );
  }

  FutureOr<void> _takeCareImageRescued(UiProfileBlocState state) {
    if (!_profileObtain) {
      _profileObtain = true;
      final profile = state.responseProfile;

      _requestProfile.name = profile?.name ?? "";
      _requestProfile.photo = profile?.photo ?? "";
      _requestProfile.reminder = profile?.reminder ?? "";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _nameController.text = profile?.name ?? "";
          _reminderController.text = profile?.reminder ?? "";
          _imageProfile = _images.convertBase64ToImage(
            (profile?.photo ?? ""),
          );
        });
      });
    }
  }

  FutureOr<void> _showMessageErrorOfRequest() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _bottomSheetError.show(
        context: context,
        title: _appLocalizations.localization?.generalAttention ?? "",
        text: _appLocalizations.localization?.errorGeneral ?? "",
        btnText: _appLocalizations.localization?.generalOk ?? "",
        onBtnClick: () {},
      );
    });
  }

  Scaffold _scaffod() {
    return Scaffold(
      backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
        context: context,
        light: AppColors.colorWhite,
        dark: AppColors.colorBlack,
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
          context: context,
          light: AppColors.colorPrimary,
          dark: AppColors.colorBlack,
        ),
        title: Text(
          _appLocalizations.localization?.profileTitle ?? "",
          style: const TextStyle(
            color: AppColors.colorWhite,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _widgetOfImage(),
            _widgetOfInputName(),
            _widgetOfButton(),
            _widgetOfNameDev(),
          ],
        ),
      ),
    );
  }

  void _loadingItemsToChooseTheCapture() {
    items = [
      {
        _appLocalizations.localization?.profileGallery ?? "": "icon_gallery.svg"
      },
      {
        _appLocalizations.localization?.profileCamera ?? "": "icon_photo.svg",
      }
    ];
  }

  Widget _widgetOfNameDev() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
        top: 30,
      ),
      child: const Text(
        "Raphael Maracaipe",
        style: TextStyle(
          color: AppColors.colorGray,
          fontFamily: AppFonts.openSans,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _widgetOfButton() {
    return TextButton(
      key: const Key('UiProfilePageButtonContinue'),
      onPressed: _onPressedButtonContinue,
      child: Text(_appLocalizations.localization?.generalContinue ?? ""),
    );
  }

  Widget _widgetOfInputName() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 40,
          left: 40,
          right: 40,
        ),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(
                color: _colorsU.checkColorsWhichIsDarkMode(
                  context: context,
                  light: AppColors.colorGray,
                  dark: AppColors.colorWhite,
                ),
              ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorGray,
                  ),
                ),
                border: const OutlineInputBorder(),
                focusColor: AppColors.colorGray,
                labelStyle: TextStyle(
                  color: _colorsU.checkColorsWhichIsDarkMode(
                    context: context,
                    light: AppColors.colorGray,
                    dark: AppColors.colorWhite,
                  ),
                ),
                labelText:
                    (_appLocalizations.localization?.profileNameInput ?? ""),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextField(
                controller: _reminderController,
                style: TextStyle(
                  color: _colorsU.checkColorsWhichIsDarkMode(
                    context: context,
                    light: AppColors.colorGray,
                    dark: AppColors.colorWhite,
                  ),
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.colorGray,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  focusColor: AppColors.colorGray,
                  labelStyle: TextStyle(
                    color: _colorsU.checkColorsWhichIsDarkMode(
                      context: context,
                      light: AppColors.colorGray,
                      dark: AppColors.colorWhite,
                    ),
                  ),
                  labelText: (
                    _appLocalizations.localization?.profileReminderInput ?? ""
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetOfImage() {
    return GestureDetector(
      key: const Key("UiProfilePageChooseImage"),
      onTap: _onPressedProfile,
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorGray,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(120),
            ),
            child: _changeProfile(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorPrimary,
                borderRadius: BorderRadius.circular(120),
              ),
              padding: const EdgeInsets.all(10),
              child: _changeIconToAction(),
            ),
          )
        ],
      ),
    );
  }

  Widget _changeIconToAction() {
    if (_imageProfile == null) {
      return SvgPicture.asset(
        "assets/images/icon_camera.svg",
        color: AppColors.colorWhite,
        width: 50,
      );
    }

    return SvgPicture.asset(
      "assets/images/icon_cancel.svg",
      color: AppColors.colorWhite,
      width: 50,
    );
  }

  Widget _changeProfile() {
    if (_imageProfile == null) {
      return SvgPicture.asset(
        "assets/images/icon_profile.svg",
        color: AppColors.colorGray,
        width: 150,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: _imageProfile,
    );
  }

  void _onPressedProfile() async {
    if (_imageProfile != null) {
      setState(() {
        _imageProfile = null;
      });
      return;
    }

    _bottomSheetToChooseTypeCapture.show(
      context: context,
      title: _appLocalizations.localization?.profileChooseTitle ?? "",
      btnText: _appLocalizations.localization?.profileBottomClose ?? "",
      view: Container(
        margin: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              return _getRow(items[position]);
            },
          ),
        ),
      ),
      onBtnClick: () {},
    );
  }

  FutureOr<void> _onPressedButtonContinue() async {
    _loadingInModelName();

    if (_requestProfile.name!.isNotEmpty) {
      _sendToServer();
    } else {
      _bottomSheetAlertWhenDataOfProfile.show(
        context: context,
        title: (_appLocalizations.localization?.generalAttention ?? ""),
        text: (_appLocalizations.localization?.profileAlertProfileEmpty ?? ""),
        btnText: (_appLocalizations.localization?.generalYes ?? ""),
        onBtnClick: _sendToServer,
      );
    }
  }

  void _sendToServer() {
    _uiProfileBloc.add(SendProfile(profile: _requestProfile));
  }

  Widget _getRow(Map<String, String> mapData) {
    return GestureDetector(
      onTap: () {
        _bottomSheetToChooseTypeCapture.dimiss(context: context);
        _actionToCaptureImageToProfile(mapData);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                "assets/images/${mapData.values.single}",
                color: AppColors.colorGray,
                width: 30,
              ),
            ),
            Text(
              mapData.keys.single,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: AppColors.colorGray,
                fontFamily: AppFonts.openSans,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _actionToCaptureImageToProfile(
    Map<String, String> mapData,
  ) async {
    ImageSource typeImageSource = ImageSource.camera;
    if (mapData.values.single.contains("gallery")) {
      typeImageSource = ImageSource.gallery;
    }

    XFile? imagePicked = await _picker.pickImage(source: typeImageSource);
    if (imagePicked != null) {
      _loadingInModelProfile(imagePicked);

      setState(() {
        _imageProfile = Image.file(
          File(imagePicked.path),
          fit: BoxFit.cover,
        );
      });
    }
  }

  FutureOr<void> _loadingInModelProfile(XFile imagePicked) async {
    try {
      final file = File(imagePicked.path);
      final fileInBase64 = await _files.fileToBase64(file);
      _requestProfile = RequestProfile(photo: fileInBase64);
    } on Exception catch (_) {
      _requestProfile = RequestProfile(photo: "");
    }
  }

  void _loadingInModelName() {
    _requestProfile.name = _nameController.text;
    _requestProfile.reminder = _reminderController.text;

  }

  void _requestProfileSaved() {
    if (_profileObtain) {
      return;
    }

    _uiProfileBloc.add(GetProfile());
  }
}
