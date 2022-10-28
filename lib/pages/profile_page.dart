import 'dart:io';
import 'package:blood_donation/models/user_reviews_model.dart';
import 'package:blood_donation/providers/user_provder.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../customwidgets/all_comments_widget.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/custom_clipper.dart';
import '../utils/helper_functions.dart';
import 'launcher_page.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int id;
  late String name;
  late UserProvider userProvider;
  final focusNode = FocusNode();
  TextEditingController reviewTextController = TextEditingController();
  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    userProvider = Provider.of<UserProvider>(context, listen: false);
    id = argList[0];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setLoginStatus(false).then((value) {
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName);
                });
              },
              icon: const Icon(Icons.logout),
            )
          ],
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
      body: Center(
        child: FutureBuilder<UserModel>(
          future: userProvider.getDonorById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CircularProfileAvatar(
                      '',
                      borderColor: Colors.white,
                      borderWidth: 2,
                      elevation: 5,
                      radius: 70,
                      child: Image.file(
                        File(user.image!),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex:  1,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              user.name!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex:  1,
                            child: Text(
                              'Blood Group',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              user.bloodGroup!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex:  1,
                            child: Text(
                              'Last Donation',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              user.lastDonationDate!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex:  1,
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 36,
                              width: 200,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      callContact(user.mobile!);

                                    },
                                    icon: const Icon(
                                      Icons.call,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      smsContact(user.mobile!);

                                    },
                                    icon: const Icon(
                                      Icons.sms,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      sendMail(user.email);
                                    },
                                    icon: const Icon(
                                      Icons.mail,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Write Your Review',
                                style: TextStyle(fontSize: 24),
                              ),
                              TextField(
                                focusNode: focusNode,
                                maxLines: 3,
                                controller: reviewTextController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                  ),
                                  onPressed: () {
                                    focusNode.unfocus();
                                    _submitReview();
                                  },
                                  child: const Text('Submit Review'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'All Comments',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    AllCommentsWidget(
                      donorId: id,
                    )
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return const Text('Failed to load data');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void callContact(String mobile) async{
    final urlString =  'tel:$mobile';

    if(await canLaunchUrlString(urlString)){
      await launchUrlString(urlString);

    }else{
      throw 'Can not perform this operation';
    }
  }

  void smsContact(String mobile) async{
    final urlString =  'sms:$mobile';

    if(await canLaunchUrlString(urlString)){
      await launchUrlString(urlString);

    }else{
      throw 'Can not perform this operation';
    }
  }

  void sendMail(String? email) async {
    final urlString =  'mailto:$email';

    if(await canLaunchUrlString(urlString)){
      await launchUrlString(urlString);

    }else{
      throw 'Can not perform this operation';
    }
  }
  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

  void _submitReview() async{
    if (reviewTextController.text.isEmpty) {
      showMsg(context, 'Please give a comment');
      return;
    }
    final userReview = UserReviews(
      donorId: id,
      userId: userProvider.userModel.userId!,
      reviewDate: getFormattedDate(DateTime.now(), dateTimePattern),
      userReview: reviewTextController.text,
    );

      userProvider.insertUserReview(userReview)
          .then((value) {
        setState(() {
          reviewTextController.clear();
        });
        showMsg(context, 'Your review has been submitted');
      })
          .catchError((error) {
        print(error.toString());
      });
    }


}
