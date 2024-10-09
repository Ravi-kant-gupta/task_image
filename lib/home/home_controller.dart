import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/home/api_modal.dart';
import 'package:task/home/search_modal.dart';

class ImageController extends GetxController {
  var images = <dynamic>[].obs;
  var searchImage = <Results>[].obs;
  int? prevIndex;
  SearchImages? searchData;

  var isLoading = false.obs;
  var currentCarouselIndex = 0.obs;
  var carouselController = CarouselSliderController();
  var carousalCurrentPage = 1.obs;
  var currentPage = 1.obs;
  var searchHistory = <String>[].obs;
  final TextEditingController searchController = TextEditingController();
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    fetchImages();
    fetchSearchHistory();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
     
      fetchMoreImages();
    }
  }

  Future<void> fetchMoreImages() async {
    if (isLoading.value) return; 
    currentPage.value++;
   
    await searchImages(searchController.text); 
  }

  Future<void> fetchImages() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/photos?page=${carousalCurrentPage.value}&per_page=10&client_id=E42CiOZXtQAQQ4MQBSIGO2vfhJ-Y7K0PPpf4s4dxhBg'),
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body.toString());
        var newImages =
            res.map((item) => UnsplashImage.fromJson(item)).toList();
        print(newImages.first.urls.runtimeType);
        images.value = newImages;
        currentCarouselIndex.value = 0;
      } else {
        Get.snackbar("Error", "Sorry Cannot Get data",
            backgroundColor: Colors.black, colorText: Colors.white);
      }
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "${e}",
          backgroundColor: Colors.black, colorText: Colors.white);
    }
  }

  RxBool searchLoading = false.obs;
  Future<void> searchImages(String query) async {
    if (!searchHistory.contains(query)) {
      saveSearchQuery(query);
      searchHistory.add(query);
    }
    searchLoading.value = true;
    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/search/photos?query=$query&page=${currentPage.value}&per_page=10&client_id=E42CiOZXtQAQQ4MQBSIGO2vfhJ-Y7K0PPpf4s4dxhBg'),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      searchData = SearchImages.fromJson(data);
      searchImage.value = [...searchImage.value, ...searchData!.results ?? []];
      print("----------");
      print(searchData?.results);
      print("=============");
     
    }
    searchLoading.value = false;
  }

  Future<void> saveSearchQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("token") ?? "";
    if (userId != "") {
      var x = await FirebaseFirestore.instance.collection('searchHistory').add({
        'query': query,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      print("=========No User Id Data Found");
    }
  }

  Future<void> fetchSearchHistory() async {
    searchHistory.value = [];
    final snapshot =
        await FirebaseFirestore.instance.collection('searchHistory').get();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("token") ?? "";
    for (int i = 0; i < snapshot.docs.length; i++) {
      if (userId == snapshot.docs[i]['userId']) {
        searchHistory.add(snapshot.docs[i]['query']);
      }
    }
  }

  void showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text(
        'Logout',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white, 
          ),
                onPressed: () {
                  Get.back(); 
                },
                child: const Text(
                  'No',
                 
                ),
              ),
            ),
            const SizedBox(width: 10,),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey[700],
            foregroundColor: Colors.white,
          ),
            onPressed: () {
             
              Get.back(); 
              logout(); 
            },
            child: const Text(
              'Yes',
              
            ),
          ),
        ),
          ],
        ),
      ],
    ),
  );
}

  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signOut();
      bool x = await prefs.clear();
      if (x) {
        Get.offAllNamed('/');
      }
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
