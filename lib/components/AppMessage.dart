import 'dart:io';

class AppMessage {
  static String successfulRequest = 'successful';
  static String unAuthorized = 'unAuthorized';
  static String serverExceptions = 'serverExceptions';
  static String socketException = 'socketException';
  static String timeoutException = 'timeoutException';
  static String formatException = 'formatException';
  static String stay = 'stay';
  static String unAuthorizedText =
      'انتهت صلاحية الجلسة'; //"نحن آسفون ولكننا غير قادرين على التحقق من هويتك. يجب عليك تسجيل الدخول";
  static String tryAgain = 'إعادة المحاولة';
  static String serverText = "حدث خطأ ما اثناء معالجة طلبك";
  static String socketText = 'لايوجد اتصال بالانترنت';
  static String timeoutText =
      'يبدو أن الخادم يستغرق وقتًا طويلاً للاستجابة، حاول مجدداً بعد فترة';
  static String formatText = "تعذر إتمام العملية في الوقت الحالي.";
  static String initial = 'initial';
  static String loading = 'loading';
  static String loadingMore = 'loading more';
  static String loadingText = 'انتظر من فضلك';
  static String loaded = 'loaded';
  static String noData = 'لاتوجد بيانات لعرضها';
  static String noLive = 'لايوجد بثوث لعرضها';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static Map<String, String> headersWithToken({required String? token}) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  static Map<String, String> headersMultiFile({required String? token}) => {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  static String appName = 'تأويل';
  static String search = 'البحث';
  static String mandatoryTx = 'حقل اجباري';
  static String description = 'الوصف';
  static String arabicOnlyValidation = 'مسموح بالاحرف العربية فقط';
  static String englishOnlyValidation =
      'يجب ان يكون اسم المستخدم باللغة الانجليزية';
  static String invalidEmail = "البريد الالكتروني غير صالح";
  static String confirmDelete = 'هل انت متاكد من اكمال عملية الحذف؟';
  static String delete = 'حذف';
  static String yes = 'نعم';
  static String no = 'لا';
  static String cancel = 'الغاء';
  static String select = 'اختيار';
  static String selectDate = 'اختر التاريخ';
  static String listError = 'هذه القائمة غير متوفرة حاليا';
  static String home = 'الرئيسية';
  static String profile = 'الملف الشخصي';
  static String notification = 'الاشعارات';
  static String welcome = 'مرحباً بك في تأويل';
  static String service = 'الخدمات';
  static String greetingSubTitle = 'بوابتك لفهم الأحلام والرؤى';
  static String less = 'عرض اقل';
  static String more = 'المزيد';
  static String selectFromList = 'اختر من القائمة';
  static String attachment = 'المرفقات';
  static String activation = 'تفعيل';
  static String warning = 'تنبيه';
  static String confirmation = 'تأكيد العملية';
  static String success = 'نجاح العملية';
  static String successSubText = 'تمت العمليه بنجاح';
  static String error = 'حدث خطأ';
  static String info = "معلومات";
  static String okay = "حسنًا";
  static String price = "السعر";
  static String add = "اضافة";
  static String notes = "المذكرة";
  static String optional = "إختياري";
  static String selectImage = "عليك اختيار صورة واحدة على الاقل";
  static String editProfile = "تعديل الملف الشخصي";
  static String darkMode = "الوضع المظلم";
  static String support = "الدعم الفني";
  static String logOut = "تسجيل الخروج";
  static String myStory = 'حالتي';
  static String addToStory = 'اضف الى حالتك';
  static String text = 'نص';
  static String image = 'صورة';
  static String video = 'فيديو';
  static String voice = 'صوت';
  static String liveTimeOut = 'انتهى الوقت المسموح للبث (الايف)';
  static String connectionFailed = 'لا يوجد اتصال حدث خطأ ما';
  static String tryAgainSthWrong = "حدث خطأ ما حاول لاحقا";
  static String couldNotSend = 'حدث خطأ, لم نتمكن من الارسال حاول لاحقا';
  static String requestSent = 'تم ارسال طلبك بنجاح';

  static String removedBy({required String name}) {
    return 'تم ازالتك من البث من قبل $name';
  }

  static String closedBy({required String name}) {
    return ' قام $name بانهاء البث ';
  }

  static String permissionRequest({required String permissionType}) {
    return 'الرجاء تفعيل اذن $permissionType لتتمكن من اكمال العملية ';
  }

  static String noMoreThan({required int limit}) {
    return 'الحد الاقصى $limit خانات';
  }

  static String noLessThan({required int limit}) {
    return 'الحد الادنى $limit خانات';
  }

  static String removeUserFromLive({required String name}) {
    return ' هل انت متأكد من انك تريد ازالة $name من هذا البث؟';
  }

  static String passwordValidation =
      'لحماية حسابك يجب اختيار حرف صغير، كبير، رقم ورمز';
  static String startWithZero = 'يجب ان لا يبدأ ارقم الجوال بالرقم 0';
  static String mustStartWith5 = 'يجب ان يبدأ رقم الجوال بالرقم 5';
  static String writeNote =
      'سجّل المهام أو الاحلام لتتمكن من العودة إليها لاحقًا';
  static String addTitle = 'اضف العنوان';
  static String addText = 'اضف النص';
  static String addNote = 'اضف مذكرة';
  static String edit = 'تعديل';
  static String liveStreams = 'البثوث المباشرة';
  static String remembrances = 'أذكار النوم';
  static String follow = 'متابعة';
  static String unFollow = 'إلغاء المتابعة';
  static String close = 'إغلاق';
  static String startLive = 'بدء بث مباشر';
  static String start = 'بدء';
  static String micOff = 'كتم الميكروفون';
  static String micOn = 'تشغيل الميكروفون';
  static String flipCamera = 'قلب الكاميرا';
  static String controlComments = 'تفعيل/تعطيل التعليقات';
  static String comments = 'التعليقات';
  static String settings = 'الإعدادات';
  static String writeComment = 'اضاقة تعليق';
  static String resumeStream = 'تشغيل البث';
  static String pauseStream = 'إيقاف البث مؤقتا';
  static String hide = 'إخفاء';
  static String addGuest = '+ ضيوف';
  static String request = 'مشاركة';
  static String popular = 'الاعلى تقييم';
  static String guestsRequests = 'طلبات الضيوف';
  static String emptyRequests = 'لا يوجد طلبات ضيوف';
  static String end = 'انهاء';
  static String acceptRequest = 'قبول الطلب';
  static String chooseJoinType = 'حدد نوع المشاركة لارسال الطلب';
  static String joinLive = 'المشاركة في البث ';
  static String goToSettings = 'الذهاب للاعدادات';
  static String accept = 'قبول';
  static String liveResult = 'نتائج البث';
  static String liveResultTitle = 'تهانينا !';
  static String liveResultSubTitle = 'انتهى البث واليك نتائج البث';
  static String likes = 'الاعجابات';
  static String views = 'المشاهدين';
  static String newFollowers = 'المتابعين الجدد';
  static String searchUser = 'ابحث عن مستخدم';
  static String currentViewers = 'المشاهدين الحاليين';
  static String noViewers = 'لا يوجد مشاهدين';
  static String remove = 'ازالة ';
  static String enablePermission = 'تفعيل الاذن';
  static String noMoreGuestsAllowed = 'لا يمكنك اضافة ضيوف اكثر';
  static String confirm = 'تأكيد';
  static String removeUser = 'ازالة مستخدم';
  static String accepted = 'تم القبول';
  static String requestAccepted = 'تم قبول طلب انضمامك';
  static String interpreters = 'المفسرين';
  static String interpreter = 'interpreter';
  static String callUs = 'الدعم الفني';
  static String commonQuestions = 'الأسئلة الشائعة';
  static String privacy = 'سياسة الخصوصية';
  static String useTerm = 'شروط الاستخدام';
  static String deleteAccount = 'حذف الحساب';
  static String name = 'الاسم';
  static String email = 'البريد الالكتروني';
  static String password = 'كلمة المرور';
  static String workTime = 'مواعيد العمل';
  static String communication = 'التواصل';
  static String communicationAndPrice = 'الاسعار و التواصل';
  static String chat = 'رسائل نصية';
  static String call = 'اتصال';
  static String callChat = 'مكالمة صوتية';
  static String rangeError = "يرجى التأكد من أن وقت النهاية بعد وقت البداية.";
  static String startTime = 'وقت البداية';
  static String endTime = 'وقت النهاية';
  static String pm = 'م';
  static String am = 'ص';
  static String from = 'من';
  static String to = 'الى';
  static String selectTime = 'اختر الوقت';
  static String orders = 'رؤياي';
  static String chats = 'المحادثات';
  static String ruqia = 'الرقية الشرعية';
  static String sendText = 'ادخل نص';
  static String dream = "حلم";
  static String follower = 'متابع';
  static String status = 'الحالة';
  static String readable = 'مقروءة';
  static String sound = "صوتية";
  static String fromLessPrice = 'الأقل سعرا';
  static String fromHighestPrice = 'الأكثر سعرا';
  static String fromOldest = 'الأقدم';
  static String fromNewer = "الأحدث";
  static String date = "التاريخ";
  static String package = "الباقة";
  static String onPrecess = "قيد التنفيذ";
  static String complete = "مكتمل";
  static String logIn = "تسجيل الدخول";
  static String signUp = "انشاء حساب";
  static String userName = "الاسم";
  static String phone = "رقم الجوال";
  static String orSignUp = "انشئ حساب";
  static String forgotPassword = "نسيت كلمة المرور؟";
  static String confirmPassword = "تأكيد كلمة المرور";
  static String resetPassword = "اعادة تعيين كلمة المرور";
  static String send = "ارسال";
  static String resetPasswordText = 'سيتم الرسال رمز التحقق على البريد المدخل';
  static String addCodeText = 'قم بادخال الرمز المرسل الى بريدك';
  static String didNotReceiveCode = 'لم يصلك الرمز؟';
  static String micPermission = 'تفعيل اذن المايكروفون';
  static String micPermissionMessage =
      'يجب تفعيل إذن الميكروفون لاستخدام هذه الميزة. الرجاء تفعيل الإذن من الإعدادات.';
  static String rememberMe = 'تذكرني';
  static String imageReachedLimit = 'حجم الصورة يجب أن لا يزيد عن 1 ميجابايت';
  static String accessImage =
      "التطبيق يحتاج إلى إذن لعرض الصور، فعل الإذن من الإعدادات.";
  static String phoneKey = '966+';
  static String experienceYear = 'سنوات الخبرة';

  static String priceMorThan0 = "يجب أن يكون السعر أكبر من صفر";
  static String notAvailable = "هذه الميزة غير متاحة حاليا";
  static String liveNotAllowed = 'لا يمكنك مشاهدة هذا البث';
  static String videoTimeLimitError =
      'يجب ان تكون المدة الزمنية للفيديو اكثر من ثانية واقل من دقيقة';
  static String exitChatBot =
      'عند الخروج من الصفحة ستفقد المحادثة هل تريد الخروج ؟';
  static String chatBotErrorMessage =
      'عذرا الرجاء التواصل في وقت لاحق او التواصل على ';
  static String supportChatWelcome =
      'مرحبا بك يسعدني خدمتك, قد يستغرق الرد عليك بضع دقائق شكرا لتفهمك';
  static String emailAr = "البريد الالكتروني";
  static String emailCopied = "تم نسخ البريد الالكتروني";
  static String whatsApp = 'الواتساب';
  static String deleteAccountTitle =
      'عند حذف الحساب يتم حذفه نهائيا و لن تتمكن من استرجاعه لاحقا';
  static String deleteAccountInstruction =
      '* لتتمكن من حذف حسابك عليك التأكد اولا من انه لا يوجد لديك طلبات غير مكتملة';
  static String deleteAccountReason = 'سبب الحذف';
  static String confirmChangeStatus =
      'عند تغير حالة الطلب لن تتمكن من ارجاعها, هل انت متأكد من تغير حالة الطلب؟';
}
