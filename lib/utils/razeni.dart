import 'package:cloud_firestore/cloud_firestore.dart';

var razeni = [
  // VZESTUPNĚ ČAS
  (QueryDocumentSnapshot<Map<String, dynamic>> a,
          QueryDocumentSnapshot<Map<String, dynamic>> b) =>
      ((a.data()["date"] as Timestamp).toDate().hour ==
              (b.data()["date"] as Timestamp).toDate().hour)
          ? (a.data()["date"] as Timestamp)
              .toDate()
              .minute
              .compareTo((b.data()["date"] as Timestamp).toDate().minute)
          : (a.data()["date"] as Timestamp)
              .toDate()
              .hour
              .compareTo((b.data()["date"] as Timestamp).toDate().hour),
  // SESTUPNĚ ČAS
  (QueryDocumentSnapshot<Map<String, dynamic>> a,
          QueryDocumentSnapshot<Map<String, dynamic>> b) =>
      ((b.data()["date"] as Timestamp).toDate().hour ==
              (a.data()["date"] as Timestamp).toDate().hour)
          ? (b.data()["date"] as Timestamp)
              .toDate()
              .minute
              .compareTo((a.data()["date"] as Timestamp).toDate().minute)
          : (b.data()["date"] as Timestamp)
              .toDate()
              .hour
              .compareTo((a.data()["date"] as Timestamp).toDate().hour),
  // VZESTUPNĚ HODNOCENÍ
  (QueryDocumentSnapshot<Map<String, dynamic>> a,
          QueryDocumentSnapshot<Map<String, dynamic>> b) =>
      (a.data()["review"] as int).compareTo(b.data()["review"]),
  // SESTUPNĚ HODNOCENÍ
  (QueryDocumentSnapshot<Map<String, dynamic>> a,
          QueryDocumentSnapshot<Map<String, dynamic>> b) =>
      (b.data()["review"] as int).compareTo(a.data()["review"]),
];
