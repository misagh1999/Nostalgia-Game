import 'package:flutter/material.dart';

final primaryColor = Colors.teal;
final secondaryColor = Colors.amber;

var primaryGradint =
    LinearGradient(colors: [primaryColor.withOpacity(0.8), primaryColor]);

var secondaryGradint =
    LinearGradient(colors: [secondaryColor.withOpacity(0.8), secondaryColor]);

const kDefaultPadding = 16.0;

abstract class Fonts {
  static const Regular = "Regular";
  static const Medium = "Medium";
  static const Bold = "Bold";
  static const Black = "Black";
}

abstract class Assets {
  // todo: do it later
  static const LOGO = "assets/images/logo.png";
}

const READY_DESC_FE =
    'این بازی در ۵ نوبت انجام می‌شود. در هر نوبت شما باید گزینه مورد نظر را حدس بزنید. همچنین شما در طول بازی ۳ جان دارید. در صورت برنده شدن یا باختن به ترتیب به میزان امتیاز مشخص شده از مجموع امتیازات شما اضافه یا کاسته می‌شود. ';

const READY_DESC_FE_ONLINE =
    'در این قسمت شما می‌توانید به صورت دو نفره با حریف خود به صورت آنلاین رقابت کنید. این بازی در پنج مرحله انجام می‌شود و هر مرحله نیز دارای دو نوبت ویژه شما و حریف‌تان است. بعد از پایان بازی به میزان امتیاز تعیین شده از حریف کاسته می‌شود و برنده نیز به امتیازش افزوده می‌شود.';

const READY_DESC_HAND_ROCK = 'بازی سنگ کاغذ قیچی در ۵ نوبت انجام می‌شود.';
