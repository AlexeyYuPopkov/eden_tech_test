import 'package:eden_tech_test/app/router/app_router_path.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/common/dialogs/show_dialog_helper.dart';
import 'package:eden_tech_test/presentation/common/localization/error_localization_mapper.dart';
import 'package:eden_tech_test/presentation/login_screen/bloc/login_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/login_screen_bloc.dart';
import 'bloc/login_screen_state.dart';

final class LoginScreen extends StatelessWidget with ShowDialogHelper {
  const LoginScreen({super.key});

  void _listener(BuildContext context, LoginScreenState state) {
    switch (state) {
      case LoginScreenLoadingState():
      case LoginScreenCommonState():
        break;
      case LoginScreenErrorState():
        final error = state.error;

        final message = ErrorLocalizationMapper.instance.getMessage(
          context,
          error,
        );

        if (message.isNotEmpty) {
          showSnackBar(context: context, text: message);
        }
        break;
      case DidLoadingState():
        GoRouter.of(context).go(AppRouterPath.home);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginScreenBloc(),
        child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
          listener: _listener,
          builder: (context, state) {
            return Center(
              child: ElevatedButton(
                onPressed: () => _onLogin(context),
                child: Text(context.loginButtonTitle),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onLogin(BuildContext context) {
    final bloc = context.read<LoginScreenBloc>();
    bloc.add(const OnLoginEvent(username: 'username', password: 'password'));
  }
}

extension on BuildContext {
  String get loginButtonTitle => l10n.loginScreenLoginButtonTitle;
}
