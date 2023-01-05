import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../../res/components/round_button.dart';
import '../../../view_model/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userId.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  AppColors.secondaryTextColor,
                                            )),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: provider.image == null
                                              ? map['profile'].toString() == ""
                                                  ? const Icon(
                                                      Icons.person,
                                                      size: 35,
                                                    )
                                                  : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        map['profile']
                                                            .toString(),
                                                      ),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      errorBuilder: (context,
                                                          object, stack) {
                                                        return Container(
                                                          child: const Icon(
                                                            Icons.error_outline,
                                                            color: AppColors
                                                                .alertColor,
                                                          ),
                                                        );
                                                      })
                                              : Stack(
                                                  children: [
                                                    Image.file(File(provider
                                                            .image!.path)
                                                        .absolute),
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.pickImage(context);
                                    },
                                    child: const CircleAvatar(
                                      radius: 14,
                                      backgroundColor:
                                          AppColors.primaryIconColor,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.showUserNameDialogueAlert(
                                      context, map['userName']);
                                },
                                child: ReusableRow(
                                  title: 'Username',
                                  value: map['userName'],
                                  iconData: Icons.person,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.showPHoneDialogueAlert(
                                      context, map['phone']);
                                },
                                child: ReusableRow(
                                  title: 'Phone',
                                  value: map['phone'] == ""
                                      ? 'XXX-XXX-XXX'
                                      : map['phone'],
                                  iconData: Icons.phone,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // provider.showUserNameDialogueAlert(
                                  //     context, map['phone']);
                                },
                                child: ReusableRow(
                                  title: 'Email',
                                  value: map['email'],
                                  iconData: Icons.email_outlined,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              RoundButton(
                                title: 'Log out',
                                onPress: () {
                                  Navigator.pushNamed(
                                      context, RouteName.loginView);
                                },
                              )
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Something Went wrong',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          );
                        }
                      },
                    )),
              );
            },
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        )
      ],
    );
  }
}
