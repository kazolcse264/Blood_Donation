
const String tableUser = 'tbl_user';
const String tblUserColId = 'user_id';
const String tblUserColEmail = 'email';
const String tblUserColPassword = 'password';
const String tblUserColAdmin = 'admin';

const String tblUserColName = 'name';
const String tblUserColMobile = 'mobile';
const String tblUserColArea = 'area';
const String tblUserColLastDonationDate = 'last_donation_date';
const String tblUserColDateOfBirth = 'date_of_birth';
const String tblUserColImage = 'image';
const String tblUserColStatus = 'status';
const String tblUserColBloodGroup = 'blood_group';

class UserModel {
  int? userId;
  String email;
  String password;
  bool isAdmin;

  String? name;
  String? mobile;
  String? area;
  String? lastDonationDate;
  String? dateOfBirth;
  String? image;

  bool? status;

  String? bloodGroup;


  UserModel(
      {this.userId,
      required this.email,
      required this.password,
      required this.isAdmin,
      this.name,
      this.mobile,
      this.area,
      this.lastDonationDate,
      this.dateOfBirth,
      this.image,
      this.status,
      this.bloodGroup});

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblUserColEmail : email,
      tblUserColPassword : password,
      tblUserColAdmin : isAdmin ? 1 : 0,
      tblUserColName: name,
      tblUserColMobile: mobile,
      tblUserColArea: area,
      tblUserColBloodGroup: bloodGroup,
      tblUserColDateOfBirth: dateOfBirth,
      tblUserColImage: image,
      tblUserColLastDonationDate: lastDonationDate,
      tblUserColStatus: status! ? 1 : 0,
    };
    if(userId != null) {
      map[tblUserColId] = userId;
    }
    return map;
  }

  factory UserModel.fromMap
      (Map<String,dynamic> map) =>
      UserModel(
        userId: map[tblUserColId],
        email: map[tblUserColEmail],
        password: map[tblUserColPassword],
        isAdmin: map[tblUserColAdmin] == 0 ? false : true,
        name: map[tblUserColName],
        mobile: map[tblUserColMobile],
        area: map[tblUserColArea],
        lastDonationDate: map[tblUserColLastDonationDate],
        dateOfBirth: map[tblUserColDateOfBirth],
        image: map[tblUserColImage],
        status: map[tblUserColStatus] == 0 ? false : true,
        bloodGroup: map[tblUserColBloodGroup],
      );

  @override
  String toString() {
    return 'UserModel{userId: $userId, email: $email, password: $password, isAdmin: $isAdmin, name: $name, mobile: $mobile, area: $area, lastDonationDate: $lastDonationDate, dateOfBirth: $dateOfBirth, image: $image, status: $status, bloodGroup: $bloodGroup}';
  }
}