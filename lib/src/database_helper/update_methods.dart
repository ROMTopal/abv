import 'package:skendy/src/constants/theme_constant.dart';
import 'package:skendy/src/database_helper/database_helper.dart';

Map<String, dynamic> updateTheme(bool theme) {
  return {DatabaseHelper.fieldTheme: theme ? ThemeConstant.darkTheme : ThemeConstant.lightTheme};
}

Map<String, dynamic> updateAppLanguage(String language) {
  return {DatabaseHelper.fieldAppLanguage: language};
}

Map<String, dynamic> updateOcrLanguage(String language) {
  return {DatabaseHelper.fieldOcrLanguage: language};
}

Map<String, dynamic> updateAutoDelete(bool value) {
  return {DatabaseHelper.fieldAutoDelete: value};
}

Map<String, dynamic> updateAutoDocDetection(bool value) {
  return {DatabaseHelper.fieldAutomaticDocumentDetection: value};
}

Map<String, dynamic> updateEmailNotifications(bool value) {
  return {DatabaseHelper.fieldEmailNotification: value};
}

Map<String, dynamic> updateAppNotifications(bool value) {
  return {DatabaseHelper.fieldAppNotifications: value};
}

Map<String, dynamic> updateTime() {
  return {DatabaseHelper.fieldUpdatedTimestamp: DateTime.now()};
}

Map<String, dynamic> updateUserPrefIdInUser(String upId) {
  return {DatabaseHelper.fieldUserPreferencesId: upId};
}
