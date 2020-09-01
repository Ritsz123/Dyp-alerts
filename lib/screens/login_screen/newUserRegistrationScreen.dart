import 'package:dypalerts/commonWidgets/customImagePicker.dart';
import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/screens/home_screen/newHomeScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:dypalerts/commonWidgets/background.dart';
import 'package:dypalerts/commonWidgets/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'package:loading_overlay/loading_overlay.dart';

class NewUserRegScreen extends StatefulWidget {
  final bool showPopUp;
  NewUserRegScreen({this.showPopUp});
  @override
  _NewUserRegScreenState createState() => _NewUserRegScreenState();
}

class _NewUserRegScreenState extends State<NewUserRegScreen> {
  Widget formSpace = SizedBox(height: 10);
  bool isLoading = false;
  var txtController = TextEditingController();
  UserModel user;

  final AuthProvider _authProvider = AuthProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _dateOfBirth;
  String _dept;
  String _email;

  File _imageFile;
  String _name;
  String _phone;
  String _profileUrl;
  String _studyYear;

  Future<UserModel> createUser() async {
    String userID = await _authProvider.getCurrentUserID();
    user = UserModel(
      dept: _dept,
      dob: _dateOfBirth,
      email: _email,
      name: _name,
      phone: _phone,
      profileUrl: _profileUrl,
      studyYear: _studyYear,
      uid: userID,
    );
    return user;
  }

  void showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Continue where you left off',
        ),
      ),
    );
  }

  Widget _buildProfilePic() {
    return GestureDetector(
      onTap: () async {
        CustomImagePicker imagePicker = CustomImagePicker();
        _imageFile = await imagePicker.pickImage();
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          CircleAvatar(
            radius: screenHeight(context: context, divideBy: 10),
            backgroundImage: _imageFile != null
                ? FileImage(File(_imageFile.path))
                : AssetImage('assets/images/profile_default.png'),
          ),
          _imageFile == null
              ? Text(
                  'Click to add profile',
                  style: TextStyle(color: Colors.blueGrey),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildInputName() {
    return AnimTFF(
      inputIcon: Icon(Icons.person),
      labelText: 'Name',
      validator: (value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Name is required';
        } else if (!value.contains(" ")) {
          return 'Please enter full name';
        }
        return null;
      },
      onSave: (value) {
        _name = value;
      },
    );
  }

  Widget _buildInputPhone() {
    return AnimTFF(
      keyboardType: TextInputType.number,
      labelText: 'Phone',
      validator: (value) {
        if (value.isEmpty) {
          return 'Phone is required';
        } else if (value.length != 10) {
          return 'Phone Number should be of 10 digits';
        }
        return null;
      },
      onSave: (value) {
        setState(() {
          _phone = value;
        });
      },
      successColor: Colors.green,
      inputIcon: Icon(Icons.phone_android),
    );
  }

  Widget _buildInputEmail() {
    return AnimTFF(
      controller: txtController,
      validator: (value) {
        return null;
      },
      inputIcon: Icon(Icons.alternate_email),
      onSave: (value) {
        _email = value;
      },
      enabled: false,
    );
  }

  //for getting initial email value
  void getEmail() {
    checkEmail().then((value) => txtController.text = value);
  }

  Future<String> checkEmail() async {
    FirebaseUser user = await AuthProvider().getCurrentUser();
    return user.email;
  }

  Widget _buildStudyYear() {
    return DropdownButtonFormField<String>(
      value: _studyYear,
      validator: (String val) {
        if (val == null) return 'year must be selected';
        return null;
      },
      hint: Text('Select Year of study'),
      onChanged: (value) {
        _studyYear = value;
      },
      items: [
        DropdownMenuItem<String>(
          child: Text('FE'),
          value: 'FE',
        ),
        DropdownMenuItem<String>(
          child: Text('SE'),
          value: 'SE',
        ),
        DropdownMenuItem<String>(
          child: Text('TE'),
          value: 'TE',
        ),
        DropdownMenuItem<String>(
          child: Text('BE'),
          value: 'BE',
        ),
      ],
    );
  }

  Widget _buildDept() {
    return DropdownButtonFormField<String>(
      value: _dept,
      validator: (String value) {
        if (value == null) {
          return 'Department must be selected';
        }
        return null;
      },
      hint: Text('Select Department'),
      onChanged: (value) {
        _dept = value;
      },
      items: [
        DropdownMenuItem<String>(
          child: Text('Computer'),
          value: 'Comp',
        ),
        DropdownMenuItem<String>(
          child: Text('Information Technology'),
          value: 'IT',
        ),
        DropdownMenuItem<String>(
          child: Text('Electronics & TC'),
          value: 'EnTC',
        ),
        DropdownMenuItem<String>(
          child: Text('Mechanical'),
          value: 'Mech',
        ),
      ],
    );
  }

  Widget _buildBirthDateField() {
    return DateTimeField(
      decoration: InputDecoration(
        hintText: 'Select BirthDate',
      ),
      validator: (time) {
        if (time == null)
          return 'Please Select your birthdate';
        else
          return null;
      },
      onSaved: (time) {
        _dateOfBirth = time;
      },
      format: DateFormat("dd/MMM/yyyy"),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime(2000),
            firstDate: DateTime(1990),
            lastDate: DateTime(2010));
      },
    );
  }

  Future<bool> _onBackPressed() async {
    return false;
    //returning false will prevent backpress operation
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.showPopUp != null && widget.showPopUp) {
    //   showSnackBar();
    // }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('DYPALERTS'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: isLoading,
          child: Stack(
            children: [
              BackgroundContainer(),
              SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildProfilePic(),
                          formSpace,
                          _buildInputName(),
                          formSpace,
                          _buildInputPhone(),
                          formSpace,
                          _buildInputEmail(),
                          formSpace,
                          _buildBirthDateField(),
                          formSpace,
                          _buildStudyYear(),
                          formSpace,
                          _buildDept(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();
            setState(() {
              isLoading = true;
            });
            user = await createUser(); //locally create user
            final DatabaseService _dbService = DatabaseService(uid: user.uid);
            if (_imageFile != null) {
              String imageUrl = await _dbService.uploadImage(file: _imageFile);
              setState(() {
                _profileUrl = imageUrl;
                user.profileUrl = _profileUrl; //setting user profile url
              });
            }
            await _dbService.updateUserDataInDatabase(user); //put user data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewHomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
