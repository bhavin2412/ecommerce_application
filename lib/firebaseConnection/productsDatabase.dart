import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileDatabase {
  static List<Map> data = [];

  static Map mobs = {};

  static CollectionReference fireStore =
      FirebaseFirestore.instance.collection('products');

  static Future insertData(String name, String price, String image, String desc,
      String rating, String category,String quantity) async {
    String id = DateTime.now().toString();

    await FirebaseFirestore.instance.collection('products').doc(id).set({
      'name': name,
      'price': price,
      'id': id,
      'image': image,
      'desc': desc,
      'rating': rating,
      'category': category,
      'quantity':quantity,
    });
    selectData();
  }

  static Future updateDate({
    required String name,
    required String price,
    required String image,
    required String desc,
    required String category,
    required String rating,
    required String id,
  }) async {

    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'name': name,
      'price': price,
      'id': id,
      'image': image,
      'desc': desc,
      'rating': rating,
      'category': category,
    });
    selectData();
  }

  static deleteData(String id) {

    fireStore.doc(id).delete();
  }

  static Future selectData() async {
    fireStore.get().then((value) {
      data.clear();
      value.docs.forEach((element) {
        data.add(element.data() as Map);
      });
    });
    print('$data ***');
  }

  static Future<String> selectedUser(String email) async {
    data.forEach((element) {
      if (element['email'] == email) {
        mobs = element;
      }
    });
    return mobs['role'];
  }
}
