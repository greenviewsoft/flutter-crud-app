import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:my_firstapp/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _updateController = TextEditingController();

  Box? ContactBox;
  @override
  void initState() {
    ContactBox = Hive.box("contact-list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),

        child: Column(children: [
            Text(
            'flutter crud App!',
            style: TextStyle(
              fontSize: 40,
              color: Colors.red[300],
            ),),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: new InputDecoration(
                  hintText: 'Type Mobile Number'
              ),
            ),
          ),
          SizedBox(

            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                final userInput = _controller.text;
                print(userInput);
                await ContactBox?.add(userInput);
                print('added');
              },
              child: Text("Add user number"),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box("contact-list").listenable(),
              builder: (context, box, widget) {
                return ListView.builder(
                  itemCount: ContactBox!.keys.toList().length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          ContactBox!.getAt(index).toString(),
                        ),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text('Update'),
                                      content: Column(
                                        children: [

                                        TextField(
                                        controller: _updateController,
                                      ),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                        ContactBox!.putAt(
                                            index,
                                            _updateController.text,
                                        );

                                        Navigator.pop(context);
                                          },
                                          child: Text("Update number"),
                                        ),
                                      ) ,
                                        ],
                                      ) ,
                                    );
                                  }
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                              ),
                              IconButton(
                                onPressed: ()async {
                                  await ContactBox!.deleteAt(index);
                                  print('Done');

                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
