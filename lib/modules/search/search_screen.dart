// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/modules/search/cubit/search_cubit.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:dareen_app/shared/widgets/product_fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'البحث',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16.sp),
                ),
              ),
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyTextFormField(
                        controller: textController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty) {
                            // return 'من فضلك أدخل اسم المنتج الذي تريد البحث عنه في منتجاتنا';
                          }
                        },
                        label: 'البحث',
                        prefix: Icons.search,
                        onsubmit: (String text) {
                          cubit.addSearchedProductToSearchList(text, context);
                        },
                        onchange: (text) {
                          cubit.addSearchedProductToSearchList(text, context);
                        },
                      ),
                    ),
                    SizedBox(height: 1.h),
                    if (state is SearchLoading) LinearProgressIndicator(),
                    BuildCondition(
                      condition: cubit.searchList.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              ProductOrFavouriteItem(
                                  model: cubit.searchList[index]),
                          separatorBuilder: (context, index) => MyDivider(),
                          itemCount: cubit.searchList.length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: Column(
                          children: [
                            Text(
                              'من فضلك أدخل اسم المنتج الذي تريد البحث عنه',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
