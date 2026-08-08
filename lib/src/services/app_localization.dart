import 'package:expensive_tracker_app/common_exports.dart';

class AppLocalization {
  final String languageCode;

  AppLocalization(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Tracker',
      'transactions': 'Transactions',
      'reports': 'Reports',
      'add': 'Add',
      'expenses': 'Expenses',
      'income': 'Income',
      'total_balance': 'Total Balance',
      'no_expense': 'No expense found, Start adding some!',
      'dashboard': 'Dashboard',
      'theme': 'App Theme',
      'language': 'Language',
      'about': 'About',
      'edit_transaction': 'Edit Transaction',
      'add_transaction': 'Add Transaction',
      'title': 'Title',
      'amount': 'Amount',
      'date': 'Date',
      'category': 'Category',
      'cancel': 'Cancel',
      'save': 'Save',
      'update': 'Update',
      'expense_deleted': 'Expenses deleted',
      'undo': 'Undo',
      'light': 'Light',
      'dark': 'Dark',
    },
    'hi': {
      'app_title': 'ट्रैकर',
      'transactions': 'लेनदेन',
      'reports': 'रिपोर्ट',
      'add': 'जोड़ें',
      'expenses': 'खर्च',
      'income': 'आय',
      'total_balance': 'कुल शेष',
      'no_expense': 'कोई खर्च नहीं मिला, जोड़ना शुरू करें!',
      'dashboard': 'डैशबोर्ड',
      'theme': 'ऐप थीम',
      'language': 'भाषा',
      'about': 'के बारे में',
      'edit_transaction': 'लेनदेन संपादित करें',
      'add_transaction': 'लेनदेन जोड़ें',
      'title': 'शीर्षक',
      'amount': 'राशि',
      'date': 'तारीख',
      'category': 'श्रेणी',
      'cancel': 'रद्द करें',
      'save': 'सहेजें',
      'update': 'अद्यतन करें',
      'expense_deleted': 'खर्च हटा दिया गया',
      'undo': 'पूर्ववत करें',
      'light': 'हल्का',
      'dark': 'गहरा',
    },
    'kn': {
      'app_title': 'ಟ್ರಾಕರ್',
      'transactions': 'ವಹಿವಾಟುಗಳು',
      'reports': 'ವರದಿಗಳು',
      'add': 'ಸೇರಿಸಿ',
      'expenses': 'ವೆಚ್ಚಗಳು',
      'income': 'ಆದಾಯ',
      'total_balance': 'ಒಟ್ಟು ಬಾಕಿ',
      'no_expense': 'ಯಾವುದೇ ವೆಚ್ಚ ಕಂಡುಬಂದಿಲ್ಲ, ಸೇರಿಸಲು ಪ್ರಾರಂಭಿಸಿ!',
      'dashboard': 'ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
      'theme': 'ಥೀಮ್',
      'language': 'ಭಾಷೆ',
      'about': 'ಬಗ್ಗೆ',
      'edit_transaction': 'ವಹಿವಾಟು ಬದಲಾಯಿಸಿ',
      'add_transaction': 'ವಹಿವಾಟು ಸೇರಿಸಿ',
      'title': 'ಶೀರ್ಷಿಕೆ',
      'amount': 'ಮೊತ್ತ',
      'date': 'ದಿನಾಂಕ',
      'category': 'ವರ್ಗ',
      'cancel': 'ರದ್ದುಮಾಡಿ',
      'save': 'ಉಳಿಸಿ',
      'update': 'ಅಪ್‌ಡೇಟ್',
      'expense_deleted': 'ವೆಚ್ಚವನ್ನು ಅಳಿಸಲಾಗಿದೆ',
      'undo': 'ಹಿಂತಿರುಗಿಸು',
      'light': 'ಬೆಳಕು',
      'dark': 'ಕತ್ತಲೆ',
    },
  };

  String translate(String key) {
    return _localizedValues[languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  static AppLocalization of(BuildContext context) {
    final languageCode = context.read<SettingsBloc>().state.languageCode;
    return AppLocalization(languageCode);
  }
}

extension LocalizationExtension on BuildContext {
  String l10n(String key) => AppLocalization.of(this).translate(key);
}
