// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, must_be_immutable

//import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/modules/settings/big_user_item.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/cubit/app_cubit.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
      
          AppCubit cubit = AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  // User card
                  //this item from my setting not from the package
                  BigUserItem(
                    userName: 'احمد صلاح',
                    //  userName: model!.data!.name,
                    userProfilePic:
                        const AssetImage('assets/images/login/dareen.jpg'),
                    phoneNumber: '01018388182',
                    address:  'كوبري المستشفي',
                    //  phoneNumber: model!.data!.phoneNumber,
                    //  address: model!.data!.address,
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.dark_mode_rounded,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: Colors.deepOrange,
                        ),
                        title: 'الوضع الساطع',
                        subtitle: " للتحويل بين الوضع الليلي والساطع ",
                        trailing: Switch.adaptive(
                          value: cubit.isLight,
                          onChanged: (value) {
                            cubit.changeAppMode();
                          },
                        ),
                      ),
                    ],
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.person_pin_sharp,
                        iconStyle: IconStyle(
                          backgroundColor: Colors.deepOrange,
                        ),
                        title: 'البيانات الشخصية',
                        subtitle: 'للتعديل علي بياناتك الشخصية',
                      ),
                    ],
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.info_rounded,
                        iconStyle: IconStyle(
                          backgroundColor: Colors.deepOrange,
                        ),
                        title: 'حول',
                        subtitle: "معلومات عن شركة دارين",
                      ),
                    ],
                  ),
                  // You can add a settings title
                  SettingsGroup(
                    //settingsGroupTitle: "Account",
                    items: [
                      SettingsItem(
                        onTap: () {
                          showMyAlertDialog(
                            context: context,
                            title: 'تسجيل الخروج',
                            content: 'هل تريد تسجيل الخروج من تطبيق دارين',
                            actions: [
                              MyOkTextButtonForDailog(
                                okOrCancel: 'إلغاء',
                              ),
                              MyTextButton(
                                text: 'تسجيل الخروج',
                                fontSize: 14,
                                onpressed: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .signOut(context);
                                },
                              ),
                            ],
                          );
                        },
                        icons: Icons.exit_to_app_rounded,
                        title: "تسجيل الخروج",
                        subtitle: 'اذا كنت تريد تسجيل الخروج',
                      ),
                      SettingsItem(
                        onTap: () {},
                        icons: CupertinoIcons.delete_solid,
                        title: "Delete account",
                        titleStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
