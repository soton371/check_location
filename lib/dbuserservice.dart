import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseUserService{
  String uid;
  DataBaseUserService({this.uid});

  final CollectionReference user = Firestore.instance.collection('Users');

  Future UpdateUserData(String _address) async{
    return await user.document(uid).setData({
      'Address': _address,
    });
  }
}