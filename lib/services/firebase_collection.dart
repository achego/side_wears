import 'package:building_ui/exports/exports.dart';

class FirestoreCollectionService {
  // static CollectionReference? _firestoreCollectionRefernce;

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

// a new reference for adding to cart
  final CollectionReference cartRef =
      FirebaseFirestore.instance.collection('users');

  // a new reference for adding saved Items
  final CollectionReference savedRef =
      FirebaseFirestore.instance.collection('users');
}
