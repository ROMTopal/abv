import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHelper {
  static String collectionUsers = "users";
  static String collectionCustomCategory = "customCategory";
  static String collectionManagedCategory = "managed_category";
  static String collectionUserPreferences = "user_preferences";
  static String collectionScannedDocuments = "scanned_documents";
  static String collectionDocumentPredications = "document_predictions";
  static String collectionNotifications = "notifications";

  static String fieldId = "id";
  static String fieldCreatedTimestamp = "createdTimestamp";
  static String fieldUpdatedTimestamp = "updatedTimestamp";
  static String fieldAddress = "address";
  static String fieldPhoneNumber = "phoneNumber";
  static String fieldCustomCategories = "customCategories";
  static String fieldUserId = "userId";
  static String fieldUser = "user";
  static String fieldTheme = "theme";
  static String fieldEmailNotification = "emailNotification";
  static String fieldAppLanguage = "appLanguage";
  static String fieldOcrLanguage = "ocrLanguage";
  static String fieldAutoDelete = "autoDelete";
  static String fieldAppNotifications = "appNotifications";
  static String fieldAutomaticDocumentDetection = "automaticDocumentDetection";
  static String fieldName = "name";
  static String fieldKeywords = "keywords";
  static String fieldDelete = "delete";
  static String fieldIconName = "iconName";
  static String fieldType = "type";
  static String fieldExtractedFields = "extractedFields";
  static String fieldReceiver = "receiver";
  static String fieldFriendlyName = "friendlyName";
  static String fieldMetadata = "metadata";
  static String fieldTbd = "tbd";
  static String fieldParameters = "parameters";
  static String fieldUserPreferencesId = "userPreferencesId";

  static Future<void> addUserToFirestore(User user) async {
    print("addUserTO firebase called");
    Map<String, dynamic> map = {
      fieldId: user.uid,
      fieldCreatedTimestamp: DateTime.now(),
      fieldUpdatedTimestamp: DateTime.now(),
      fieldAddress: "",
      fieldPhoneNumber: "",
      fieldUserPreferencesId: "",
      fieldCustomCategories: []
    };
    DocumentReference doc = FirebaseFirestore.instance.collection(collectionUsers).doc(user.uid);
    await doc.set(map);
    print("user added to firebase");
    await updateUserPreference(user);
    await FirebaseFirestore.instance.collection(collectionUserPreferences).where(fieldUserId,isEqualTo: user.uid).get().then((value){
      for (var element in value.docs) {
        FirebaseFirestore.instance.collection(collectionUsers).doc(user.uid).update({fieldUserPreferencesId:element.id});
      }
    });
  }

  static Future<void> updateUserPreference(User user) async {
    Map<String, dynamic> map = {
      fieldUserId: user.uid,
      fieldUser: FirebaseFirestore.instance.collection(collectionUsers).doc(user.uid),
      fieldTheme: 'LIGHT',
      fieldEmailNotification: false,
      fieldAppLanguage: "DUTCH",
      fieldOcrLanguage: "DUTCH",
      fieldAutoDelete: false,
      fieldAppNotifications: false,
      fieldAutomaticDocumentDetection: true,
      fieldCreatedTimestamp: DateTime.now()
    };

    print("updateUserPreference:: $map");
    DocumentReference doc = FirebaseFirestore.instance.collection(collectionUserPreferences).doc(user.uid);
    await doc.set(map);
    print("updateUserPreference updated");
  }

  static  Future<void> updateUserPrefParticularValue(User user,Map<String,dynamic> map)async{

    FirebaseFirestore.instance.collection(collectionUserPreferences).doc(user.uid).update(map);
  }

  static  Future<void> addCategory(User user,Map<String,dynamic> map)async{
    FirebaseFirestore.instance.collection(collectionUsers).doc(user.uid).update({
      fieldCustomCategories: FieldValue.arrayUnion([map])
    });
  }


  static Future<void> updateUserProfile(User? user,Map<String,dynamic> map)
  async{
    FirebaseFirestore.instance.collection(collectionUserPreferences).where(fieldUserId,isEqualTo: user!.uid).get().then((value){
      for (var element in value.docs) {
        FirebaseFirestore.instance.collection(collectionUserPreferences).doc(element.id).update(map);
      }
    });
  }

}
