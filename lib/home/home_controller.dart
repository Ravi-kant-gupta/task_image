import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/home/api_modal.dart';
import 'package:task/home/search_modal.dart';

class ImageController extends GetxController {
  var images = <dynamic>[].obs;
  var searchImage = <dynamic>[].obs;
  SearchImages? searchData ;

  var isLoading = false.obs;
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
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // Reached the bottom of the list, call your API method here
      fetchMoreImages();
    }
  }

  Future<void> fetchMoreImages() async {
    if (isLoading.value) return; // Prevent multiple requests
    currentPage.value++;
    // Call the searchImages method with the current search query
    await searchImages( searchController.text); // Use the actual query variable
  }

  Future<void> fetchImages() async {
    try {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos?page=${carousalCurrentPage.value}&per_page=10&client_id=E42CiOZXtQAQQ4MQBSIGO2vfhJ-Y7K0PPpf4s4dxhBg'),
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
       var newImages = res.map((item) => UnsplashImage.fromJson(item)).toList();
      print(newImages.first.urls.runtimeType);
      images.value = newImages;

      // Extract URLs and add them to the observable images list
      // images.addAll(newImages.map((image) => image.urls).toList());
      // print(res[0]['urls']);
      // for(int i=0 ; i<res.length;i++){

      // }
      // print(res);
      // var x = Results.fromJson(res);
      // images.value.add(x.urls ?? {} as Urls);
      // var x = UnsplashImage.fromJson(res);

      // images.add(res.map((item) => Urls.fromJson(item['urls'])));
      // RxList<Urls> newImages = res.map((item) => Urls.fromJson(item)).toList();
      // images = newImages;
      // images.value = UnsplashImage.fromJson(res);
      // images.add(x);
    }else{
      Get.snackbar("Error",
       "Sorry Cannot Get data",
       backgroundColor: Colors.black,
       colorText: Colors.white);
    }
    isLoading.value = false;
      
    } catch (e) {
      Get.snackbar("Error",
       "${e}",
       backgroundColor: Colors.black,
       colorText: Colors.white);
    }
  }

  Future<void> searchImages(String query) async {
    if(!searchHistory.contains(query)){
      saveSearchQuery(query);
      searchHistory.add(query);
    }
    isLoading.value = true;
    // currentPage.value = 1;
    // images.clear();

    final response = await http.get(
      Uri.parse('https://api.unsplash.com/search/photos?query=$query&page=${currentPage.value}&per_page=10&client_id=E42CiOZXtQAQQ4MQBSIGO2vfhJ-Y7K0PPpf4s4dxhBg'),
    );
    print(response);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      searchData = SearchImages.fromJson(data);
      searchImage.value = searchData?.results ?? [];
      print("----------");
      print(searchData?.results);
      print("=============");
      // await saveSearchQuery(query);
    }
    isLoading.value = false;
  }

  Future<void> saveSearchQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("token") ?? "";
    if(userId != ""){

      var x = await FirebaseFirestore.instance.collection('searchHistory').add({
        'query': query,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("==========${x}");
      // fetchSearchHistory(); // Update search history
    }else{
      print("=========No User Id Data Found");
    }
  }

  Future<void> fetchSearchHistory() async {
    searchHistory.value = [];
    final snapshot = await FirebaseFirestore.instance.collection('searchHistory').get();
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("token") ?? "";
    for(int i=0; i< snapshot.docs.length;i++){
      if(userId == snapshot.docs[i]['userId']){
        searchHistory.add(snapshot.docs[i]['query']);
      }
    }
  }

  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await  FirebaseAuth.instance.signOut();
      bool x = await prefs.clear();
      print("===========${prefs.getString("token")}");
      if(x){
        Get.offAllNamed('/');
      }
      // Optionally, navigate to the login screen or show a message
      print("User logged out successfully");
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
