import 'package:cloud_firestore/cloud_firestore.dart';

class CommonController{
  
  static Map itemData = {};
  static List data = [];
  static bool visibility = false;

  CollectionReference ref = FirebaseFirestore.instance.collection('bid-items');
  
  fetchItemData({docId}) async {
    
    await ref.doc(docId).get().then((value){
      itemData = {
        'imageUrl' : value['imageUrl'],
        'itemDescription' : value['itemDescription'],
        'itemName' : value['itemName'],
        'lastDate' : value['lastDate'],
        'minBidPrice' : value['minBidPrice'],
        'userMail' :  value['userMail'],
        'bids' :  value['bids'],
      };
    }).then((value) {
      visibility = true;
    });
  }

  fetchAllData() async {
    await ref.get().then((value) {
      data = value.docs;
      // print(data);
    });

  }
}