// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ViveLocal';

  @override
  String get appTagline => 'اكتشف مدينتك، عِش حيّك';

  @override
  String get mapTitle => 'الخريطة';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle =>
      'احفظ المفضلة، وانشر الأماكن، واستقبل تنبيهات الفعاليات القريبة.';

  @override
  String get welcomeTitle => 'مرحبًا بك في ViveLocal';

  @override
  String get welcomeSubtitle =>
      'اكتشف أفضل الأماكن في Cochabamba، وشاركها مع المجتمع واحفظها لزيارتها متى شئت.';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get signOutConfirmation => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get orDivider => 'أو';

  @override
  String get signInWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get signInWithEmail => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get registerWithEmail => 'إنشاء حساب';

  @override
  String get createAccountTitle => 'إنشاء حساب';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get guest => 'زائر';

  @override
  String get notSignedIn => 'لم تسجّل الدخول';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get errorGeneric => 'حدث خطأ غير متوقع';

  @override
  String get errorFirebaseNotConfigured =>
      'Firebase غير مهيأ. شغّل flutterfire configure.';

  @override
  String get errorAuthCancelled => 'تم إلغاء تسجيل الدخول';

  @override
  String get errorAuthFailed => 'تعذر تسجيل الدخول';

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get errorLocationPermission => 'تم رفض إذن الموقع';

  @override
  String get errorLocationDisabled => 'خدمة الموقع في الجهاز غير مفعّلة';

  @override
  String get errorLocationUnavailable => 'تعذر الحصول على موقعك';

  @override
  String get errorWeatherNotConfigured => 'خدمة الطقس غير متوفرة';

  @override
  String get errorWeatherUnavailable => 'الطقس غير متاح';

  @override
  String get errorNetwork => 'تحقق من اتصالك بالإنترنت';

  @override
  String get errorPlaceNotFound => 'لم نجد هذا المكان';

  @override
  String get myLocation => 'موقعي';

  @override
  String get openInGoogleMaps => 'افتح في خرائط Google';

  @override
  String get googleMapsNotAvailable => 'تعذر فتح خرائط Google';

  @override
  String get placeDetailsTitle => 'تفاصيل المكان';

  @override
  String get weatherTitle => 'الطقس';

  @override
  String weatherFeelsLike(String temp) {
    return 'الإحساس $temp°';
  }

  @override
  String weatherHumidity(String value) {
    return 'الرطوبة $value%';
  }

  @override
  String weatherWind(String value) {
    return 'الرياح $value م/ث';
  }

  @override
  String get noPlaces => 'لا توجد أماكن قريبة بعد';

  @override
  String get placesLoadError => 'تعذر تحميل الأماكن';

  @override
  String get demoModeBanner => 'وضع العرض: Firebase غير متصل بعد';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get language => 'اللغة';

  @override
  String get systemLanguage => 'لغة النظام';

  @override
  String get spanish => 'الإسبانية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صالح';

  @override
  String get noAccountRegister => 'ليس لديك حساب؟ أنشئ حسابًا';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ سجّل الدخول';

  @override
  String get unlockWithBiometrics => 'فتح بالمقاييس الحيوية';

  @override
  String get favoritesTitle => 'المفضلة';

  @override
  String get publishTitle => 'نشر';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String coordinatesLabel(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get addPlace => 'إضافة مكان';

  @override
  String get createPlaceTitle => 'مكان جديد';

  @override
  String get placeNameLabel => 'اسم المكان';

  @override
  String get placeCategoryLabel => 'الفئة';

  @override
  String placeLocationHint(String lat, String lng) {
    return 'الموقع: $lat, $lng';
  }

  @override
  String get usingMapCenter => 'لا يوجد موقع حالي: سيتم استخدام مركز الخريطة';

  @override
  String get savePlace => 'حفظ المكان';

  @override
  String get placeCreated => 'تم إنشاء المكان بنجاح';

  @override
  String get errorCreatePlace => 'تعذر إنشاء المكان';

  @override
  String get placeNameRequired => 'الاسم مطلوب';

  @override
  String get placeCategoryRequired => 'الفئة مطلوبة';

  @override
  String get placePhotoLabel => 'صورة المكان (اختياري)';

  @override
  String get takePhoto => 'التقط صورة';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get errorPhotoPick => 'تعذر الحصول على الصورة. حاول مرة أخرى.';

  @override
  String get errorPhotoUpload => 'تعذر رفع الصورة. حاول مرة أخرى.';

  @override
  String get galleryTitle => 'معرض الصور';

  @override
  String get noPhotosYet => 'لا توجد صور بعد لهذا المكان';

  @override
  String get takePhotoWithCamera => 'التقاط صورة بالكاميرا';

  @override
  String get localBadge => 'محلي';

  @override
  String get webBadge => 'ويب';

  @override
  String get photoSaved => 'تم حفظ الصورة بنجاح';

  @override
  String get deletePhotoTitle => 'حذف الصورة؟';

  @override
  String get deletePhotoConfirm => 'هل تريد حذف هذه الصورة من المعرض؟';

  @override
  String get delete => 'حذف';
}
