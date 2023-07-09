import 'package:get/get.dart';
import 'api_service.dart' as apiservice;

class UserListBlock extends GetxController {
  int currentPage = 1;
  List<dynamic> dataList = [];
  RxList<dynamic> userDetailsList = RxList<dynamic>([]);
  bool isLoading = false;

  Future<void> fetchData() async {
    if (isLoading) return;

    isLoading = true;
    update();

    try {
      final response = await apiservice.userslist(currentPage);

      if (response.isNotEmpty) {
        dataList.addAll(response);
      }
    } catch (e) {
    }

    isLoading = false;
    update();
  }

  Future<void> fetchNextPage() async {
    if (isLoading) return;

    isLoading = true;
    update();

    try {
      currentPage++;

      final response = await apiservice.userslist(currentPage);

      if (response.isNotEmpty) {
        dataList.addAll(response);
      }
    } catch (e) {
    }

    isLoading = false;
    update();
  }

  Future<void> getuserDetails(int unique_id) async {
    if (isLoading) return;

    isLoading = true;
    update();

    try {
      userDetailsList.value = []; // Clear previous user details

      final response = await apiservice.userDetails(unique_id);

      if (response.isNotEmpty) {
        userDetailsList.value = [response];
      }
    } catch (e) {
    }

    isLoading = false;
    update();
  }
}
