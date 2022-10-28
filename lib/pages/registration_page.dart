import 'dart:io';

import 'package:blood_donation/pages/login_page.dart';
import 'package:blood_donation/providers/user_provder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/custom_clipper.dart';
import '../utils/helper_functions.dart';
import 'donor_list_page.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final areaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedBloodGroupType;
  DateTime? dateOfBirth;
  DateTime? lastDonationDate;
  String? imagePath;
  int? id;
  bool? status;
  bool _isObscure = true;
  bool termsAndCondition = false;
  String errMsg = '';
  bool isLogin = true;
  late UserProvider userProvider;
  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int?;
    userProvider = Provider.of<UserProvider>(context, listen: false);
  /*  if(id != null) {
      final user = userProvider.getItem(id!);
      _setData(user);
    }*/
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Create Your Account*',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipPath(
            clipper: MyCustomClipperForAppBar(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade700,
                      Colors.red.shade200,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.clamp,
                  )),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
    child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      labelText: 'Enter your Phone number',
                      hintText: 'Enter your Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Enter your email',
                      labelText: 'Enter your email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      labelText: 'Enter your password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 1,
                          ))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.bloodtype),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1))),
                    hint: const Text('Select Your Blood Group'),
                    items: bloodGroupType
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e!)))
                        .toList(),
                    value: selectedBloodGroupType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a type';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroupType = value;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: selectDate,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Select Date of Birth'),
                    ),
                    Text(dateOfBirth == null
                        ? 'No date chosen'
                        : getFormattedDate(dateOfBirth!, 'dd/MM/yyyy'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: selectLastDonationDate,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Select Last Donation Date'),
                    ),
                    Text(lastDonationDate == null
                        ? 'No date chosen'
                        : getFormattedDate(lastDonationDate!, 'dd/MM/yyyy'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: areaController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.add_location),
                      hintText: 'Enter your area',
                      labelText: 'Enter your area',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imagePath == null
                        ? const Icon(
                            Icons.movie,
                            size: 100,
                          )
                        : Image.file(
                            File(imagePath!),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    TextButton.icon(
                      onPressed: getImage,
                      icon: const Icon(Icons.photo),
                      label: const Text('Select from Gallery'),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: termsAndCondition,
                      onChanged: (bool? value) {
                        setState(() {
                          termsAndCondition = value!;
                        });
                      }),
                  const Text('I agree to the '),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Terms and Conditions'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    minimumSize: const Size(150, 35),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    _authenticate();
                    Navigator.pushReplacementNamed(context, DonorListPage.routeName);
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'Already have an account?',
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(150, 35),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: const Text('Sign In from here'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
        ),
      ),
    );
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dateOfBirth = selectedDate;
      });
    }
  }
  void selectLastDonationDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        lastDonationDate = selectedDate;
      });
    }
  }
  void getImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }
  _authenticate() async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    if(_formKey.currentState!.validate()) {
          final user = UserModel(
            name: nameController.text,
            mobile: mobileController.text,
            email: emailController.text,
            password: passwordController.text,
            area: areaController.text,
            lastDonationDate: getFormattedDate(lastDonationDate!, 'dd/MM/yyyy'),
            dateOfBirth: getFormattedDate(dateOfBirth!, 'dd/MM/yyyy'),
            image: imagePath!,
            status: false,
            bloodGroup: selectedBloodGroupType!, isAdmin: false,
          );


          final rowId = await provider.insertUser(user);
          print(rowId.toString());
          await setLoginStatus(true);
          await setUserId(rowId);
          if(mounted) Navigator.pushReplacementNamed(context, DonorListPage.routeName);


    }
  }

  _setErrorMsg(String msg) {
    setState(() {
      errMsg = msg;
    });
  }

  void _setData(UserModel user) {

    nameController.text = user.name!;
    mobileController.text = user.mobile!;
    areaController.text = user.area!;
    imagePath = user.image;
    lastDonationDate = DateFormat('dd/MM/yyyy').parse(user.lastDonationDate!);
    dateOfBirth = DateFormat('dd/MM/yyyy').parse(user.dateOfBirth!);
    selectedBloodGroupType = user.bloodGroup;

  }



}
