import 'package:get/get.dart';

class MyLocal implements Translations {

  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "english": "الانجليزية",
          "arabic": "العربية",
          "Language": "اللغة",
          "Are you want to change language": "هل تريد تغيير اللغة ؟",
          "Default Language": "اللغة الافتراضية ",
          "English": "الانجليزية",
          "Arabic": "العربية",
          "Verify your email ": "تحقق من بريدك الالكتروني ",
          "We have sent password recovery instructions to your email.":
              "لقد أرسلنا تعليمات استعادة كلمة المرور إلى بريدك الإلكتروني.",
          "Open the email app": "افتح تطبيق البريد الإلكتروني",
          "Skip, I will confirm later": "تخطي ، سأؤكد لاحقًا",
          "Did not receive email? Check your spam filter":
              "لم تتلق البريد الإلكتروني؟ تحقق من عامل تصفية البريد العشوائي الخاص بك ،",
          "Try another email address": "جرب عنوان بريد إلكتروني آخر",
          "forgot password": "نسيت كلمة المرور",
          "Password Reset": "إعادة تعيين كلمة المرور",
          "Enter the email associated with your account and we will send an email with instructions to reset your password.":
              "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل بريدًا إلكترونيًا يحتوي على إرشادات لإعادة تعيين كلمة المرور الخاصة بك.",
          "email": "البريد الإلكتروني",
          "send": "إرسال",
          "Login": "تسجيل الدخول",
          "Log in with the data you entered during registration.":
              "قم بتسجيل الدخول بالبيانات التي أدخلتها أثناء التسجيل.",
          "Enter the email": "قم بإدخال البريد الإلكتروني",
          "Password": "كلمة المرور",
          "Enter Password": "أدخل كلمة المرور",
          "Forgot your password?": "نسيت كلمة المرور ؟",
          "Do not have an account?": "ليس لديك حساب؟",
          "Create an account": "إنشاء حساب",
          "Please fill out this form to create your account!":
              "يرجى ملء هذا النموذج لإنشاء حسابك!",
          "full name": "الإسم كاملا",
          "Please write your full name (first and last name)":
              "الرجاء كتابة الاسم كاملاً (الاسم الأول واسم العائلة)",
          "date of birth": "تاريخ الميلاد",
          "choose your age": "تاريخ الميلاد",
          "Confirm Password": "تأكيد كلمة المرور",
          "Address": "العنوان",
          "Enter your preferred address": "قم بإدخال عنوانك المفضل",
          "phone number": "رقم الهاتف",
          "Enter your phone number": "قم بإدخال رقم هاتفك",
          "athletic inclinations": "الميول الرياضي",
          "Enter your athletic inclination": "قم بإدخال ميولك الرياضي",
          "I already have an account": "لدي حساب بالفعل",
          "My Expectations": "توقعاتي",
          "not started": "لم تبدأ",
          "Favorites": "المفضلة",
          "Main": "الرئيسية",
          "live": "بث مباشر",
          "All matches": "كل المباريات",
          "Profile": "الملف الشخصي",
          "Change password": "تغيير كلمة المرور",
          "Notifications": "الإشعارات",
          "Share the application": "شارك التطبيق",
          "Contact Us": "تواصل معنا",
          "privacy_policy": "سياسة الخصوصية",
          "terms_conditions": "الشروط والأحكام",
          "agreement": "اتفاقية ترخيص المستخدم",
          "read_agreement": "اقرأ اتفاقية ترخيص المستخدم النهائي",
          "privacy_policy_agreement": "هل توافق على سياسة الخصوصية",
          "please_agree_privacy_policy": "يجب أن توافق على سياسة الخصوصية",
          "About Us": "معلومات عنا",
          "logout": "تسجيل الخروج",
          "The game has been added to the favourites":
              "تم إضافة المبارة إلى المفضلة",
          "add to favourites": "إضافة إلى المفضلة",
          "The match has been removed from the favourites":
              "تم حذف المبارة من المفضلة",
          "Delete from favourites": "حذف من المفضلة",
          "match": " مباراة ",
          "two games": " مبارتين ",
          "matches": " مباريات ",
          "today": "اليوم",
          "tomorrow": "غدا",
          "The Day After Tomorrow": "بعد غد",
          "Settings": "الإعدادات",
          "Are you sure you want to sign out":
              "هل أنت متأكد من عملية تسجيل الخروج ؟",
          "Yes": "نعم",
          "No": "لا",
          "cancel": "إلغاء",
          "delete": "حذف",
          "Search": "البحث",
          "Search here....": "ابحث هنا.......",
          "Awards": "الجوائز",
          "No prizes yet": "لا يوجد جوائز لحتى هذه اللحظة",
          "Match info": "معلومات المباراة",
          "Match time": "وقت المباراة",
          "League": "الدوري",
          "stadium": "الملعب",
          "Forecast recording": "تسجيل التوقع",
          "winners": "الفائزين",
          "There are no winners at this moment":
              "لا يوجد فائزيين لحتى هذه اللحظة",
          "Account modification": "تعديل الحساب",
          "Email Address": "عنوان البريد الإلكتروني",
          "save": "حفظ",
          "Football": "كرة القدم",
          "note": "ملاحظة",
          "This app was made in partnership with Hedge Technologies":
              "تم عمل هذا التطبيق بالشراكة مع شركة Hedge Technologies",
          "Saudi - Jeddah": "السعودية - جدة",
          "message": "الرسالة",
          "Your message title": "عنوان رسالتك",
          "Description": "الوصف",
          "Write your message here ......": "اكتب رسالتك هنا ......",
          "old password": "كلمة السر القديمة",
          "Enter the old password here": "اكتب هنا كلمة السر القديمة",
          "new password": "كلمة السر الجديدة",
          "Enter the new password here": "اكتب هنا كلمة السر الجديدة",
          "Confirm Password": "تأكيد كلمة السر",
          "Please confirm password": "الرجاء تأكيد كلمة السر",
          "skip": "تخطي",
          "La Liga": "الدوري الاسباني",
          "a minute ago": "منذ دقيقة",
          "start now": "ابدأ الآن",
          "Do you have an account?": "هل لديك حساب؟",
          "Enter your name": "أدخل إسمك",
          "enter email": "أدخل البريد الإلكتروني",
          "Enter a valid email": "أدخل بريد إلكتروني صحيح",
          "Password must be more than 6 characters":
              "يجب أن تكون كلمة المرور أكثر من 6 حروف ",
          "Enter Confirm Password": "أدخل تأكيد كلمة المرور",
          "Passwords do not match": "كلمتا المرور غير متطابقتان",
          "Enter the phone number": "قم بإدخال رقم الهاتف",
          "Enter your athletic inclination": "قم بإدخال الميول الرياضي",
          "Enter the message title": "أدخل عنوان الرسالة",
          "Enter a simple description of the message": "أدخل وصف بسيط للرسالة",
          "Thank you message sent": "تم إرسال رسالة شكرا لك",
          "sent": "تم الإرسال",
          "Your match prediction has been registered":
              "تم تسجيل توقعك لمباراة ",
          "Your prediction has been registered": "تم تسجيل توقعك",
          "Sent": "تـم الإرسال",
          "any day": "أي يوم",
          "Login Error": "خطأ في تسجيل الدخول",
          "There is an error, please check all the data entered":
              "هناك خطأ ما يرجى التحقق من جميع البيانات المدخلة",
          "Password Reset Done": "تم إعادة تعيين كلمة المرور",
          "The old password is incorrect": "كلمة المرور القديمة غير صحيحة",
          "Error changing password": "خطأ في تغيير كلمة المرور",
          "The entered password is incorrect": "كلمة المرور المدخل غير صحيحة",
          "This email is not associated with any account":
              "هذا الإيميل غير مقترن في أي حساب",
          "This email is used by someone else":
              "هذا الإيميل مستخدم من قبل شخص آخر",
          "Account creation error": "خطأ في إنشاء الحساب",
          "all_live": "قائمة البث المباشر",
          'packages': 'الباقات',
          'price': 'السعر : ',
          'days': 'الأيام : ',
          'day': ' يوم ',
          'enroll': 'شراء',
          'join': 'إنضمام',
          'ip_address_taken': 'لا يمكن إنشاء حساب على نفس الجهاز مرتين',
          'name_taken': 'الاسم مأخوذ من قبل مستخدم أخر',
          "please_login": "الرجاء تسجيل الدخول أولاً للمتابعة \n لأنك الآن في وضع الضيف",
          "delete_account": "حذف الحساب",
          "delete_account_confirmation": "هل أنت متأكد أنك تريد حذف حسابك؟",
          "subscribe": "إشتراك",
          "unsubscribe": "إلغاء الإشتراك",
          "done_payment_successfully": "تم الدفع بنجاح",
          "broadcasting_has_ended": "لقد تم إنهاء البث",
          'buy_subscription': 'شراء الاشتراك',
          'subscription_product': 'اشتراك المنتج',
          'subscription_package': 'اشتراك حزمة',
          'subscription_package_text': 'ستسمح لك هذه الحزمة الشهرية ببدء قناة البث المباشر الخاصة بك. البث المباشر يعني فقط مشاركة توقعات المباريات الخاصة بك. في حالة الفوز ، ستتلقى رسالة نصية من الراعي. الباقة لا تتجدد شهريا',
          'you_aleardy_subscribe': 'لقد قمت بالفعل بالاشتراك في هذه الحزمة',
          'done_cancel_subscribe': 'تم إالغاء إشتراك بالحزمة بنجاح',
          'no_have_any_subscribe': 'لا يوجد لديك أي اشتراكات',

