import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void initState() {
    super.initState();
    product = FirebaseFirestore.instance.collection(widget.subject);
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];

                return GestureDetector(
                  onTap: () {
                    if (isTouch.containsKey(
                            snapshot.data!.docs[index].reference.id) ==
                        true) {
                      isTouch.remove(snapshot.data!.docs[index].reference.id);
                    } else {
                      isTouch[snapshot.data!.docs[index].reference.id] = false;
                    }
                    setState(() {});
                  },
                  child: Expanded(
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
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
