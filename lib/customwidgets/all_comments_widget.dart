import 'package:blood_donation/models/user_reviews_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provder.dart';
import 'comment_item.dart';

class AllCommentsWidget extends StatelessWidget {
  final int donorId;
  const AllCommentsWidget({Key? key, required this.donorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FutureBuilder<List<UserReviews>>(
          future: provider.getReviewsByDonorId(donorId),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final commentMapList = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: commentMapList.length,
                itemBuilder: (context, index) {
                  final reviews = commentMapList[index];
                  return CommentItem(userReviews: reviews,);
                },
              );
            }
            if(snapshot.hasError) {
              return const Text('Failed to load comments');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
