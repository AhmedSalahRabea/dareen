// ignore_for_file: avoid_print

import 'package:dareen_app/data/models/product_model.dart';
import 'package:dareen_app/data/models/search_model.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

//===== to get searched product =====
  List<ProductModel> searchList = [];
  SearchModel? searchModel;
  void searchProduct(String text) {
    emit(SearchLoading());
    DioHelper.getData(
      url: SEARCH,
      query: {
        'name': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      if (searchModel!.status!) {
        // ignore: avoid_function_literals_in_foreach_calls
        searchModel!.data!.forEach((product) {
          searchList.add(product);
        });
        emit(SearchSuccess());
      }
    }).catchError((error) {
      print(error.toString());
      emit(SearchError());
    });
  }
}
