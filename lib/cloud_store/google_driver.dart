// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';

class GoogleDrive {
  static GoogleSignIn googleSignIn = GoogleSignIn.standard(scopes: [ga.DriveApi.driveFileScope]);

  static Future<ga.DriveApi?> getDriveApi(context) async {
    final googleUser = await googleSignIn.signIn();
    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      await snackBar(context, "Sign-in first");
      return null;
    }

    final client = GoogleAuthClient(headers);
    final driveApi = ga.DriveApi(client);
    return driveApi;
  }

  static Future<void> showList(context) async {
    final driveApi = await getDriveApi(context);
    if (driveApi == null) {
      return;
    }

    final fileList = await driveApi.files.list(spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
    final files = fileList.files;
    if (files == null) {
      return snackBar(
        context,
        "Data not found",
      );
    }

    final alert = AlertDialog(
      title: Text("Item List"),
      content: SingleChildScrollView(
        child: ListBody(
          children: files.map((e) => Text(e.name ?? "no-name")).toList(),
        ),
      ),
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  static Future<String?> getFolderId(ga.DriveApi? driveApi, context, {String? foldName}) async {
    const mimeType = "application/vnd.google-apps.folder";
    String? folderName = foldName;

    try {
      final found = await driveApi!.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        snackBar(context, "Sign-in first");
        return null;
      }

      // The folder already exists
      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder = ga.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print("_getFolderId error $e");
      return null;
    }
  }

  static Future<ga.File> getParentFolderId(ga.DriveApi? drive, context, {String? foldName}) async {
    const parentFolderName = "skendy";

    // Search for the parent folder by name
    const query = "mimeType='application/vnd.google-apps.folder' and trashed = false and name = '$parentFolderName'";
    final list = await drive!.files.list(q: query);

    // Check if the parent folder exists
    if (list.files!.isNotEmpty) {
      // Get the ID of the first folder in the list (assumes there's only one folder with that name)
      final parentFolderId = list.files!.first;

      return parentFolderId;
    } else {
      // Parent folder does not exist, create it first
      final parentFolder = ga.File();
      parentFolder.name = parentFolderName;
      parentFolder.mimeType = "application/vnd.google-apps.folder";
      final newParentFolder = await drive.files.create(parentFolder);
      return newParentFolder;

    }
  }

  static Future<String?> createChildFolder(
    context,
    ga.DriveApi? drive,
    ga.File parentFolder,
    String foldName,
  ) async {
    final childFolderName = foldName;
    final childQuery =
        "mimeType='application/vnd.google-apps.folder' and trashed = false and name = '$childFolderName' and '${parentFolder.id}' in parents";
    final childList = await drive!.files.list(q: childQuery);
    // Check if the child folder exists
    if (childList.files!.isNotEmpty) {
      // Child folder already exists
      print("Folder already exists with ID: ${childList.files!.first.id}");
      return childList.files!.first.id;
    } else {
      // Child folder does not exist, create it
      final folder = ga.File();
      folder.name = childFolderName;
      folder.parents = [parentFolder.id!];
      folder.mimeType = "application/vnd.google-apps.folder";
      final newFolder = await drive.files.create(folder);
      print("Folder created with ID: ${newFolder.id}");
      return newFolder.id;
    }
  }

  static Future<void> uploadToNormal(context) async {
    ga.DriveApi? drive = await getDriveApi(context);
    try {
      // Check if the folder exists. If it doesn't exist, create it and return the ID.
      final folderId = await getFolderId(drive!, context);
      if (folderId == null) {
        await snackBar(context, "Failure");
        return;
      }

      ga.File fileToUpload = ga.File();

      FilePickerResult? file = await FilePicker.platform.pickFiles(withReadStream: true);
      fileToUpload.parents = [folderId];

      // Upload
      fileToUpload.name = path.basename(file!.files.first.path!);
      print("NAME");
      print("QWERTY : ${file.files.first}");
      var response = await drive.files.create(
        fileToUpload,
        uploadMedia: ga.Media(File(file.files.first.path!).openRead(), File(file.files.first.path!).lengthSync()),
      );
      print("QWERTY : WERT : ${response},");
      showList(context);
      print("response: $response");

      // simulate a slow process
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      // Remove a dialog
      Navigator.pop(context);
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = new FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.standard(scopes: [ga.DriveApi.driveFileScope]);
  GoogleSignInAccount? googleSignInAccount;
  ga.FileList? list;
  bool signedIn = false;

  Future<void> _loginWithGoogle() async {
    signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? googleSignInAccount) async {
      if (googleSignInAccount != null) {
        _afterGoogleLogin(googleSignInAccount);
      }
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently().whenComplete(() => () {});
      } catch (e) {
        storage.write(key: "signedIn", value: "false").then((value) {
          setState(() {
            signedIn = false;
          });
        });
      }
    } else {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      _afterGoogleLogin(googleSignInAccount!);
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    assert(!user!.isAnonymous);

    final User currentUser = _auth.currentUser!;
    assert(user!.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    storage.write(key: "signedIn", value: "true").then((value) {
      setState(() {
        signedIn = true;
      });
    });
  }

  void _logoutFromGoogle() async {
    googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage.write(key: "signedIn", value: "false").then((value) {
        setState(() {
          signedIn = false;
        });
      });
    });
  }

  Future<ga.DriveApi?> _getDriveApi() async {
    final googleUser = await googleSignIn.signIn();
    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      await snackBar(context, "Sign-in first");
      return null;
    }

    final client = GoogleAuthClient(headers);
    final driveApi = ga.DriveApi(client);
    return driveApi;
  }

  Future<void> _showList() async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      return;
    }

    final fileList = await driveApi.files.list(spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
    final files = fileList.files;
    if (files == null) {
      return snackBar(
        context,
        "Data not found",
      );
    }

    final alert = AlertDialog(
      title: Text("Item List"),
      content: SingleChildScrollView(
        child: ListBody(
          children: files.map((e) => Text(e.name ?? "no-name")).toList(),
        ),
      ),
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  Future<String?> _getFolderId(ga.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "skendy";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        snackBar(context, "Sign-in first");
        return null;
      }

      // The folder already exists
      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder = ga.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print("_getFolderId error $e");
      return null;
    }
  }

  Future<void> _uploadToNormal() async {
    var client = GoogleAuthClient(await googleSignInAccount!.authHeaders);
    var drive = ga.DriveApi(client);
    try {
      // Check if the folder exists. If it doesn't exist, create it and return the ID.
      final folderId = await _getFolderId(drive);
      if (folderId == null) {
        await snackBar(
          context,
          "Failure",
        );
        return;
      }

      ga.File fileToUpload = ga.File();

      FilePickerResult? file = await FilePicker.platform.pickFiles(withReadStream: true);
      fileToUpload.parents = [folderId];

      // Upload
      fileToUpload.name = path.basename(file!.files.first.path!);
      print("NAME");
      print("QWERTY : ${file.files.first}");
      var response = await drive.files.create(
        fileToUpload,
        uploadMedia: ga.Media(File(file.files.first.path!).openRead(), File(file.files.first.path!).lengthSync()),
      );
      print("QWERTY : WERT : ${response},");
      _showList();
      print("response: $response");

      // simulate a slow process
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      // Remove a dialog
      Navigator.pop(context);
    }
  }

  _uploadFileToGoogleDrive() async {
    try {
      print("Entered upload file");
      var client = GoogleAuthClient(await googleSignInAccount!.authHeaders);
      var drive = ga.DriveApi(client);
      ga.File fileToUpload = ga.File();

      FilePickerResult? file = await FilePicker.platform.pickFiles(withReadStream: true);
      fileToUpload.parents = ["appDataFolder"];
      print("Parent passed");
      fileToUpload.name = path.basename(file!.files.first.path!);
      print("NAME");
      print("QWERTY : ${file.files.first}");
      var response = await drive.files.create(
        fileToUpload,
        uploadMedia: ga.Media(File(file.files.first.path!).openRead(), File(file.files.first.path!).lengthSync()),
      );
      print("QWERTY : WERT : ${response},");
      _showList();
    } catch (e) {
      print("ERROR : ${e.toString()}");
    }
  }

  Future<void> _listGoogleDriveFiles() async {
    var client = GoogleAuthClient(await googleSignInAccount!.authHeaders);
    var drive = ga.DriveApi(client);
    drive.files.list(spaces: 'appDataFolder').then((value) {
      setState(() {
        list = value;
      });
      for (var i = 0; i < list!.files!.length; i++) {
        print("Id: ${list!.files![i].id} File Name:${list!.files![i].name}");
      }
    });
  }

  Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleAuthClient(await googleSignInAccount!.authHeaders);
    var drive = ga.DriveApi(client);
    ga.Media? file = (await drive.files.get(gdID, downloadOptions: ga.DownloadOptions.fullMedia)) as ga.Media?;
    print(file!.stream);

    final directory = await getExternalStorageDirectory();
    print(directory!.path);
    final saveFile = File('${directory.path}/${new DateTime.now().millisecondsSinceEpoch}$fName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      print("Task Done");
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error");
    });
  }

  List<Widget> generateFilesWidget() {
    List<Widget> listItem = [];
    if (list != null) {
      for (var i = 0; i < list!.files!.length; i++) {
        listItem.add(Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.05,
              child: Text('${i + 1}'),
            ),
            Expanded(
              child: Text(list!.files![i].name!),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
                child: const Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _downloadGoogleDriveFile(list!.files![i].name!, list!.files![i].id!);
                },
              ),
            ),
          ],
        ));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text("REFERESH"),
              onPressed: () {
                setState(() {
                  _showList();
                });
              },
            ),
            (signedIn
                ? TextButton(
                    child: const Text('Upload File to Google Drive'),
                    onPressed: _uploadToNormal,
                  )
                : Container()),
            (signedIn
                ? TextButton(
                    child: const Text('List Google Drive Files'),
                    onPressed: _listGoogleDriveFiles,
                  )
                : Container()),
            (signedIn
                ? Expanded(
                    flex: 10,
                    child: Column(
                      children: generateFilesWidget(),
                    ),
                  )
                : Container()),
            (signedIn
                ? TextButton(
                    child: const Text('Google Logout'),
                    onPressed: _logoutFromGoogle,
                  )
                : TextButton(
                    child: const Text('Google Login'),
                    onPressed: _loginWithGoogle,
                  )),
          ],
        ),
      ),
    );
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
