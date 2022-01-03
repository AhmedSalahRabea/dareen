// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, must_be_immutable

//import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/modules/settings/big_user_item.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/cubit/app_cubit.dart';
import 'package:dareen_app/shared/network/local/cache_helper.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  // User card
                  //this item from my setting not from the package
                  BigUserItem(
                    userName: CacheHelper.getDataFromSharedPrefrences(
                        key: 'userName'),
                    userProfilePic:
                        const AssetImage('assets/images/login/dareen.jpg'),
                    phoneNumber: CacheHelper.getDataFromSharedPrefrences(
                        key: 'phoneNumber'),
                    address: 'كوبري المستشفي',
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
                        subtitleStyle: Theme.of(context).textTheme.subtitle2,
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
                    settingsGroupTitle: 'اتصل بنا',
                    iconItemSize: 37,
                    settingsGroupTitleStyle:
                        Theme.of(context).textTheme.headline1,
                    items: [
                      SettingsItem(
                        onTap: () async {
                          String url = "tel:+201018388182";
                          if (await canLaunch(url)) {
                            launch(url);
                          } else {
                            showMyAlertDialog(
                              context: context,
                              title: 'خطأ أثناء الوصول إلي الهاتف',
                              content:
                                  'حدث خطأ أثناء الوصول برجاء المحاولة لاحقا',
                            );
                          }
                        },
                        icons: Icons.call_rounded,
                        title: "عبر الموبايل",
                        subtitle: 'للإتصال علي 01018388182 ',
                        subtitleStyle: Theme.of(context).textTheme.subtitle2,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        iconStyle: IconStyle(
                          iconsColor: Colors.deepOrange,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SettingsItem(
                          onTap: () async {
                            String url = "https://wa.me/+201018388182";
                            if (await canLaunch(url)) {
                              launch(url);
                            } else {
                              showMyAlertDialog(
                                context: context,
                                title: 'خطأ أثناء الوصول إلي الواتساب',
                                content:
                                    'حدث خطأ ربما يكون تطبيق الواتساب غير موجود علي هاتفك',
                              );
                            }
                          },
                          icons: FontAwesomeIcons.whatsappSquare,
                          title: "واتساب",
                          subtitle: 'للتواصل معنا عبر الواتساب',
                          subtitleStyle: Theme.of(context).textTheme.subtitle2,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          iconStyle: IconStyle(
                            iconsColor: Colors.green,
                            withBackground: true,
                            backgroundColor: Colors.white.withOpacity(0),
                          )),
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
                        subtitleStyle: Theme.of(context).textTheme.subtitle2,
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
                        subtitleStyle: Theme.of(context).textTheme.subtitle2,
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
                        subtitleStyle: Theme.of(context).textTheme.subtitle2,
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
