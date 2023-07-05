import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_widget.dart';

class LoadingImpl implements Loading {
  @override
  Widget showLoading() => const LoadingWidget();
}
