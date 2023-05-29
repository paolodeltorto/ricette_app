import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricette_app/router/app_router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/welcome_cubit.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(_) => _welcomeCubit(
      child: LayoutBuilder(
          builder: (context, _) => Scaffold(
                body: Container(
                  padding: const EdgeInsets.all(32),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _sliderContainer(context),
                      _startMessagingButton(context),
                    ],
                  ),
                ),
              )));

  Widget _welcomeCubit({required Widget child}) => BlocProvider(
        create: (_) => WelcomeCubit(),
        child: child,
      );

  Widget _sliderContainer(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _slides(context),
            _indicator(),
          ],
        ),
      );

  Widget _slides(BuildContext context) {
    final widgets = _items(context)
        .map((item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: item['image'],
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Text(
                              item['header'],
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['description']),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ))
        .toList(growable: false);
    // ignore: sized_box_for_whitespace
    return Container(
      height: 300,
      child: PageView.builder(
        itemBuilder: (context, index) => widgets[index],
        itemCount: widgets.length,
        controller: context.read<WelcomeCubit>().controller,
      ),
    );
  }

  Widget _indicator() => BlocBuilder<WelcomeCubit, int>(
      builder: (context, page) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _items(context).length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: page == index
                      ? const Color(0xFF256875)
                      : const Color(0xFF256875).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ));
  Widget _startMessagingButton(BuildContext context) => ElevatedButton(
        onPressed: () => context.router.push(const HomeRoute()),
        child: Text(AppLocalizations.of(context)?.action_start_button ?? ''),
      );
  List _items(BuildContext context) => [
        {
          'image': const Icon(
            Icons.telegram,
            size: 128,
            color: Colors.cyan,
          ),
          'header': AppLocalizations.of(context)?.welcome_header_1,
          'description': AppLocalizations.of(context)?.welcome_description_1,
        },
        {
          'image': Image.asset('images/pizza.jpg', width: 200.0, height: 200.0),
          'header': AppLocalizations.of(context)?.welcome_header_1,
          'description': AppLocalizations.of(context)?.welcome_description_1,
        },
      ];
}
