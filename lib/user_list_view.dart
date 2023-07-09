import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:sample_app/user_details_view.dart';
import 'user_list_model.dart';
import 'user_details_view.dart';
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserListBlock block = UserListBlock();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    block.fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      block.fetchNextPage(); // Fetch the next page when reaching the bottom of the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('MY APP'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<UserListBlock>(
                  init: block, // Pass the block as the initial value for GetBuilder
                  builder: (block) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textContainer(block),
                    );
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 

  Widget textContainer(UserListBlock block) {
    return Container(
      
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.white),
        color: Color(0xFFF5F3F3),
      ),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(10.0),
        itemCount: block.dataList.length + 1,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == block.dataList.length) {
            if (block.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text('');
            }
          } else {
            final item = block.dataList[index];
            return GestureDetector(
              onTap: () async {
               Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserDetails(unique_id: item['id'],)),
                                          );
              },
              child: Column(
                children: [
                  SizedBox(
                    height:  MediaQuery.of(context).size.height/8,
                    child: Card(
                      child: ListTile(
                        leading: Image.network(item['avatar']),
                        
                        title: Text(
                          '${item['first_name'] ?? ''} ${item['last_name'] ?? ''}',
                        ),
                        subtitle: Text(item['email'] ?? ''),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            );            
          }
        },
      ),
    );
    
  }
}
