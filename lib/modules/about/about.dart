// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String line1 =
      ' * شركة دارين هي شركة توصيل تقوم علي خدمة قرية صفط الخمار وهي أسهل وأسرع طريقة لشراء أي متطلبات من المنزل دون زيادة في المصاريف وأسرع طريقة لطلب المشاوير بضغطة زر واحدة';
  static const String line2 =
      '١) يجب عمل الحساب برقم الهاتف الخاص لسهولة التواصل ';
  static const String line3 = '٢) يمكنكم التواصل عبر الهاتف او عبر الواتساب';
  static const String line4 = '٣) يجب كتابة العنوان مفصل لسهولة توصيل الطلبات';
  static const String line5 =
      '٤) للإبلاغ عن أي شكوي يمكن إرسال الشكوي في رسالة عبر الواتساب علي رقم الشركة الخاص أو الاتصال بنا مباشرة';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حول'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Text('حول تطبيق دارين :'),
              const SizedBox(height: 20),
              DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15, height: 1.6),
                child: const Text(line1),
              ),
              const SizedBox(height: 20),
              const Text('سياسة البيانات:'),
              const SizedBox(height: 20),
              DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, height: 1.6),
                textAlign: TextAlign.start,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(line2),
                    Text(line3),
                    Text(line4),
                    Text(line5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
