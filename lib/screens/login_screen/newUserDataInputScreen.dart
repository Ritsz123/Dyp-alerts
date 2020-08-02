import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:dypalerts/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  UserModel user;

  final AuthProvider _authProvider = AuthProvider();

  final DatabaseService _dbService = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _dept;
  String _email;
  DateTime _dateOfBirth;
  String _name;
  String _phone;
  String _studyYear;

  Future updateUserDataInDatabase(UserModel user) async {
    String userID = await _authProvider.getCurrentUID();

    return await _dbService.userCollection.document(userID).setData({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'studyYear': user.studyYear,
      'department': user.collegeDept,
      'dob': user.dob,
    });
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
      successColor: Colors.green,
      inputIcon: Icon(Icons.phone_android),
    );
  }

  Widget _buildInputEmail() {
    return AnimTFF(
      validator: (value) {
        return null;
      },
      inputIcon: Icon(Icons.alternate_email),
      onSave: (value) {
        _email = value;
      },
      initialValue: _email,
      enabled: false,
    );
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
          value: 'comp',
        ),
        DropdownMenuItem<String>(
          child: Text('Information Technology'),
          value: 'IT',
        ),
        DropdownMenuItem<String>(
          child: Text('Electronics & TC'),
          value: 'entc',
        ),
        DropdownMenuItem<String>(
          child: Text('Mechanical'),
          value: 'mech',
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

  @override
  void initState() {
    super.initState();
    _email = "someemail@google.com"; //TODO: initialize
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DYPALERTS'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: screenHeight(context: context, divideBy: 3),
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg.png'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInputName(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildInputPhone(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildInputEmail(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildBirthDateField(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildStudyYear(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildDept(),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          user = UserModel(
                              name: _name,
                              collegeDept: _dept,
                              dob: _dateOfBirth,
                              email: _email,
                              phone: _phone,
                              studyYear: _studyYear);
//                        print("${user.name}");
                        },
                      ),
                    ],
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
