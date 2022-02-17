// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/no_internet_or_noproducts.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
            if (state is AddOrDeleteFavouriteSuccess) {
              ShopCubit.get(context).getFavourites(userId);
            }
          }, builder: (context, state) {
            ShopCubit cubit = ShopCubit.get(context);
            return BuildCondition(
              condition: cubit.favourites.isNotEmpty,
              builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return ProductOrFavouriteItem(
                      model: cubit.favourites[index],
                    );
                  },
                  separatorBuilder: (contextm, index) => const MyDivider(),
                  itemCount: cubit.favourites.length,
                ),
              ),
              fallback:
                  state is FavouritesGetSuccess && cubit.favourites.isEmpty
                      ? (context) => NoInterNetOrNoProducts(
                          text: 'قائمة المفضلة فارغة', icon: Icons.favorite)
                      : (context) =>
                          const Center(child: CircularProgressIndicator()),
            );
          });
        } else {
          return NoInterNetOrNoProducts(
            icon: Icons.signal_wifi_connected_no_internet_4,
            text: 'يرجي فحص الإتصال بالإنترنت',
          );
        }
      },
      child: const CircularProgressIndicator(),
    );
  }
}
