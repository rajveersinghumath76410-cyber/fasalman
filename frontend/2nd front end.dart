import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  await appState.load();

  runApp(FasalManApp(appState: appState));
}

/* ============================================================
   APP STATE
   ============================================================ */

class AppState extends ChangeNotifier {
  String name = '';
  String location = '';
  String profilePhotoPath = '';

  bool darkMode = false;
  String language = 'English';
  bool profileCompleted = false;

  SharedPreferences? _prefs;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();

    name = _prefs?.getString('name') ?? '';
    location = _prefs?.getString('location') ?? '';
    profilePhotoPath = _prefs?.getString('profilePhotoPath') ?? '';
    darkMode = _prefs?.getBool('darkMode') ?? false;
    language = _prefs?.getString('language') ?? 'English';
    profileCompleted = _prefs?.getBool('profileCompleted') ?? false;

    notifyListeners();
  }

  Future<void> saveProfile({
    required String newName,
    required String newLocation,
    String? newPhotoPath,
  }) async {
    name = newName.trim();
    location = newLocation.trim();

    if (newPhotoPath != null && newPhotoPath.isNotEmpty) {
      profilePhotoPath = newPhotoPath;
    }

    profileCompleted = name.isNotEmpty;

    await _prefs?.setString('name', name);
    await _prefs?.setString('location', location);
    await _prefs?.setString('profilePhotoPath', profilePhotoPath);
    await _prefs?.setBool('profileCompleted', profileCompleted);

    notifyListeners();
  }

  Future<void> setProfilePhoto(String path) async {
    profilePhotoPath = path;

    await _prefs?.setString('profilePhotoPath', path);

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;

    await _prefs?.setBool('darkMode', value);

    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    language = value;

    await _prefs?.setString('language', value);

    notifyListeners();
  }

  Future<void> resetProfile() async {
    name = '';
    location = '';
    profilePhotoPath = '';
    profileCompleted = false;

    await _prefs?.remove('name');
    await _prefs?.remove('location');
    await _prefs?.remove('profilePhotoPath');
    await _prefs?.setBool('profileCompleted', false);

    notifyListeners();
  }
}

/* ============================================================
   APP SCOPE
   ============================================================ */

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required Widget child,
  }) : super(notifier: state, child: child);

  static AppState of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppScope>();

    assert(scope != null, 'AppScope not found');

    return scope!.notifier!;
  }
}

/* ============================================================
   TRANSLATIONS
   ============================================================ */

