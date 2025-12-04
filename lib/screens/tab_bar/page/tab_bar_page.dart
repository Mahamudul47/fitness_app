import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitness_flutter/core/const/color_constants.dart';
import 'package:fitness_flutter/core/const/path_constants.dart';
import 'package:fitness_flutter/core/const/text_constants.dart';

import 'package:fitness_flutter/screens/home/page/home_page.dart';
import 'package:fitness_flutter/screens/settings/settings_screen.dart';
import 'package:fitness_flutter/screens/workouts/page/workouts_page.dart';
import 'package:fitness_flutter/screens/tab_bar/bloc/tab_bar_bloc.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (_) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
        currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      selectedItemColor: ColorConstants.primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            PathConstants.home,
            color: bloc.currentIndex == 0 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.homeIcon,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            PathConstants.workouts,
            color: bloc.currentIndex == 1 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.workoutsIcon,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            PathConstants.settings,
            color: bloc.currentIndex == 2 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.settingsIcon,
        ),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final pages = [
      const HomePage(),
      const WorkoutsPage(),
      const SettingsScreen(),
    ];
    return pages[index];
  }
}
