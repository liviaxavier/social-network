import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button_widget.dart';
import 'package:instagram_clone/widgets/post_card_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLenght = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      userData = userSnap.data()!;
      isFollowing = userData['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      postLenght = postSnap.docs.length;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userData['photoURL']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(postLenght, "posts"),
                                  buildStatColumn(userData['followers'].length,
                                      "followers"),
                                  buildStatColumn(userData['following'].length,
                                      "following"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? FollowButtonWidget(
                                          text: 'Edit profile',
                                          backgroundColor:
                                              mobileBackgroundColor,
                                          textColor: primaryColor,
                                          borderColor: Colors.grey,
                                          function: () {},
                                        )
                                      : isFollowing
                                          ? FollowButtonWidget(
                                              text: 'Unfollow',
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.grey,
                                              function: () {},
                                            )
                                          : FollowButtonWidget(
                                              text: 'Follow',
                                              backgroundColor: blueColor,
                                              textColor: primaryColor,
                                              borderColor: blueColor,
                                              function: () {},
                                            ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(userData['bio']),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Image(
                          image: NetworkImage(snap['postURL']),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                    // if (!snapshot.hasData) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }

                    // return ListView.builder(
                    //   itemCount: snapshot.data!.docs.length,
                    //   itemBuilder: (context, index) => NetworkImage((snapshot.data! as dynamic).docs[index]['postURL'])
                    // );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
        )
      ],
    );
  }
}
