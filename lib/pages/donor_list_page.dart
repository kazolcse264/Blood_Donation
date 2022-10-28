import 'dart:io';
import 'package:blood_donation/pages/profile_page.dart';
import 'package:blood_donation/providers/user_provder.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/user_model.dart';
import '../utils/custom_clipper.dart';
import '../utils/helper_functions.dart';
import 'launcher_page.dart';

class DonorListPage extends StatefulWidget {
  static const String routeName = '/donor_list';

  const DonorListPage({Key? key}) : super(key: key);

  @override
  State<DonorListPage> createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {

  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    Provider.of<UserProvider>(context, listen: false).getAllUsers();
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
            'Donor List',
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
                  Navigator.pushReplacementNamed(context, LauncherPage.routeName);
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
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return DonorItem(user: user);
          },
        ),
      ),
    );
  }
}

class DonorItem extends StatefulWidget {

   DonorItem({Key? key,required this.user}) : super(key: key);
   final UserModel user;
  @override
  State<DonorItem> createState() => _DonorItemState();
}

class _DonorItemState extends State<DonorItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProfilePage.routeName,arguments: [widget.user.userId, widget.user.name]),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          horizontalTitleGap: 40,
          tileColor: Colors.red.withOpacity(0.7),
          leading: CircularProfileAvatar(
            '',
            borderColor: Colors.white,
            borderWidth: 2,
            elevation: 5,
            radius: 25,
            child: Image.file(
              File(widget.user.image!),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              '${widget.user.name}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  Text(
                    '${widget.user.area}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ProfilePage.routeName,arguments: [widget.user.userId, widget.user.name]);
                    },
                    child: const Text('Ask For Help'),
                  ),
                ),
              /*if (!askForHelp)
                Container(
                  height: 36,
                  width: 150,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          callContact(widget.user.mobile!);
                          callAskForHelp();
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          smsContact(widget.user.mobile!);
                          callAskForHelp();
                        },
                        icon: const Icon(
                          Icons.sms,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          sendMail(widget.user.email);
                          callAskForHelp();
                        },
                        icon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),*/
            ],
          ),
          trailing: CircularProfileAvatar(
            '',
            borderColor: Colors.grey.withOpacity(0.2),
            borderWidth: 1,
            radius: 20,
            child: Center(
                child: Text(
                  '${widget.user.bloodGroup}',
                  style: const TextStyle(color: Colors.red),
                )),
          ),
        ),
      ),
    );
  }

/*  void callAskForHelp() {
     setState(() {
      askForHelp = true;
    });
  }*/

/*  void callContact(String mobile) async{
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
  }*/
}