const Map<String, Map<String, String>> translations = {
  'English': {
    'app_name': 'Fasal Man',
    'hello': 'Hello',
    'home_subtitle': 'Your smart farming companion',
    'detect': 'Detect Disease',
    'detect_subtitle': 'Scan your crop and identify problems',
    'soil': 'Soil Advisor',
    'soil_subtitle': 'Get soil-based recommendations',
    'chat': 'AI Chatbot',
    'chat_subtitle': 'Ask anything about your crop',
    'alerts': 'Alerts',
    'recent': 'Recent Activity',
    'early_blight': 'Possible Early Blight',
    'tomato': 'Tomato Leaf',
    'confidence': '91% confidence',
    'view_treatment': 'View Treatment Plan',
    'scan_again': 'Scan Again',
    'treatment': 'Treatment Plan',
    'immediate': 'Immediate Actions',
    'prevention': 'Prevention',
    'remove_leaves': 'Remove infected leaves',
    'spacing': 'Improve plant spacing',
    'water_soil': 'Water at soil level',
    'keep_clean': 'Keep field clean',
    'sunlight': 'Ensure enough sunlight',
    'monitor': 'Monitor regularly',
    'safety': 'Use crop protection products according to the product label and local guidance.',
    'scan_another': 'Scan Another Crop',
    'soil_title': 'Soil Advisor',
    'soil_help': 'Enter your soil values to get a recommendation.',
    'ph': 'Soil pH',
    'nitrogen': 'Nitrogen',
    'phosphorus': 'Phosphorus',
    'potassium': 'Potassium',
    'recommendation': 'Recommendation',
    'chat_title': 'Crop Assistant',
    'chat_welcome': 'Hello! I am Fasal Man. How can I help with your crop today?',
    'chat_hint': 'Ask about your crop...',
    'send': 'Send',
    'alerts_title': 'Farm Alerts',
    'no_alerts': 'No new alerts',
    'settings': 'Settings',
    'dark_mode': 'Dark Mode',
    'language': 'Language',
    'profile': 'Profile',
    'edit_profile': 'Edit Profile',
    'name': 'Name',
    'location': 'Location',
    'camera': 'Camera',
    'gallery': 'Gallery',
    'save': 'Save',
    'cancel': 'Cancel',
    'reset': 'Reset Profile',
    'profile_setup': 'Set up your profile',
    'continue': 'Continue',
    'choose_photo': 'Choose Profile Photo',
    'add_photo': 'Add Photo',
    'crop_photos': 'Crop Photos',
    'add_crop': 'Add Crop Photo',
    'analyze': 'Analyze Crop',
    'review': 'Review Crop Photos',
    'max_photos': 'You can add up to 4 photos.',
  },
  'Hindi': {
    'app_name': 'फसल मैन',
    'hello': 'नमस्ते',
    'home_subtitle': 'आपका स्मार्ट खेती सहायक',
    'detect': 'रोग पहचानें',
    'detect_subtitle': 'फसल स्कैन करके समस्या पहचानें',
    'soil': 'मृदा सलाहकार',
    'soil_subtitle': 'मिट्टी के आधार पर सलाह लें',
    'chat': 'AI चैटबॉट',
    'chat_subtitle': 'फसल के बारे में पूछें',
    'alerts': 'अलर्ट',
    'recent': 'हाल की गतिविधि',
    'early_blight': 'अर्ली ब्लाइट की संभावना',
    'tomato': 'टमाटर की पत्ती',
    'confidence': '91% भरोसा',
    'view_treatment': 'उपचार योजना देखें',
    'scan_again': 'फिर स्कैन करें',
    'treatment': 'उपचार योजना',
    'immediate': 'तुरंत करें',
    'prevention': 'बचाव',
    'remove_leaves': 'संक्रमित पत्तियां हटाएं',
    'spacing': 'पौधों के बीच दूरी रखें',
    'water_soil': 'मिट्टी के स्तर पर पानी दें',
    'keep_clean': 'खेत साफ रखें',
    'sunlight': 'पर्याप्त धूप सुनिश्चित करें',
    'monitor': 'नियमित निगरानी करें',
    'safety': 'फसल सुरक्षा उत्पादों का उपयोग लेबल और स्थानीय सलाह के अनुसार करें।',
    'scan_another': 'दूसरी फसल स्कैन करें',
    'soil_title': 'मृदा सलाहकार',
    'soil_help': 'सलाह पाने के लिए मिट्टी के मान दर्ज करें।',
    'ph': 'मिट्टी का pH',
    'nitrogen': 'नाइट्रोजन',
    'phosphorus': 'फॉस्फोरस',
    'potassium': 'पोटैशियम',
    'recommendation': 'सलाह',
    'chat_title': 'फसल सहायक',
    'chat_welcome': 'नमस्ते! मैं फसल मैन हूं। मैं आपकी फसल में कैसे मदद कर सकता हूं?',
    'chat_hint': 'फसल के बारे में पूछें...',
    'send': 'भेजें',
    'alerts_title': 'खेत अलर्ट',
    'no_alerts': 'कोई नया अलर्ट नहीं',
    'settings': 'सेटिंग्स',
    'dark_mode': 'डार्क मोड',
    'language': 'भाषा',
    'profile': 'प्रोफाइल',
    'edit_profile': 'प्रोफाइल संपादित करें',
    'name': 'नाम',
    'location': 'स्थान',
    'camera': 'कैमरा',
    'gallery': 'गैलरी',
    'save': 'सहेजें',
    'cancel': 'रद्द करें',
    'reset': 'प्रोफाइल रीसेट करें',
    'profile_setup': 'अपना प्रोफाइल बनाएं',
    'continue': 'जारी रखें',
    'choose_photo': 'प्रोफाइल फोटो चुनें',
    'add_photo': 'फोटो जोड़ें',
    'crop_photos': 'फसल फोटो',
    'add_crop': 'फसल फोटो जोड़ें',
    'analyze': 'फसल का विश्लेषण करें',
    'review': 'फसल फोटो देखें',
    'max_photos': 'आप अधिकतम 4 फोटो जोड़ सकते हैं।',
  },
  'Hinglish': {
    'app_name': 'Fasal Man',
    'hello': 'Namaste',
    'home_subtitle': 'Aapka smart farming companion',
    'detect': 'Disease Detect Karein',
    'detect_subtitle': 'Crop scan karke problem identify karein',
    'soil': 'Soil Advisor',
    'soil_subtitle': 'Soil ke basis par recommendation',
    'chat': 'AI Chatbot',
    'chat_subtitle': 'Apni crop ke baare mein poochhein',
    'alerts': 'Alerts',
    'recent': 'Recent Activity',
    'early_blight': 'Possible Early Blight',
    'tomato': 'Tomato Leaf',
    'confidence': '91% confidence',
    'view_treatment': 'Treatment Plan',
    'scan_again': 'Scan Again',
    'treatment': 'Treatment Plan',
    'immediate': 'Immediate Actions',
    'prevention': 'Prevention',
    'remove_leaves': 'Infected leaves remove karein',
    'spacing': 'Plants ke beech spacing rakhein',
    'water_soil': 'Soil level par paani dein',
    'keep_clean': 'Field clean rakhein',
    'sunlight': 'Enough sunlight dein',
    'monitor': 'Regularly monitor karein',
    'safety': 'Crop protection products label aur local guidance ke according use karein.',
    'scan_another': 'Another Crop Scan Karein',
    'soil_title': 'Soil Advisor',
    'soil_help': 'Recommendation ke liye soil values enter karein.',
    'ph': 'Soil pH',
    'nitrogen': 'Nitrogen',
    'phosphorus': 'Phosphorus',
    'potassium': 'Potassium',
    'recommendation': 'Recommendation',
    'chat_title': 'Crop Assistant',
    'chat_welcome': 'Hello! Main Fasal Man hoon. Aapki crop mein kaise help kar sakta hoon?',
    'chat_hint': 'Crop ke baare mein poochhein...',
    'send': 'Send',
    'alerts_title': 'Farm Alerts',
    'no_alerts': 'No new alerts',
    'settings': 'Settings',
    'dark_mode': 'Dark Mode',
    'language': 'Language',
    'profile': 'Profile',
    'edit_profile': 'Edit Profile',
    'name': 'Name',
    'location': 'Location',
    'camera': 'Camera',
    'gallery': 'Gallery',
    'save': 'Save',
    'cancel': 'Cancel',
    'reset': 'Reset Profile',
    'profile_setup': 'Profile Setup',
    'continue': 'Continue',
    'choose_photo': 'Choose Profile Photo',
    'add_photo': 'Add Photo',
    'crop_photos': 'Crop Photos',
    'add_crop': 'Add Crop Photo',
    'analyze': 'Analyze Crop',
    'review': 'Review Crop Photos',
    'max_photos': 'Maximum 4 photos allowed.',
  },
  'Marathi': {
    'app_name': 'फसल मॅन',
    'hello': 'नमस्कार',
    'home_subtitle': 'तुमचा स्मार्ट शेती सहाय्यक',
    'detect': 'रोग ओळखा',
    'detect_subtitle': 'पीक स्कॅन करून समस्या ओळखा',
    'soil': 'माती सल्लागार',
    'soil_subtitle': 'मातीवर आधारित सल्ला',
    'chat': 'AI चॅटबॉट',
    'chat_subtitle': 'पिकाबद्दल विचारा',
    'alerts': 'सूचना',
    'recent': 'अलीकडील क्रिया',
    'early_blight': 'अर्ली ब्लाइटची शक्यता',
    'tomato': 'टोमॅटोचे पान',
    'confidence': '91% विश्वास',
    'view_treatment': 'उपचार योजना',
    'scan_again': 'पुन्हा स्कॅन करा',
    'treatment': 'उपचार योजना',
    'immediate': 'त्वरित कृती',
    'prevention': 'प्रतिबंध',
    'remove_leaves': 'संक्रमित पाने काढा',
    'spacing': 'झाडांमध्ये योग्य अंतर ठेवा',
    'water_soil': 'मातीच्या पातळीवर पाणी द्या',
    'keep_clean': 'शेत स्वच्छ ठेवा',
    'sunlight': 'पुरेसा सूर्यप्रकाश द्या',
    'monitor': 'नियमित निरीक्षण करा',
    'safety': 'उत्पादनाच्या लेबल आणि स्थानिक मार्गदर्शनानुसार वापरा.',
    'scan_another': 'दुसरे पीक स्कॅन करा',
    'soil_title': 'माती सल्लागार',
    'soil_help': 'सल्ल्यासाठी मातीची मूल्ये भरा.',
    'ph': 'मातीचा pH',
    'nitrogen': 'नायट्रोजन',
    'phosphorus': 'फॉस्फरस',
    'potassium': 'पोटॅशियम',
    'recommendation': 'सल्ला',
    'chat_title': 'पीक सहाय्यक',
    'chat_welcome': 'नमस्कार! मी फसल मॅन आहे. मी तुमच्या पिकासाठी कशी मदत करू?',
    'chat_hint': 'पिकाबद्दल विचारा...',
    'send': 'पाठवा',
    'alerts_title': 'शेत सूचना',
    'no_alerts': 'नवीन सूचना नाहीत',
    'settings': 'सेटिंग्ज',
    'dark_mode': 'डार्क मोड',
    'language': 'भाषा',
    'profile': 'प्रोफाइल',
    'edit_profile': 'प्रोफाइल संपादित करा',
    'name': 'नाव',
    'location': 'स्थान',
    'camera': 'कॅमेरा',
    'gallery': 'गॅलरी',
    'save': 'सेव्ह',
    'cancel': 'रद्द',
    'reset': 'प्रोफाइल रीसेट',
    'profile_setup': 'प्रोफाइल तयार करा',
    'continue': 'पुढे',
    'choose_photo': 'प्रोफाइल फोटो निवडा',
    'add_photo': 'फोटो जोडा',
    'crop_photos': 'पीक फोटो',
    'add_crop': 'पीक फोटो जोडा',
    'analyze': 'पीक तपासा',
    'review': 'पीक फोटो तपासा',
    'max_photos': 'जास्तीत जास्त 4 फोटो.',
  },
  'Punjabi': {
    'app_name': 'ਫਸਲ ਮੈਨ',
    'hello': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ',
    'home_subtitle': 'ਤੁਹਾਡਾ ਸਮਾਰਟ ਖੇਤੀ ਸਹਾਇਕ',
    'detect': 'ਬਿਮਾਰੀ ਪਛਾਣੋ',
    'detect_subtitle': 'ਫਸਲ ਸਕੈਨ ਕਰਕੇ ਸਮੱਸਿਆ ਪਛਾਣੋ',
    'soil': 'ਮਿੱਟੀ ਸਲਾਹਕਾਰ',
    'soil_subtitle': 'ਮਿੱਟੀ ਦੇ ਆਧਾਰ ਤੇ ਸਲਾਹ',
    'chat': 'AI ਚੈਟਬੋਟ',
    'chat_subtitle': 'ਫਸਲ ਬਾਰੇ ਪੁੱਛੋ',
    'alerts': 'ਅਲਰਟ',
    'recent': 'ਹਾਲੀਆ ਗਤੀਵਿਧੀ',
    'early_blight': 'ਅਰਲੀ ਬਲਾਈਟ ਦੀ ਸੰਭਾਵਨਾ',
    'tomato': 'ਟਮਾਟਰ ਦਾ ਪੱਤਾ',
    'confidence': '91% ਭਰੋਸਾ',
    'view_treatment': 'ਇਲਾਜ ਯੋਜਨਾ',
    'scan_again': 'ਦੁਬਾਰਾ ਸਕੈਨ',
    'treatment': 'ਇਲਾਜ ਯੋਜਨਾ',
    'immediate': 'ਤੁਰੰਤ ਕਾਰਵਾਈ',
    'prevention': 'ਬਚਾਅ',
    'remove_leaves': 'ਸੰਕਰਮਿਤ ਪੱਤੇ ਹਟਾਓ',
    'spacing': 'ਪੌਦਿਆਂ ਵਿਚਕਾਰ ਦੂਰੀ ਰੱਖੋ',
    'water_soil': 'ਮਿੱਟੀ ਦੇ ਪੱਧਰ ਤੇ ਪਾਣੀ ਦਿਓ',
    'keep_clean': 'ਖੇਤ ਸਾਫ ਰੱਖੋ',
    'sunlight': 'ਪੂਰੀ ਧੁੱਪ ਯਕੀਨੀ ਬਣਾਓ',
    'monitor': 'ਨਿਯਮਿਤ ਨਿਗਰਾਨੀ ਕਰੋ',
    'safety': 'ਉਤਪਾਦ ਦੇ ਲੇਬਲ ਅਤੇ ਸਥਾਨਕ ਸਲਾਹ ਅਨੁਸਾਰ ਵਰਤੋਂ ਕਰੋ।',
    'scan_another': 'ਹੋਰ ਫਸਲ ਸਕੈਨ ਕਰੋ',
    'soil_title': 'ਮਿੱਟੀ ਸਲਾਹਕਾਰ',
    'soil_help': 'ਸਲਾਹ ਲਈ ਮਿੱਟੀ ਦੀਆਂ ਕੀਮਤਾਂ ਭਰੋ।',
    'ph': 'ਮਿੱਟੀ pH',
    'nitrogen': 'ਨਾਈਟ੍ਰੋਜਨ',
    'phosphorus': 'ਫਾਸਫੋਰਸ',
    'potassium': 'ਪੋਟਾਸ਼ੀਅਮ',
    'recommendation': 'ਸਲਾਹ',
    'chat_title': 'ਫਸਲ ਸਹਾਇਕ',
    'chat_welcome': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ! ਮੈਂ ਫਸਲ ਮੈਨ ਹਾਂ। ਮੈਂ ਤੁਹਾਡੀ ਫਸਲ ਲਈ ਕਿਵੇਂ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ?',
    'chat_hint': 'ਫਸਲ ਬਾਰੇ ਪੁੱਛੋ...',
    'send': 'ਭੇਜੋ',
    'alerts_title': 'ਖੇਤ ਅਲਰਟ',
    'no_alerts': 'ਕੋਈ ਨਵਾਂ ਅਲਰਟ ਨਹੀਂ',
    'settings': 'ਸੈਟਿੰਗਜ਼',
    'dark_mode': 'ਡਾਰਕ ਮੋਡ',
    'language': 'ਭਾਸ਼ਾ',
    'profile': 'ਪ੍ਰੋਫਾਈਲ',
    'edit_profile': 'ਪ੍ਰੋਫਾਈਲ ਸੋਧੋ',
    'name': 'ਨਾਮ',
    'location': 'ਸਥਾਨ',
    'camera': 'ਕੈਮਰਾ',
    'gallery': 'ਗੈਲਰੀ',
    'save': 'ਸੇਵ',
    'cancel': 'ਰੱਦ',
    'reset': 'ਪ੍ਰੋਫਾਈਲ ਰੀਸੈਟ',
    'profile_setup': 'ਪ੍ਰੋਫਾਈਲ ਬਣਾਓ',
    'continue': 'ਜਾਰੀ ਰੱਖੋ',
    'choose_photo': 'ਪ੍ਰੋਫਾਈਲ ਫੋਟੋ ਚੁਣੋ',
    'add_photo': 'ਫੋਟੋ ਜੋੜੋ',
    'crop_photos': 'ਫਸਲ ਫੋਟੋ',
    'add_crop': 'ਫਸਲ ਫੋਟੋ ਜੋੜੋ',
    'analyze': 'ਫਸਲ ਵਿਸ਼ਲੇਸ਼ਣ',
    'review': 'ਫਸਲ ਫੋਟੋ ਵੇਖੋ',
    'max_photos': 'ਵੱਧ ਤੋਂ ਵੱਧ 4 ਫੋਟੋਆਂ।',
  },
  'Bengali': {
    'app_name': 'ফসল ম্যান',
    'hello': 'নমস্কার',
    'home_subtitle': 'আপনার স্মার্ট কৃষি সহায়ক',
    'detect': 'রোগ শনাক্ত করুন',
    'detect_subtitle': 'ফসল স্ক্যান করে সমস্যা শনাক্ত করুন',
    'soil': 'মাটি পরামর্শ',
    'soil_subtitle': 'মাটির ভিত্তিতে পরামর্শ',
    'chat': 'AI চ্যাটবট',
    'chat_subtitle': 'ফসল সম্পর্কে প্রশ্ন করুন',
    'alerts': 'সতর্কতা',
    'recent': 'সাম্প্রতিক কার্যকলাপ',
    'early_blight': 'আর্লি ব্লাইটের সম্ভাবনা',
    'tomato': 'টমেটো পাতা',
    'confidence': '৯১% আত্মবিশ্বাস',
    'view_treatment': 'চিকিৎসা পরিকল্পনা',
    'scan_again': 'আবার স্ক্যান',
    'treatment': 'চিকিৎসা পরিকল্পনা',
    'immediate': 'তাৎক্ষণিক পদক্ষেপ',
    'prevention': 'প্রতিরোধ',
    'remove_leaves': 'আক্রান্ত পাতা সরান',
    'spacing': 'গাছের মধ্যে দূরত্ব রাখুন',
    'water_soil': 'মাটির স্তরে পানি দিন',
    'keep_clean': 'ক্ষেত পরিষ্কার রাখুন',
    'sunlight': 'পর্যাপ্ত সূর্যালোক নিশ্চিত করুন',
    'monitor': 'নিয়মিত পর্যবেক্ষণ করুন',
    'safety': 'লেবেল এবং স্থানীয় নির্দেশনা অনুযায়ী ব্যবহার করুন।',
    'scan_another': 'অন্য ফসল স্ক্যান করুন',
    'soil_title': 'মাটি পরামর্শ',
    'soil_help': 'পরামর্শ পেতে মাটির মান লিখুন।',
    'ph': 'মাটির pH',
    'nitrogen': 'নাইট্রোজেন',
    'phosphorus': 'ফসফরাস',
    'potassium': 'পটাশিয়াম',
    'recommendation': 'পরামর্শ',
    'chat_title': 'ফসল সহায়ক',
    'chat_welcome': 'নমস্কার! আমি ফসল ম্যান। আপনার ফসলের জন্য কীভাবে সাহায্য করতে পারি?',
    'chat_hint': 'ফসল সম্পর্কে প্রশ্ন করুন...',
    'send': 'পাঠান',
    'alerts_title': 'খেত সতর্কতা',
    'no_alerts': 'নতুন সতর্কতা নেই',
    'settings': 'সেটিংস',
    'dark_mode': 'ডার্ক মোড',
    'language': 'ভাষা',
    'profile': 'প্রোফাইল',
    'edit_profile': 'প্রোফাইল সম্পাদনা',
    'name': 'নাম',
    'location': 'স্থান',
    'camera': 'ক্যামেরা',
    'gallery': 'গ্যালারি',
    'save': 'সেভ',
    'cancel': 'বাতিল',
    'reset': 'প্রোফাইল রিসেট',
    'profile_setup': 'প্রোফাইল তৈরি করুন',
    'continue': 'চালিয়ে যান',
    'choose_photo': 'প্রোফাইল ছবি বেছে নিন',
    'add_photo': 'ছবি যোগ করুন',
    'crop_photos': 'ফসলের ছবি',
    'add_crop': 'ফসলের ছবি যোগ করুন',
    'analyze': 'ফসল বিশ্লেষণ',
    'review': 'ফসলের ছবি দেখুন',
    'max_photos': 'সর্বোচ্চ ৪টি ছবি।',
  },
};

