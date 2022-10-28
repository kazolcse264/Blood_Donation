
import 'package:blood_donation/models/user_reviews_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import '../models/user_model.dart';

class DbHelper{

  static const String createTableUser = '''create table $tableUser(
  $tblUserColId integer primary key autoincrement,
  $tblUserColName text,
  $tblUserColEmail text,
  $tblUserColPassword text,
  $tblUserColMobile text,
  $tblUserColArea text,
  $tblUserColBloodGroup text,
  $tblUserColImage text,
  $tblUserColDateOfBirth text,
  $tblUserColLastDonationDate text,
  $tblUserColStatus integer,
  $tblUserColAdmin integer)''';

  static const String createTableUserReview = '''create table $tableUserReview(
  $tblUserReviewColId integer,
  $tblUserReviewColDonorId integer,
  $tblUserReviewColUserReview text,
  $tblUserReviewColReviewDate text)''';


  static Future<Database> open() async {

    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'blood_donation_db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableUser);
      await db.execute(createTableUserReview);
    });
  }


  static Future<int> insertUser(UserModel userModel) async {
    final db = await open();
    return db.insert(tableUser, userModel.toMap());
  }

  static Future<int> insertUserReview(UserReviews userReviews) async {
    final db = await open();
    return db.insert(tableUserReview, userReviews.toMap());
  }



  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(tableUser, where: '$tblUserColEmail = ?', whereArgs: [email]);
    if(mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<UserModel> getUserById(int id) async {
    final db = await open();
    final mapList = await db.query(tableUser,
      where: '$tblUserColId = ?', whereArgs: [id],);
    return UserModel.fromMap(mapList.first);
  }
  static Future<UserModel> getDonorById(int id) async {
    final db = await open();
    final mapList = await db.query(tableUser,
      where: '$tblUserColId = ?', whereArgs: [id],);
    return UserModel.fromMap(mapList.first);
  }

  static Future<List<UserModel>> getAllUsers() async {
    final db = await open();
    final mapList = await db.query(tableUser);
    return List.generate(mapList.length, (index) =>
       UserModel.fromMap(mapList[index]));
  }


  static Future<List<UserReviews>> getReviewsByUserId(int id) async {
    final db = await open();
    final mapList = await db.query(tableUserReview,where: '$tblUserReviewColId = ? and $tblUserReviewColDonorId = ?', whereArgs: [id],);
    return List.generate(mapList.length, (index) =>
        UserReviews.fromMap(mapList[index]));
  }

  static Future<List<UserReviews>> getReviewsByDonorId(int id) async {
    final db = await open();
    final mapList = await db.rawQuery('select a.user_id, a.donor_id, a.user_review, a.review_date, b.name, b.image from $tableUserReview a inner join $tableUser b where a.user_id = b.user_id and a.donor_id = $id');
    return List.generate(mapList.length, (index) =>
        UserReviews.fromMap(mapList[index]));
  }
}