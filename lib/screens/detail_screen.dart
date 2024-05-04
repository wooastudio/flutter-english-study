import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english/models/firestore_manager.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String subject;

  const DetailScreen({
    super.key,
    required this.subject,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late CollectionReference product;
  var isTouch = <String, bool>{};
  final TextEditingController koController = TextEditingController();
  final TextEditingController engController = TextEditingController();

  @override
  void initState() {
    super.initState();
    product = FirebaseFirestore.instance.collection(widget.subject);
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: koController,
                  decoration: const InputDecoration(labelText: 'ko'),
                ),
                TextField(
                  controller: engController,
                  decoration: const InputDecoration(labelText: 'eng'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                    onPressed: () async {
                      final String ko = koController.text;
                      final String eng = engController.text;
                      if (ko.isNotEmpty && eng.isNotEmpty) {
                        FirestoreManager.create(product, ko, eng);
                      }

                      koController.text = "";
                      engController.text = "";

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.subject,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      body: StreamBuilder(
        stream: product.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];

                      return GestureDetector(
                        onTap: () {
                          if (isTouch.containsKey(
                                  snapshot.data!.docs[index].reference.id) ==
                              true) {
                            isTouch.remove(
                                snapshot.data!.docs[index].reference.id);
                          } else {
                            isTouch[snapshot.data!.docs[index].reference.id] =
                                false;
                          }
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: isTouch.containsKey(
                                  snapshot.data!.docs[index].reference.id)
                              ? ListTile(
                                  title: Text(
                                    documentSnapshot['ko'],
                                  ),
                                  subtitle: Text(
                                    documentSnapshot['eng'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Colors.redAccent.withOpacity(0.8),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  title: Text(documentSnapshot['ko']),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          _create();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
