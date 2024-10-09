import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                
                imageController.showLogoutDialog();
              },
              icon: const Icon(Icons.logout))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                TextField(
                  controller: imageController.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for images...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                     
                      padding: const EdgeInsets.all(15), 
                      constraints:
                          const BoxConstraints(),
                      splashColor: Colors.blueAccent
                          .withOpacity(0.3),
                      highlightColor: Colors.blueAccent.withOpacity(0.2),
                      onPressed: () {
                        if (imageController.searchController.text.isNotEmpty) {
                          imageController.currentPage.value = 1;
                          imageController.searchImages(
                              imageController.searchController.text);
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
            if (imageController.isLoading.value) ...{
              SizedBox(
                  height: Get.height * 0.25,
                  child: const Center(child: CircularProgressIndicator())),
            } else ...{
              CarouselSlider(
                carouselController: imageController.carouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8, 
                  aspectRatio: 16 / 8,
                  onPageChanged: (index, reason) {
                    imageController.currentCarouselIndex.value =
                        index;
                    if (index == imageController.images.length - 1) {
                      imageController.carousalCurrentPage.value++;
                      imageController.fetchImages();
                    }
                  },
                ),
                items: imageController.images
                    .map(
                      (image) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset:
                                    const Offset(0, 5), 
                              )
                            ],
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15),
                            child: Image.network(
                              image.urls.small ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20), 
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(imageController.images.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          imageController.carouselController.animateToPage(
                              index);
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor:
                              imageController.currentCarouselIndex.value ==
                                      index
                                  ? Colors.teal
                                  : Colors.grey[300],
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
            },
            const Divider(
              color: Colors.grey,
            ),
            const Text("Search Images"),
            Obx(() {
              if (imageController.searchImage.length > 1) {
                return Expanded(
                  child: ListView.builder(
                    controller: imageController.scrollController,
                    itemCount: imageController.searchImage.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0), 
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              0.3,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3), 
                                blurRadius: 8, 
                                offset: const Offset(0, 5), 
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15),
                            child: Image.network(
                              imageController.searchImage[index].urls!.small ??
                                  '',
                              fit: BoxFit
                                  .cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : const Center(
                                        child:
                                            CircularProgressIndicator()); 
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors
                                      .grey[300],
                                  child: const Center(
                                      child: Icon(Icons.error,
                                          color: Colors.red)), 
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Obx(() {
                  return Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 224, 248, 249), 
                      borderRadius: BorderRadius.circular(
                          15), 
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10, 
                      alignment:
                          WrapAlignment.start,
                      children: [
                        for (int i = 0;
                            i < min(imageController.searchHistory.length, 10);
                            i++) ...{
                          GestureDetector(
                            onTap: () async {
                              imageController.searchController.text =
                                  imageController.searchHistory[i];
                              imageController.searchImages(
                                  imageController.searchHistory[i]);
                            },
                            child: Chip(
                              label: Text(
                                imageController.searchHistory[i],
                                style: const TextStyle(
                                  color: Colors
                                      .white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              backgroundColor:
                                  Colors.teal, 
                              elevation: 4,
                              shadowColor:
                                  Colors.grey.withOpacity(0.3), 
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5),
                              avatar: const Icon(
                                Icons.history,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
                  );
                });
              }
            }),
            Obx(() {
              return (imageController.searchLoading.value)
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink();
            }),
          ],
        );
      }),
    );
  }
}
