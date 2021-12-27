// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Dareen',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 27),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  color: Colors.deepOrange,
                  iconSize: 30,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currebIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currebIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            iconSize: 27,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
