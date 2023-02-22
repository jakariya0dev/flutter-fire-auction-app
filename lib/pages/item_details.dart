import 'package:auction_app/controllers/common_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../users.dart';

class ItemDetails extends StatefulWidget {
  final Map? itemData;
  final String? id;

  const ItemDetails({Key? key, required this.itemData, required this.id})
      : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    int winnerIndex = 0;

    // All Bidders details
    List bids = widget.itemData!['bids'];
    // All Bidders Email for this item
    List biddersMail = bids.map((e) => e['email']).toList();

    if (DateTime.parse(widget.itemData!['lastDate']).compareTo(DateTime.now()) <
        0) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(24.0),
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 55,
                    foregroundImage: NetworkImage(
                        '${widget.itemData!['imageUrl']}'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.itemData!['itemName']}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: const Text("Minimum Bid"),
                        subtitle:
                            Text(widget.itemData!['minBidPrice']),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: const Text(
                          "Auction Ended at",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.itemData!['lastDate']),
                      )),
                  const SizedBox(height: 10),
                  // Bid list
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Bid Winner',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: bids.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (winnerIndex <
                                  int.parse(bids[index]['price'])) {
                                winnerIndex = index;
                              }
                              if (bids.isEmpty) {
                                return const Center(child: Text('No Bid Yet'));
                              } else {
                                return bids.length - 1 != index
                                    ? const SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(bids[winnerIndex]['name'],
                                              style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          Text(
                                              '\$${bids[winnerIndex]['price']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(24.0),
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 55,
                    foregroundImage:
                        NetworkImage('${widget.itemData!['imageUrl']}'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.itemData!['itemName']}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                      controller: TextEditingController(
                          text: '${widget.itemData!['itemDescription']}'),
                      readOnly: true,
                      decoration: const InputDecoration(
                          label: Text('Description'),
                          border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: const Text("Minimum Bid"),
                        subtitle: Text(widget.itemData!['minBidPrice']),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: const Text("Auction End Date"),
                        subtitle: Text(widget.itemData!['lastDate']),
                      )),
                  const SizedBox(height: 10),
                  // Bid list
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Bids placed by other users',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: bids.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (bids.isEmpty) {
                                return const Center(child: Text('No Bid Yet'));
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(bids[index]['name']),
                                        Text('\$${bids[index]['price']}'),
                                      ],
                                    ),
                                    const Divider()
                                  ],
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 55)
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.itemData!['userMail'] == UserData.userEmail
            ? null
            : FloatingActionButton.extended(
                onPressed: () async {
                  List bidPriceForThisUser = bids
                      .where((e) => e['email'] == UserData.userEmail)
                      .toList();

                  // for text field
                  TextEditingController controller = TextEditingController();
                  final formKey = GlobalKey<FormState>();

                  if (biddersMail.contains(UserData.userEmail)) {
                    controller.text = bidPriceForThisUser.first['price'];
                  }

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Enter Your Bid Price'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  if (biddersMail
                                          .contains(UserData.userEmail) &&
                                      formKey.currentState!.validate()) {
                                    bids.removeWhere((e) =>
                                        e['email'] == UserData.userEmail);

                                    // First delete previous value
                                    await FirebaseFirestore.instance
                                        .collection('bid-items')
                                        .doc(widget.id)
                                        .update({'bids': bids});

                                    // Adding new item
                                    bids.add({
                                      'email': UserData.userEmail,
                                      'name': UserData.userName,
                                      'price': controller.text.toString()
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('bid-items')
                                        .doc(widget.id)
                                        .update({
                                      'bids': FieldValue.arrayUnion(bids),
                                    });
                                    Navigator.pop(context);

                                    setState(() {});
                                  } else {
                                    Map bid = {
                                      'name': UserData.userName,
                                      'email': UserData.userEmail,
                                      'price': controller.text.toString(),
                                    };

                                    if (formKey.currentState!.validate()) {
                                      await FirebaseFirestore.instance
                                          .collection('bid-items')
                                          .doc(widget.id)
                                          .update({
                                        'bids': FieldValue.arrayUnion([bid]),
                                      });
                                      Navigator.pop(context);
                                      bids.add(bid);
                                      setState(() {});
                                    }
                                  }
                                },
                                child: const Text('Submit')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                          ],
                          content: SizedBox(
                            height: 100,
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (int.parse(CommonController
                                          .itemData['minBidPrice']) >
                                      int.parse(value)) {
                                    return 'Minimum bid price ${CommonController.itemData['minBidPrice']}';
                                  }
                                  return null;
                                },
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Your Bid Price'),
                              ),
                            ),
                          ),
                        );
                      });
                },
                label: biddersMail.contains(UserData.userEmail)
                    ? const Text('Edit Your Bid')
                    : const Text('Bid this item')),
      );
    }
  }
}
