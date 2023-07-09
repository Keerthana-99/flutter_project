import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_list_model.dart';

class UserDetails extends StatefulWidget {
  final int unique_id;
  const UserDetails({Key? key, required this.unique_id}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserListBlock block = UserListBlock();

  @override
  void initState() {
    super.initState();
    block.getuserDetails(widget.unique_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (block.userDetailsList.isEmpty) {
                    if (block.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text('User details not found');
                    }
                  } else {
                    final userDetails = block.userDetailsList[0];
                    return Column(
                      children: [
                        Container(
                          height: 200,
                          child: Image.network(
                            userDetails[0]['avatar'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Email: ${userDetails[0]['email']}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'First Name: ${userDetails[0]['first_name']}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Last Name: ${userDetails[0]['last_name']}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
