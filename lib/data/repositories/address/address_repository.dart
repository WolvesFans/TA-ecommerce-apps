import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/personalization/models/address_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class  AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching address. Try again later';
    }
  }

  //clear the "selected" field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again later';
    }
  }

  //store new user order
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong :( Try again later';
    }
  }
}
