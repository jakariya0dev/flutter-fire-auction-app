import 'package:auction_app/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewAuctionController{

  String imageUrl = '';
  final FirebaseFirestore ref = FirebaseFirestore.instance;

  createAuction({imageFile, itemName, description, minBidPrice, lastDate}) async {

    // For unique image file name
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Firebase ref
    Reference referenceRoot = FirebaseStorage.instance.ref().child('images');
    Reference referenceDirImages = referenceRoot.child(uniqueFileName);

    try {
      //Store the file
      await referenceDirImages.putFile(imageFile);
      //Success: get the download URL
      await ref.collection('bid-items').doc().set({
        'userMail' : UserData.userEmail!,
        'itemName' : itemName,
        'itemDescription' : description,
        'minBidPrice' : minBidPrice,
        'lastDate' : lastDate,
        'imageUrl' : await referenceDirImages.getDownloadURL()
      });
    } catch (error) {
      // print(error);
    }

  }
}