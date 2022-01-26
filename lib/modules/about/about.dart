// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String line1 =
      ' * شركة دارين هي شركة توصيل تقوم علي خدمة قرية صفط الخمار والقري المجاورة وهي أسهل وأسرع طريقة لشراء أي متطلبات من المنزل دون زيادة في المصاريف وأسرع طريقة لطلب المشاوير بضغطة زر واحدة';
  static const String line2 =
      '1) يجب عمل الحساب برقم الهاتف الخاص لسهولة التواصل ';
  static const String line3 = '2) يمكنكم التواصل عبر الهاتف او عبر الواتساب';
  static const String line4 = '3) يجب كتابة العنوان مفصل لسهولة توصيل الطلبات';
  static const String line5 =
      '4) للإبلاغ عن أي شكوي يمكن إرسال الشكوي في رسالة عبر الواتساب علي رقم الشركة الخاص أو الاتصال بنا مباشرة';
  static const String line6 =
      '5) في حالة وجود أي إقتراح يساعد علي تطوير الخدمة وتسهيل الأمور علي أهالينا في البلد يمكن إرساله وسيتم العمل عليه فوراً';
  static const String line7 =
      '6) التطبيق غير مقيد بالمنتجات الموجودة بداخله وفي حالة إحتياجك لأي شئ يمكن التواصل معانا وسنقوم بجلبه لك بأسرع وقت ممكن';
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
                    Text(line6),
                    Text(line7),
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
