// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

//===== to get searched product =====
  List<ProductModel> searchList = [];
   
  void addSearchedProductToSearchList(String text,BuildContext context) {
    searchList = ShopCubit.get(context).allProducts
        .where((product) => product.name.toLowerCase().contains(text))
        .toList();
    emit(SearchListUpdateState());
  }
}
