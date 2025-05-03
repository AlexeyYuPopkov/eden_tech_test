import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden_tech_test/data/models/firestore_user.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

class FirebaseFirestoreService {
  static const _collectionName = 'users';
  static const _favoritesCollectionName = 'favorites';
  final db = FirebaseFirestore.instance;

  FirebaseFirestoreService();

  Future<void> addFavorite({
    required String userId,
    required Movie movie,
  }) async {
    final usersCollection = db.collection(_collectionName).doc(userId);
    final user = FirestoreUser(id: userId);

    await usersCollection.set(user.toJson(), SetOptions(merge: true));
    await usersCollection
        .collection(_favoritesCollectionName)
        .doc(movie.id)
        .set(movie.toJson());
  }

  Future<void> removeFavorite({
    required String userId,
    required String movieId,
  }) async {
    final usersCollection = db.collection(_collectionName).doc(userId);
    await usersCollection
        .collection(_favoritesCollectionName)
        .doc(movieId)
        .delete();
  }

  Future<bool> isFavorite({
    required String userId,
    required String movieId,
  }) {
    return db
        .collection(_collectionName)
        .doc(userId)
        .collection(_favoritesCollectionName)
        .doc(movieId)
        .get()
        .then((value) => value.exists);
  }

  Stream<Iterable<Movie>> getFavoritesStream(String userId) {
    return FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(userId)
        .collection(_favoritesCollectionName)
        .snapshots()
        .map((e) {
      return e.docs.map((e) => Movie.fromJson(e.data()));
    });
  }

  // Future<List<Movie>> getFavorites(String userId) async {
  //   final usersCollection = db.collection(_collectionName).doc(userId);
  //   final snapshot =
  //       await usersCollection.collection(_favoritesCollectionName).get();

  //   return snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList();
  // }
}