String tr(BuildContext context, String key) {
  final state = AppScope.of(context);
  return translations[state.language]?[key] ??
      translations['English']![key] ??
      key;
}

/* ============================================================
   APP
   ============================================================ */

class FasalManApp extends StatelessWidget {
  final AppState appState;

  const FasalManApp({
    super.key,
    required this.appState,
  });

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF6F8F5),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32),
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF6F8F5),
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF101510),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF66BB6A),
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF101510),
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1B221B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF1B221B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: appState,
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fasal Man',
            theme: _lightTheme(),
            darkTheme: _darkTheme(),
            themeMode:
                appState.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}

/* ============================================================
   COMMON WIDGETS
   ============================================================ */

class ProfileAvatar extends StatelessWidget {
  final double radius;

  const ProfileAvatar({
    super.key,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    if (state.profilePhotoPath.isNotEmpty) {
      final file = File(state.profilePhotoPath);

      if (file.existsSync()) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: FileImage(file),
        );
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        Icons.person,
        size: radius,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

/* ============================================================
   SPLASH
   ============================================================ */

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Timer(const Duration(milliseconds: 1900), () {
      if (!mounted) return;

      final state = AppScope.of(context);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => state.profileCompleted
              ? const HomePage()
              : const ProfileSetupPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scale,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: color.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.agriculture,
                  color: Colors.white,
                  size: 52,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Fasal Man',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: color.primary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Smart farming companion',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: color.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ============================================================
   PROFILE SETUP
   ============================================================ */

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedPhoto;
  bool _saving = false;

  Future<void> _pickPhoto(ImageSource source) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1000,
    );

    if (picked == null || !mounted) return;

    final savedPath = await _saveProfileImage(picked);

    if (!mounted) return;

    setState(() {
      _selectedPhoto = savedPath;
    });
  }

  Future<String> _saveProfileImage(XFile picked) async {
    final directory = await getApplicationDocumentsDirectory();

    final extension = picked.path.contains('.')
        ? picked.path.split('.').last
        : 'jpg';

    final target = File(
      '${directory.path}/fasal_profile_${DateTime.now().millisecondsSinceEpoch}.$extension',
    );

    await File(picked.path).copy(target.path);

    return target.path;
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    setState(() {
      _saving = true;
    });

    final state = AppScope.of(context);

    await state.saveProfile(
      newName: _nameController.text,
      newLocation: _locationController.text,
      newPhotoPath: _selectedPhoto,
    );

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
      (route) => false,
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(tr(context, 'camera')),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(tr(context, 'gallery')),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(tr(context, 'cancel')),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                tr(context, 'profile_setup'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tell us a little about yourself to personalize Fasal Man.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 35),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      backgroundImage: _selectedPhoto != null
                          ? FileImage(File(_selectedPhoto!))
                          : null,
                      child: _selectedPhoto == null
                          ? Icon(
                              Icons.person,
                              size: 58,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            )
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Material(
                        color: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: _showPhotoOptions,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(11),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              TextField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: tr(context, 'name'),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: tr(context, 'location'),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          tr(context, 'continue'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ============================================================
   HOME
   ============================================================ */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  void _onNavigation(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PreviewPage(),
        ),
      );
      return;
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AlertsPage(),
        ),
      );
      return;
    }

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        ),
      );
      return;
    }

    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final name =
        state.name.isEmpty ? 'Farmer' : state.name.split(' ').first;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
          children: [
            Row(
              children: [
                ProfileAvatar(radius: 25),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tr(context, 'hello')}, $name 👋',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tr(context, 'home_subtitle'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Hero card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.72),
                  ],
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 360;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Protect your crop.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Take a photo and let Fasal Man help identify crop problems.',
                              style: TextStyle(
                                color: Colors.white70,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 18),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PreviewPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                              label: Text(
                                tr(context, 'detect'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!compact) ...[
                        const SizedBox(width: 12),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 72,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
            SectionTitle('Quick Actions'),

            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.science_outlined,
                    title: tr(context, 'soil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SoilAdvisorPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.chat_bubble_outline,
                    title: tr(context, 'chat'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.notifications_none,
                    title: tr(context, 'alerts'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AlertsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            SectionTitle(tr(context, 'recent')),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context, 'early_blight'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(tr(context, 'tomato')),
                          const SizedBox(height: 3),
                          Text(
                            tr(context, 'confidence'),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNavigation,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Detect',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 17,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ============================================================
   PROFILE
   ============================================================ */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'profile')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: ProfileAvatar(radius: 58),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              state.name.isEmpty ? 'Farmer' : state.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          if (state.location.isNotEmpty) ...[
            const SizedBox(height: 5),
            Center(
              child: Text(
                state.location,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: Text(tr(context, 'edit_profile')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfilePage(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(tr(context, 'settings')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   EDIT PROFILE
   ============================================================ */

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;

  String _photoPath = '';
  bool _initialized = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();

    // IMPORTANT:
    // Do not call AppScope.of(context) here.
    // Inherited widgets must be accessed after initState.
    _nameController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This is the correct place to read AppScope.
    if (!_initialized) {
      final state = AppScope.of(context);

      _nameController.text = state.name;
      _locationController.text = state.location;
      _photoPath = state.profilePhotoPath;

      _initialized = true;
    }
  }

  Future<String> _saveProfileImage(XFile picked) async {
    final directory = await getApplicationDocumentsDirectory();

    final extension = picked.path.contains('.')
        ? picked.path.split('.').last
        : 'jpg';

    final target = File(
      '${directory.path}/fasal_profile_${DateTime.now().millisecondsSinceEpoch}.$extension',
    );

    await File(picked.path).copy(target.path);

    return target.path;
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1000,
    );

    if (picked == null) return;

    final savedPath = await _saveProfileImage(picked);

    if (!mounted) return;

    final state = AppScope.of(context);

    // Update the central state immediately.
    await state.setProfilePhoto(savedPath);

    if (!mounted) return;

    setState(() {
      _photoPath = savedPath;
    });
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(tr(context, 'camera')),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(tr(context, 'gallery')),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(tr(context, 'cancel')),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    setState(() {
      _saving = true;
    });

    final state = AppScope.of(context);

    await state.saveProfile(
      newName: _nameController.text,
      newLocation: _locationController.text,
      newPhotoPath: _photoPath.isEmpty ? null : _photoPath,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        _photoPath.isNotEmpty && File(_photoPath).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'edit_profile')),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 62,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    backgroundImage:
                        hasPhoto ? FileImage(File(_photoPath)) : null,
                    child: hasPhoto
                        ? null
                        : Icon(
                            Icons.person,
                            size: 62,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _showPhotoOptions,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: tr(context, 'name'),
                prefixIcon: const Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: tr(context, 'location'),
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        width: 23,
                        height: 23,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        tr(context, 'save'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================================================
   SETTINGS
   ============================================================ */

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showLanguageDialog(BuildContext context) {
    final state = AppScope.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(tr(context, 'language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: translations.keys.map((language) {
              return RadioListTile<String>(
                value: language,
                groupValue: state.language,
                title: Text(language),
                onChanged: (value) async {
                  if (value == null) return;

                  await state.setLanguage(value);

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _resetProfile(BuildContext context) async {
    final state = AppScope.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(tr(context, 'reset')),
          content: const Text(
            'This will remove your saved profile information. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(tr(context, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(tr(context, 'reset')),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await state.resetProfile();

    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const ProfileSetupPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: SwitchListTile(
              secondary: Icon(
                state.darkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title: Text(tr(context, 'dark_mode')),
              subtitle: Text(
                state.darkMode ? 'Enabled' : 'Disabled',
              ),
              value: state.darkMode,
              onChanged: (value) {
                // This immediately rebuilds MaterialApp and changes theme.
                state.setDarkMode(value);
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(tr(context, 'language')),
              subtitle: Text(state.language),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showLanguageDialog(context),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(tr(context, 'edit_profile')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfilePage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.restart_alt,
                color: Colors.orange,
              ),
              title: Text(tr(context, 'reset')),
              onTap: () => _resetProfile(context),
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   CROP PREVIEW / IMAGE PICKER
   ============================================================ */

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final ImagePicker _picker = ImagePicker();

  final List<XFile> _photos = [];

  Future<void> _takePhoto() async {
    if (_photos.length >= 4) {
      _showMaxPhotos();
      return;
    }

    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1400,
    );

    if (photo == null || !mounted) return;

    setState(() {
      _photos.add(photo);
    });
  }

  Future<void> _pickGallery() async {
    if (_photos.length >= 4) {
      _showMaxPhotos();
      return;
    }

    final remaining = 4 - _photos.length;

    final selected = await _picker.pickMultiImage(
      imageQuality: 85,
      maxWidth: 1400,
      limit: remaining,
    );

    if (!mounted) return;

    setState(() {
      _photos.addAll(
        selected.take(remaining),
      );
    });
  }

  void _showMaxPhotos() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(context, 'max_photos')),
      ),
    );
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  bool _analyzing = false;

  Future<void> _analyze() async {
    if (_photos.isEmpty || _analyzing) {
      if (_photos.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one crop photo.'),
          ),
        );
      }
      return;
    }

    // MVP analysis: do not await a dialog. The old flow waited for the
    // dialog to close before continuing, which made the result appear only
    // after pressing the Android Back button.
    setState(() {
      _analyzing = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 1300),
    );

    if (!mounted) return;

    final analyzedPhotos = List<XFile>.from(_photos);

    setState(() {
      _analyzing = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiagnosisPage(
          photos: analyzedPhotos,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'review')),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, 'crop_photos'),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${_photos.length}/4 photos added',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            if (_photos.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 45,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.photo_camera_outlined,
                        size: 65,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Add clear photos of the affected crop.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _photos.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(_photos[index].path),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Material(
                            color: Colors.black54,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => _removePhoto(index),
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(7),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _photos.length >= 4
                        ? null
                        : _takePhoto,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: Text(tr(context, 'camera')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _photos.length >= 4
                        ? null
                        : _pickGallery,
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text(tr(context, 'gallery')),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _photos.isEmpty ? null : _analyze,
                icon: const Icon(Icons.analytics_outlined),
                label: Text(
                  _photos.isEmpty
                      ? tr(context, 'analyze')
                      : '${tr(context, 'analyze')} ${_photos.length} ${_photos.length == 1 ? 'Photo' : 'Photos'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
            ),
          ),

          if (_analyzing)
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: Card(
                    margin: const EdgeInsets.all(28),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 26,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 18),
                          Text(
                            'Analyzing crop...',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Please wait a moment.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/* ============================================================
   DIAGNOSIS
   ============================================================ */

class DiagnosisPage extends StatelessWidget {
  final List<XFile> photos;

  const DiagnosisPage({
    super.key,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            if (photos.isNotEmpty)
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: photos.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(photos[index].path),
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.14),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orange,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            tr(context, 'early_blight'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tr(context, 'tomato'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tr(context, 'confidence'),
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Divider(),
                    const SizedBox(height: 15),
                    const Text(
                      'Suggested next steps:',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _Recommendation(
                      text: tr(context, 'remove_leaves'),
                    ),
                    _Recommendation(
                      text: tr(context, 'spacing'),
                    ),
                    _Recommendation(
                      text: tr(context, 'water_soil'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TreatmentPage(),
                    ),
                  );
                },
                child: Text(
                  tr(context, 'view_treatment'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PreviewPage(),
                  ),
                );
              },
              child: Text(tr(context, 'scan_again')),
            ),
          ],
        ),
      ),
    );
  }
}

class _Recommendation extends StatelessWidget {
  final String text;

  const _Recommendation({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/* ============================================================
   TREATMENT
   ============================================================ */

class TreatmentPage extends StatelessWidget {
  const TreatmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'treatment')),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.eco,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tomato',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 19,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Early Blight'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SectionTitle(tr(context, 'immediate')),
            _TreatmentItem(
              number: '1',
              text: tr(context, 'remove_leaves'),
            ),
            _TreatmentItem(
              number: '2',
              text: tr(context, 'spacing'),
            ),
            _TreatmentItem(
              number: '3',
              text: tr(context, 'water_soil'),
            ),
            const SizedBox(height: 20),
            SectionTitle(tr(context, 'prevention')),
            _Bullet(text: tr(context, 'keep_clean')),
            _Bullet(text: tr(context, 'sunlight')),
            _Bullet(text: tr(context, 'monitor')),
            const SizedBox(height: 18),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.65),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tr(context, 'safety'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PreviewPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: Text(
                  tr(context, 'scan_another'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TreatmentItem extends StatelessWidget {
  final String number;
  final String text;

  const _TreatmentItem({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/* ============================================================
   SOIL ADVISOR
   ============================================================ */

class SoilAdvisorPage extends StatefulWidget {
  const SoilAdvisorPage({super.key});

  @override
  State<SoilAdvisorPage> createState() => _SoilAdvisorPageState();
}

class _SoilAdvisorPageState extends State<SoilAdvisorPage> {
  final _ph = TextEditingController();
  final _n = TextEditingController();
  final _p = TextEditingController();
  final _k = TextEditingController();

  String _analysisMode = 'soil';
  String? _soilType;
  String? _soilColor;

  String _result =
      'Choose soil details, NPK values, or both. NPK is optional.';

  final List<String> _soilTypes = [
    'Black Soil',
    'Red Soil',
    'Alluvial Soil',
    'Sandy Soil',
    'Loamy Soil',
    'Clay Soil',
  ];

  final List<String> _soilColors = [
    'Black',
    'Dark Brown',
    'Brown',
    'Red',
    'Reddish Brown',
    'Yellow/Brown',
  ];

  bool get _hasNpk {
    return _n.text.trim().isNotEmpty ||
        _p.text.trim().isNotEmpty ||
        _k.text.trim().isNotEmpty ||
        _ph.text.trim().isNotEmpty;
  }

  bool get _hasSoilDetails {
    return _soilType != null || _soilColor != null;
  }

  void _recommend() {
    final hasSoil = _hasSoilDetails;
    final hasNpk = _hasNpk;

    if (!hasSoil && !hasNpk) {
      setState(() {
        _result =
            'Please enter either Soil Type/Color or NPK values. You do not need to enter both.';
      });
      return;
    }

    final parts = <String>[];

    // Soil-detail recommendations.
    if (hasSoil) {
      final type = _soilType ?? 'soil type not selected';
      final color = _soilColor ?? 'soil color not selected';

      String crops;
      String management;

      switch (_soilType) {
        case 'Black Soil':
          crops = 'Cotton, soybean, wheat, sorghum and pulses can be considered.';
          management =
              'Black soil generally retains moisture well. Maintain drainage, avoid waterlogging, and add organic matter when needed.';
          break;
        case 'Red Soil':
          crops = 'Groundnut, pulses, millets, maize and some vegetables can be considered.';
          management =
              'Red soil may benefit from organic matter and balanced fertilization. Maintain moisture without overwatering.';
          break;
        case 'Alluvial Soil':
          crops = 'Rice, wheat, maize, sugarcane, pulses and vegetables can be considered.';
          management =
              'Alluvial soil can support many crops. Maintain soil organic matter and use balanced nutrients based on testing.';
          break;
        case 'Sandy Soil':
          crops = 'Groundnut, watermelon, melon, carrot and other suitable well-drained crops can be considered.';
          management =
              'Sandy soil drains quickly. Add organic matter and manage irrigation in smaller, timely applications.';
          break;
        case 'Loamy Soil':
          crops = 'Vegetables, wheat, maize, pulses and many field crops can be considered.';
          management =
              'Loamy soil is generally versatile. Maintain organic matter, drainage and balanced nutrients.';
          break;
        case 'Clay Soil':
          crops = 'Rice, wheat and crops suited to heavier soils can be considered.';
          management =
              'Improve drainage and soil structure with organic matter. Avoid working very wet clay soil.';
          break;
        default:
          crops = 'Select a soil type for more specific crop suggestions.';
          management =
              'Use a soil test when available for precise nutrient recommendations.';
      }

      parts.add(
        'SOIL DETAILS\n'
        'Type: $type\n'
        'Color: $color\n\n'
        'SUITABLE CROPS\n$crops\n\n'
        'SOIL NEEDS\n$management',
      );

      if (_soilColor == 'Black' || _soilColor == 'Dark Brown') {
        parts.add(
          'COLOR NOTE\n'
          'Dark soil can often indicate higher organic matter, but color alone cannot determine fertility. A soil test gives more reliable nutrient information.',
        );
      } else if (_soilColor == 'Red' || _soilColor == 'Reddish Brown') {
        parts.add(
          'COLOR NOTE\n'
          'Reddish soil commonly reflects iron-rich conditions. Soil color alone is not enough to determine nutrient status.',
        );
      }
    }

    // Optional NPK/pH recommendations.
    if (hasNpk) {
      final n = double.tryParse(_n.text.trim());
      final p = double.tryParse(_p.text.trim());
      final k = double.tryParse(_k.text.trim());
      final ph = double.tryParse(_ph.text.trim());

      final nutrientNotes = <String>[];

      if (n != null) {
        nutrientNotes.add(
          n < 40
              ? 'Nitrogen looks low in this demo assessment.'
              : 'Nitrogen is entered at $n.',
        );
      }

      if (p != null) {
        nutrientNotes.add(
          p < 20
              ? 'Phosphorus looks low in this demo assessment.'
              : 'Phosphorus is entered at $p.',
        );
      }

      if (k != null) {
        nutrientNotes.add(
          k < 30
              ? 'Potassium looks low in this demo assessment.'
              : 'Potassium is entered at $k.',
        );
      }

      if (ph != null) {
        nutrientNotes.add(
          ph < 5.5
              ? 'The entered pH is acidic.'
              : ph > 7.5
                  ? 'The entered pH is alkaline.'
                  : 'The entered pH is in a broadly suitable range for many crops.',
        );
      }

      parts.add(
        'NPK / pH DETAILS\n'
        '${nutrientNotes.isEmpty ? 'Enter valid N, P, K or pH values for nutrient guidance.' : nutrientNotes.join('\n')}\n\n'
        'NUTRIENT GUIDANCE\n'
        'Use a soil-test-based fertilizer recommendation where possible. Avoid applying large amounts of fertilizer only from a visual estimate.',
      );
    }

    parts.add(
      'IMPORTANT\n'
      'These are general demo recommendations. Soil testing and local agricultural guidance should be used for exact fertilizer rates and crop selection.',
    );

    setState(() {
      _result = parts.join('\n\n');
    });
  }

  @override
  void dispose() {
    _ph.dispose();
    _n.dispose();
    _p.dispose();
    _k.dispose();
    super.dispose();
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    String? hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _modeButton(
    String value,
    String title,
    IconData icon,
  ) {
    final selected = _analysisMode == value;

    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            _analysisMode = value;
          });
        },
        icon: Icon(icon),
        label: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            width: selected ? 2 : 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showSoil = _analysisMode == 'soil' || _analysisMode == 'both';
    final showNpk = _analysisMode == 'npk' || _analysisMode == 'both';

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'soil_title')),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text(
              'Choose how you want to analyze your soil. NPK values are optional.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _modeButton(
                  'soil',
                  'Soil Details',
                  Icons.landscape_outlined,
                ),
                const SizedBox(width: 8),
                _modeButton(
                  'npk',
                  'NPK',
                  Icons.science_outlined,
                ),
                const SizedBox(width: 8),
                _modeButton(
                  'both',
                  'Both',
                  Icons.auto_awesome,
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (showSoil) ...[
              SectionTitle('Soil Type & Color'),

              DropdownButtonFormField<String>(
                value: _soilType,
                decoration: const InputDecoration(
                  labelText: 'Soil Type',
                ),
                items: _soilTypes
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _soilType = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _soilColor,
                decoration: const InputDecoration(
                  labelText: 'Soil Color',
                ),
                items: _soilColors
                    .map(
                      (color) => DropdownMenuItem(
                        value: color,
                        child: Text(color),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _soilColor = value;
                  });
                },
              ),

              const SizedBox(height: 20),
            ],

            if (showNpk) ...[
              SectionTitle('NPK & pH (Optional)'),
              Text(
                'You can enter any available values. You do not need all four.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),

              _field('Soil pH (optional)', _ph, hint: 'e.g. 6.5'),
              const SizedBox(height: 12),
              _field('Nitrogen N (optional)', _n, hint: 'e.g. 70'),
              const SizedBox(height: 12),
              _field('Phosphorus P (optional)', _p, hint: 'e.g. 40'),
              const SizedBox(height: 12),
              _field('Potassium K (optional)', _k, hint: 'e.g. 50'),

              const SizedBox(height: 20),
            ],

            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _recommend,
                icon: const Icon(Icons.agriculture_outlined),
                label: const Text(
                  'Get Soil Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, 'recommendation'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _result,
                      style: const TextStyle(height: 1.45),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================================================
   CHAT
   ============================================================ */

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [];

  bool _welcomeAdded = false;
  bool _typing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Safe place to use tr(context,...).
    if (!_welcomeAdded) {
      _messages.add(
        _ChatMessage(
          text: tr(context, 'chat_welcome'),
          isUser: false,
        ),
      );

      _welcomeAdded = true;
    }
  }

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty || _typing) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: text,
          isUser: true,
        ),
      );

      _controller.clear();
      _typing = true;
    });

    _scrollToBottom();

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        if (!mounted) return;

        setState(() {
          _typing = false;
          _messages.add(
            _ChatMessage(
              text:
                  'Based on your question, please check the affected crop carefully. For the demo, you can also use Detect Disease to scan a crop image.',
              isUser: false,
            ),
          );
        });

        _scrollToBottom();
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'chat_title')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length + (_typing ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_typing && index == _messages.length) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 13,
                          ),
                          child: SizedBox(
                            width: 38,
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                  }

                  final message = _messages[index];

                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.78,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser
                              ? Colors.white
                              : null,
                          height: 1.35,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                12,
                8,
                12,
                10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withValues(alpha: 0.06),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: tr(context, 'chat_hint'),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _typing ? null : _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================================================
   ALERTS
   ============================================================ */

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'alerts_title')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cloud_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weather Watch',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Keep monitoring field conditions and avoid unnecessary leaf wetness.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.eco_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Crop Monitoring',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Regularly inspect leaves for spots, discoloration and other changes.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
