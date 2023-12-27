import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';


class Mapi extends StatefulWidget{


  @override
  State<Mapi> createState() => _MapiState();
}

class _MapiState extends State<Mapi> {
  List<Map<String, String?>> arrdata = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var userModel = await Apiservice.getUsers();
    if (userModel != null && userModel.data != null) {
      setState(() {
        arrdata = userModel.data!.map((user) {
          return {
            'name': user.firstName! + ' ' + user.lastName!,
            'mobno': user.email,
            'unread': user.id.toString(),
            'avatar': user.avatar,
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: arrdata.map((value) => InkWell(
        onTap: () {
          Details(value);
        },
        child: ListTile(
          leading: InkWell(
            onTap: () {
              print("hello");
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(value['avatar'] ?? ''),
            ),
          ),
          title: Text(value['name'] ?? ''),
          subtitle: Text(value['mobno'] ?? ''),
          trailing: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.yellow,
            child: Text(value['unread'] ?? ''),
          ),
        ),
      )).toList(),
    );
  }

  void Details(Map<String, String?> details) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detailpage(details: details),
      ),
    );
  }
}


class Detailpage extends StatelessWidget {
  final Map<String, String?> details;

  const Detailpage({super.key, required this.details});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Image.network(details['avatar']!)

            ),
            SizedBox(height: 21,),

            Text('Name: ${details['name']}',style: TextStyle(
              fontSize: 40
            ),),
            Text('Email: ${details['mobno']}',style: TextStyle(
                fontSize: 20
            )),
            Text('Id: ${details['unread']}',style: TextStyle(
                fontSize: 20
            )),
          ],
        ),
      ),
    );
  }
}