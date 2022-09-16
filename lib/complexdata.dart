import 'dart:convert';

import 'package:complex_api_test/Model/usermodel.dart';
import 'package:complex_api_test/reusable/reusable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApi extends StatefulWidget {
  ComplexApi({Key? key}) : super(key: key);

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i["name"]);
        userList.add(UserModel.fromJson(i));
      }
    } else {
      return userList;
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Complex Json Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 50.0,
                      width: 50.0,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReUsableRow(
                                title: 'User Id',
                                value: snapshot.data![index].id.toString(),
                              ),
                              ReUsableRow(
                                title: 'User Name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReUsableRow(
                                title: 'Email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReUsableRow(
                                title: 'Street',
                                value: snapshot.data![index].address!.street
                                    .toString(),
                              ),
                              ReUsableRow(
                                title: 'lng',
                                value: snapshot.data![index].address!.geo!.lng
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
