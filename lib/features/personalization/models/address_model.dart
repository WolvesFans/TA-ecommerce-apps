import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    this.selectedAddress = true,
  });

  String get formattedPhoneNumber => CFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
      );

  //JSON Format
  toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'Postal Code': postalCode,
      'SelectedAddress': selectedAddress,
    };
  }

  //convert document from firebase to model
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['Name'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      postalCode: data['Postal Code'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  //factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['Postal Code'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode';
  }
}
