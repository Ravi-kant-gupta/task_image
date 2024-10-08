import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task/home/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash Image Carousel'),
        actions: [
          IconButton(onPressed: () async{
          imageController.logout();
        },
         icon: Icon(Icons.logout)),
          IconButton(onPressed: () async{
          imageController.fetchSearchHistory();
        },
         icon: Icon(Icons.get_app)),
         
         ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: imageController.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for images...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (imageController.searchController.text.isNotEmpty) {
                          imageController.currentPage.value = 1;
                          imageController.searchImages(imageController.searchController.text);
                        }
                      },
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [

            if (imageController.isLoading.value)...{
              SizedBox(
                height: Get.height * 0.25,
                child: Center(child: CircularProgressIndicator())),

            }
            else...{
              CarouselSlider(
                options: CarouselOptions(
                  // height: Get.height * 0.3,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    if(index >0){
                      if (index == imageController.images.length - 1) {
                        imageController.carousalCurrentPage.value++;
                        imageController.fetchImages();
                      }
              
                    }
                  },
                ),
                items: imageController.images
                    .map((image) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Get.height * 0.2,
                        child: Image.network(image.urls.small ?? '',fit:BoxFit.fill)),
                    ))
                    .toList(),
              ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: imageController.searchHistory.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(imageController.searchHistory[index]),
            //         onTap: () {
            //           imageController.searchController.text = imageController.searchHistory[index];
            //           imageController.searchImages(imageController.searchHistory[index]);
            //         },
            //       );
            //     },
            //   ),
            // ),

            },
            SizedBox(height: 20,),
             Obx(
               () {
                if(imageController.searchImage.length >1){
                  return Expanded(
                  child: ListView.builder(
                    controller: imageController.scrollController,
                    itemCount: imageController.searchImage.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(imageController.searchImage[index].urls.small,
                        fit: BoxFit.contain,),
                      );
                    },
                  ),
                             );
                }else{
                  return Obx(
                  () {
                    return Container(
                    width: Get.width,
                    color:Color.fromARGB(255, 224, 248, 249),
                    child: Wrap(
                      spacing:10,
                      children: [
                      for(int i=0; i< imageController.searchHistory.length; i++)...{
                        GestureDetector(
                          onTap: () async{
                            imageController.searchImages(imageController.searchHistory[i]);
                          },
                          child: 
                            Chip(label: Text(imageController.searchHistory[i])),
                          
                        )
                      }
                    ],),
                    );
                  }
                );
                }
                  
               }
             ),
          
          ],
        );
      }),
    );
  }
}
