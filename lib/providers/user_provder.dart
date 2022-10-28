import 'package:blood_donation/models/user_reviews_model.dart';
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier{
  List<UserModel> userList = [];
  late UserModel _userModel;

  UserModel get userModel => _userModel;

  void getAllUsers() async {
    userList = await DbHelper.getAllUsers();
    notifyListeners();
  }

  Future<int> insertUser(UserModel userModel) {
    return DbHelper.insertUser(userModel);
  }

  Future<int> insertUserReview(UserReviews userReviews) {
    return DbHelper.insertUserReview(userReviews);
  }

  Future<UserModel?> getUserByEmail(String email) {
    return DbHelper.getUserByEmail(email);
  }

  Future<void> getUserById(int id) async {
    _userModel = await DbHelper.getUserById(id);
  }
  Future<UserModel> getDonorById(int id) {
    return DbHelper.getDonorById(id);
  }

  UserModel getItem(int id) {
    return userList.firstWhere((element) => element.userId == id);
  }


  Future<List<UserReviews>> getReviewsByDonorId(int id) =>
      DbHelper.getReviewsByDonorId(id);

}