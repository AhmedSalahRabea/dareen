// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDataScreen extends StatelessWidget {
  //form fields controller
  TextEditingController nameController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  //form key
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        //backgroundColor: Colors.white,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {},
          builder: (context, state) {
            RegisterCubit cubit = RegisterCubit.get(context);
            nameController.text = userName!;
            regionController.text = userRegion!;
            addressController.text = userAddress!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, right: 20, left: 20, top: 0),
                child: Form(
                  key: formKey,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Image.asset('assets/images/login/dareen.jpg'),
                        ),

                        const SizedBox(height: 30),
                        MyTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'من فضلك أدخل الإسم بشكل صحيح';
                            } else if (value.length < 7) {
                              return 'من فضلك أدخل الإسم ثنائي أو أكثر ';
                            } else {
                              return null;
                            }
                          },
                          label: 'الإسم بالكامل',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 20), // Text(

                        MyTextFormField(
                          controller: regionController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty || value.length < 3) {
                              return 'من فضلك أدخل المنطقة التي تسكن فيها مثل (شرق الكوبري - النقطة إلخ)';
                            } else {
                              return null;
                            }
                          },
                          label: 'المنطقة',
                          prefix: Icons.location_city,
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          controller: addressController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty || value.length < 12) {
                              return 'من فضلك أدخل العنوان بالتفصيل حتي نستطيع الوصول إليكم بسهولة';
                            } else {
                              return null;
                            }
                          },
                          label: 'العنوان بالتفصيل',
                          prefix: Icons.cottage,
                          isDetailedAddress: true,
                        ),
                        const SizedBox(height: 20),
                        MyDefaultButton(
                          text: 'التحديث',
                          function: () async {
                            showMyAlertDialog(
                                context: context,
                                title: 'تحديث',
                                content: 'UPDATE CLICKED');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
