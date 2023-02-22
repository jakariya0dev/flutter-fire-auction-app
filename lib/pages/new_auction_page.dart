import 'dart:io';

import 'package:auction_app/controllers/new_auction_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewAuctionPage extends StatefulWidget {
  const NewAuctionPage({Key? key}) : super(key: key);

  @override
  State<NewAuctionPage> createState() => _NewAuctionPageState();
}

class _NewAuctionPageState extends State<NewAuctionPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController bidController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Auction'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Product Name'),
            ),
            const SizedBox(height: 16),
            // Description
            TextFormField(
              controller: descController,
              decoration:
                  const InputDecoration(hintText: 'Product Description'),
            ),
            const SizedBox(height: 16),
            // Minimum Bid Price
            TextFormField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Minimum Bid Price',
              ),
            ),
            const SizedBox(height: 16),
            // Auction End date
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                  enabled: true,
                  hintText: 'Auction End Date',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));
                        if (picked != null) {
                          setState(() {
                            dateController.text =
                                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_month))),
            ),
            const SizedBox(height: 16),
            filePath == null
                ? const SizedBox()
                : Image.file(
                    File(filePath!),
                    height: 200,
                    width: 200,
                  ),
            ElevatedButton.icon(
              label: const Text('Select image'),
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                filePath = file?.path;
                // print('${file?.path}');
                setState(() {});
                if (file == null) return;
              },
              icon: const Icon(Icons.camera),
            ),
            const SizedBox(height: 24),
            MaterialButton(
              color: Colors.deepPurple,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () async {
                await NewAuctionController().createAuction(
                    imageFile: File(filePath!),
                    itemName: nameController.text,
                    description: descController.text,
                    lastDate: dateController.text,
                    minBidPrice: bidController.text);
              },
              child: const Text(
                'Create Auction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
