import 'package:auction_app/pages/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../users.dart';

class AuctionsPage extends StatefulWidget {
  const AuctionsPage({Key? key}) : super(key: key);

  @override
  State<AuctionsPage> createState() => _AuctionsPageState();
}

class _AuctionsPageState extends State<AuctionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        margin: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('bid-items').where('userMail', isNotEqualTo: UserData.userEmail).snapshots(),
          builder: (context, snapshot) {

            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(child: CircularProgressIndicator());
              default:
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetails(itemData: snapshot.data?.docs[index].data(), id: snapshot.data?.docs[index].id)));
                      },
                      title: Text('Item: ${snapshot.data?.docs[index]['itemName']}', overflow: TextOverflow.ellipsis),
                      subtitle: Text('Last bid date: ${snapshot.data?.docs[index]['lastDate']}'),
                      leading: CircleAvatar(
                        radius: 32,
                        foregroundImage: NetworkImage(snapshot.data?.docs[index]['imageUrl']),
                      ),
                    ),
                  );
                },);
            }
          }
        ),
      ),
    );
  }
}