          'report': 'إبلاغ',
          'submit': 'إرسال',
          'violent_extremism':'التطرف العنيف',
          'illegal_activities':'الأنشطة والسلع غير المشروعة',
          'hate_behaviour':'سلوك الكراهية',
          'fraud_and_fraud':'الاحتيال والنصب',
          'self_harm':'انتحار ، إيذاء النفس',
          'harassment':'المضايقة أو التنمر',
          'violent_grotesque_content':'محتوى عنيف وبشع',
          'wrong_info':'معلومات خاطئة',
          'Intellectual_property_infringement':'التعدي على الملكية الفكرية',
          'contest_rules': 'قواعد المسابقة',
          'application_advantages': 'مزايا التطبيق',
          'register_with_us': 'سجل معنا في التطبيق للتمتع بمزايا التطبيق المختلفة',
          'activate_your_subscription': 'قم بتفعيل اشتراكك في التطبيق لتتمتع بمميزات التطبيق',
          'predict_the_result': 'توقع نتيجة فريقك الفائز واربح العديد من الجوائز',
          'test_rules': 'يقوم المستخدم بتوقع نتيجة المباراة بين فريقين ويدخل السحب على العديد من الجوائز لكن على المستخدم التسجيل ف التطبيق ليقوم بالتوقع على المباريات',
          'apple_terms': '  نفيدكم علما بان شركة apple غير داعمة للتطبيق لا من الناحية المالية و لا من ناحية الشراكة.',
        },
          "en": {
            "english": "English",
            "arabic": "Arabic",
            "Language": "Language",
            "Are you want to change language": "Are you want to change language?",
            "Default Language": "Default Language",
            "English": "English",
            "Arabic": "Arabic",
            "Verify your email ": "Verify your email",
            "We have sent password recovery instructions to your email.":
                "We have sent password recovery instructions to your email.",
            "Open the email app": "Open the email app",
            "Skip, I will confirm later": "Skip, I'll confirm later",
            "Did not receive email? Check your spam filter":
                " Didn't receive email? Check your spam filter",
            "Try another email address": "Try another email address",
            "forgot password": "forgot password",
            "Password Reset": "Reset Password",
            "Enter the email associated with your account and we will send an email with instructions to reset your password.":
                "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
            "email": "email",
            "send": "send",
            "Login": "Login",
            "Log in with the data you entered during registration.":
                "Login with the data you entered during registration.",
            "Enter the email": "Enter the email",
            "Password": "Password",
            "Enter Password": "Enter Password",
            "Forgot your password?": "Forgot your password?",
            "Do not have an account?": "Do not have an account?",
            "Create an account": "Create an account",
            "Please fill out this form to create your account!":
                "Please fill out this form to create your account!",
            "full name": "Full name",
            "Please write your full name (first and last name)":
                "Please write your full name (first and last name)",
            "date of birth": "date of birth",
            "choose your age": "Birth Of Date",
            "Confirm Password": "Confirm Password",
            "Address": "Address",
            "Enter your preferred address": "Enter your preferred address",
            "phone number": "phone number",
            "Enter your phone number": "Enter your phone number",
            "athletic inclinations": "athletic inclinations",
            "Enter your athletic inclination": "Enter your athletic inclination",
            "I already have an account": "I already have an account",
            "My Expectations": "Predictions",
            "not started": "not started",
            "Favorites": "Favorites",
            "Main": "Home",
            "live": "Live",
            "All matches": "All matches",
            "Profile": "Profile",
            "Change password": "Change password",
            "Notifications": "Notifications",
            "Share the application": "Share the application",
            "Contact Us": "Contact Us",
            "privacy_policy": "Privacy policy",
            "terms_conditions": "Terms & Conditions",
            "agreement": "End-User License Agreement",
            "read_agreement": "Read End-User License Agreement",
            "privacy_policy_agreement": "Do you agree to the privacy policy",
            "please_agree_privacy_policy": "You must agree to the Privacy Policy",
            "About Us": "About Us",
            "logout": "Logout",
            "The game has been added to the favourites":
                "The game has been added to the favourites",
            "add to favourites": "add to favourites",
            "The match has been removed from the favourites":
                "The match has been removed from the favourites",
            "Delete from favourites": "Delete from favourites",
            "match": "match",
            "two games": "two games",
            "matches": " Matches ",
            "today": "today",
            "tomorrow": "tomorrow",
            "The Day After Tomorrow": "After tomorrow",
            "Settings": "Settings",
            "Are you sure you want to sign out":
                "Are you sure you want to sign out?",
            "Yes": "Yes",
            "No": " No",
            "cancel": "Cancel",
            "delete": "Delete",
            "Search": "Search",
            "Search here....": "Search here....",
            "Awards": "Awards",
            "No prizes yet": "No prizes yet",
            "Match info": "Match info.",
            "Match time": " Match time.",
            "League": "League",
            "stadium": "stadium",
            "Forecast recording": "Forecast recording",
            "winners": "winners",
            "There are no winners at this moment":
                "There are no winners at this moment",
            "Account modification": "Account modification",
            "Email Address": "Email Address",
            "save": "save",
            "Football": "Football",
            "note": "note",
            "This app was made in partnership with Hedge Technologies":
                "This app was made in partnership with Hedge Technologies",
            "Saudi - Jeddah": "Saudi - Jeddah",
            "message": "message",
            "Your message title": "Your message title.",
            "Description": "Description",
            "Write your message here ......": "Write your message here ......",
            "old password": "Old password",
            "Enter the old password here": "Enter the old password here",
            "new password": "New password",
            "Enter the new password here": "Enter the new password here",
            "Confirm Password": "Confirm Password",
            "Please confirm password": "Please confirm password.",
            "skip": "skip",
            "La Liga": "La Liga",
            "a minute ago": "a minute ago",
            "start now": "start now",
            "Do you have an account?": "Do you have an account?",
            "Enter your name": "Enter your name",
            "enter email": "enter email",
            "Enter a valid email": "Enter a valid e-mail",
            "Password must be more than 6 characters":
                "Password must be more than 6 characters",
            "Enter Confirm Password": "Enter Confirm Password",
            "Passwords do not match": "Passwords do not match",
            "Enter the phone number": "Enter the phone number",
            "Enter your athletic inclination": "Enter your athletic inclination",
            "Enter the message title": "Enter the message title",
            "Enter a simple description of the message":
                "Enter a simple description of the message",
            "Thank you message sent": "Thank you message sent",
            "sent": "sent",
            "Your match prediction has been registered":
                "Your match prediction has been registered",
            "Your prediction has been registered":
                "Your prediction has been registered",
            "Sent": "Sent",
            "any day": "any day",
            "Login Error": "Login Error",
            "There is an error, please check all the data entered":
                "There is an error, please check all the data entered.",
            "Password Reset": "Password Reset",
            "The old password is incorrect": " The old password is incorrect.",
            "Error changing password": "Error changing password",
            "The entered password is incorrect":
                "The entered password is incorrect",
            "This email is not associated with any account":
                "This email is not associated with any account",
            "This email is used by someone else":
                "This email is used by someone else",
            "Account creation error": "Account creation error",
            "all_live": "Live Menu",
            'packages': 'Packages',
            'price': 'Price: ',
            'days': 'Days: ',
            'day': ' Day ',
            'enroll': 'Enroll',
            'join': 'Join',
            'ip_address_taken': 'It is not possible to create an account on the same device twice',
            'name_taken': 'The name has already been taken.',
            "please_login": "Please login first to continue \nBecause you are now in guest mode",
            "delete_account": "Delete account",
            "delete_account_confirmation": "Are you sure want to delete your account?",
            "subscribe": "Subscribe",
            "unsubscribe": "Unsubscribe",
            "done_payment_successfully": "Done payment successfully",
            "broadcasting_has_ended": "Broadcasting has ended",
            'buy_subscription': 'Subscription',
            'subscription_product': 'Subscription product',
            'subscription_package': 'Subscription package',
            'subscription_package_text': 'This monthly package will allow you to start your own live streaming channel. The live streaming in meant only to share your matches expectations. In case of winning, you will receive a text message from our sponsor. The package is not renewed monthly',
            'you_aleardy_subscribe': 'You aleardy has subscribe in this package',
            'done_cancel_subscribe': 'The package has been successfully unsubscribed',
            'no_have_any_subscribe': 'No have any subscribtions',

            'report': 'Report',
            'submit': 'Submit',
            'violent_extremism':'violent extremism',
            'illegal_activities':'Illegal activities and goods',
            'hate_behaviour':'Hate behaviour',
            'fraud_and_fraud':'Fraud and fraud',
            'self_harm':'Suicide, self-harm',
            'harassment':'Harassment or bullying',
            'violent_grotesque_content':'Violent and grotesque content',
            'wrong_info':'Wrong information',
            'Intellectual_property_infringement':'Intellectual property infringement',
            'contest_rules': 'Contest rules',
            'application_advantages': 'Application advantages',
            'register_with_us': 'Register with us in the application to enjoy the various advantages of the application',
            'activate_your_subscription': 'Activate your subscription to the application to enjoy the features of the application',
            'predict_the_result': 'Predict the result of your winning team and win many prizes',
            'test_rules': 'The user predicts the outcome of the match between two teams and enters the draw for many prizes, but the user must register in the application to predict the matches',
            'apple_terms': 'We inform you that Apple is not supportive of the application, neither financially nor in terms of partnership.',
          }
      };
}