import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_flutter/modules/app_colors.dart';
import 'package:portfolio_flutter/modules/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/test/test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UiAuthPage extends StatefulWidget {
  const UiAuthPage({super.key});

  @override
  State<UiAuthPage> createState() => _UiAuthPageState();
}

class _UiAuthPageState extends State<UiAuthPage> {
  @override
  Widget build(BuildContext context) {
    final Test test = Modular.get<Test>();
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Column(
        children: [
          containerTop(),
          containerOfInputs(),
        ],
      ),
    );
  }

  Expanded containerTop() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/icon_app.svg",
            color: Colors.white,
            width: 150,
          ),
          const Text(
            "Portfólio",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: AppFonts.OpenSans,
            ),
          ),
          Text(
            (AppLocalizations.of(context)?.authTitle1 ?? ""),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: AppFonts.OpenSans,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget containerOfInputs() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              _buttonCountry(),
            ],
          ),
          Row(
            children: [
              _inputCodeCountry(),
              _inputPhone(),
            ],
          ),
          Row(
            children: [
              _buttonEntrar(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: const Text(
                  "Raphael Maracaipe",
                  style: TextStyle(
                    fontFamily: AppFonts.OpenSans,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Expanded _buttonCountry() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.colorGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                "País",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.colorGray,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.colorGray,
            )
          ],
        ),
      ),
    );
  }

  Expanded _buttonEntrar() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.colorPrimary,
          ),
          child: const Text(
            "ENTRAR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _inputCodeCountry() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: const SizedBox(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorGray,
                ),
              ),
              border: OutlineInputBorder(),
              focusColor: AppColors.colorGray,
              labelStyle: TextStyle(
                color: AppColors.colorGray,
              ),
              labelText: 'Cód. País',
            ),
          ),
        ),
      ),
    );
  }

  Expanded _inputPhone() {
    return Expanded(
      flex: 7,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const SizedBox(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorGray,
                ),
              ),
              border: OutlineInputBorder(),
              focusColor: AppColors.colorGray,
              labelStyle: TextStyle(
                color: AppColors.colorGray,
              ),
              labelText: 'Telefone',
            ),
          ),
        ),
      ),
    );
  }
}
