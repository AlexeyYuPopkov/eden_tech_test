import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/app/tools/exclude_from_tests.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/presentation/common/dialogs/show_dialog_helper.dart';
import 'package:eden_tech_test/presentation/common/localization/error_localization_mapper.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_state.dart';
import 'package:eden_tech_test/presentation/home_screen/widgets/movie_item_widget.dart';
import 'package:eden_tech_test/presentation/widgets/sliver_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_screen_bloc.dart';

final class HomeScreen extends StatelessWidget with ShowDialogHelper {
  const HomeScreen({super.key});

  void _listener(BuildContext context, HomeScreenState state) {
    switch (state) {
      case LoadingState():
      case CommonState():
        break;
      case ErrorState():
        final error = state.error;

        final message = ErrorLocalizationMapper.instance.getMessage(
          context,
          error,
        );

        if (message.isNotEmpty) {
          showSnackBar(context: context, text: message);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExcludeFromTests(
          child: BlocProvider(
            create: (context) => HomeScreenBloc(),
            child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
              listener: _listener,
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      title: Text('Movies'),
                      floating: true,
                      snap: true,
                    ),
                    const SliverSizedBox(height: Sizes.indent2x),
                    SliverList.separated(
                      itemCount: state.data.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.data.movies[index];

                        return MovieItemWidget(
                          movie: movie,
                          onTap: () => _onDetails(context, movie),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Sizes.indent);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onDetails(BuildContext context, Movie movie) {}
}
