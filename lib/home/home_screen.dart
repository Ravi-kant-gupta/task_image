import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                imageController.logout();
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                imageController.fetchSearchHistory();
              },
              icon: Icon(Icons.get_app)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
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
                      icon: Icon(Icons.search),
                      // color: Colors.blue,
                      padding: EdgeInsets.all(15), // Padding around the icon
                      constraints:
                          BoxConstraints(), // Remove default constraints for IconButton
                      splashColor: Colors.blueAccent
                          .withOpacity(0.3), // Splash effect color
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
                  child: Center(child: CircularProgressIndicator())),
            } else ...{
              // CarouselSlider(
              //   options: CarouselOptions(
              //     // height: Get.height * 0.3,
              //     autoPlay: false,
              //     onPageChanged: (index, reason) {
              //       if (index > 0) {
              //         if (index == imageController.images.length - 1) {
              //           imageController.carousalCurrentPage.value++;
              //           imageController.fetchImages();
              //         }
              //       }
              //     },
              //   ),
              //   items: imageController.images
              //       .map((image) => Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: SizedBox(
              //                 height: Get.height * 0.2,
              //                 child: Image.network(image.urls.small ?? '',
              //                     fit: BoxFit.fill)),
              //           ))
              //       .toList(),
              // ),
              CarouselSlider(
                carouselController: imageController.carouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true, // Center image is larger
                  viewportFraction: 0.8, // Slight margin between items
                  aspectRatio: 16 / 8, // Adjust aspect ratio
                  onPageChanged: (index, reason) {
                    imageController.currentCarouselIndex.value =
                        index; // Track current index
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
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset:
                                    Offset(0, 5), // Shadow direction: bottom
                              )
                            ],
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Clip to rounded corners
                            child: Image.network(
                              image.urls.small ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20), // Spacing between slider and pagination
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
                              index); // Move carousel to selected index
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
                            style: TextStyle(
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
            Divider(
              color: Colors.grey,
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Text("Search Images"),
            Obx(() {
              if (imageController.searchImage.length > 1) {
                return Expanded(
                  child: ListView.builder(
                    controller: imageController.scrollController,
                    itemCount: imageController.searchImage.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0), // Add padding to the ListView
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0), // Spacing between items
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              0.3, // Increased height for better visibility
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 8, // Spread of the shadow
                                offset: Offset(0, 5), // Direction of the shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Clip the image to the same border radius
                            child: Image.network(
                              imageController.searchImage[index].urls!.small ??
                                  '',
                              fit: BoxFit
                                  .cover, // Fit the image to cover the container
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : Center(
                                        child:
                                            CircularProgressIndicator()); // Loader while image loads
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors
                                      .grey[300], // Background color for error
                                  child: Center(
                                      child: Icon(Icons.error,
                                          color: Colors.red)), // Error icon
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );

                // Expanded(
                //   child: ListView.builder(
                //     controller: imageController.scrollController,
                //     itemCount: imageController.searchImage.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         height: MediaQuery.of(context).size.height * 0.1,
                //         width: MediaQuery.of(context).size.width * 0.8,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Image.network(
                //           imageController.searchImage[index].urls.small,
                //           fit: BoxFit.contain,
                //         ),
                //       );
                //     },
                //   ),
                // );
              } else {
                return Obx(() {
                  return Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0), // Add padding for better spacing
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 224, 248, 249), // Soft background color
                      borderRadius: BorderRadius.circular(
                          15), // Rounded corners for the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2), // Light shadow for depth
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3), // Shadow direction
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10, // Spacing between rows of chips
                      alignment:
                          WrapAlignment.start, // Align chips to the start
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
                                style: TextStyle(
                                  color: Colors
                                      .white, // White text color for contrast
                                  fontWeight:
                                      FontWeight.bold, // Bold text for emphasis
                                ),
                              ),
                              backgroundColor:
                                  Colors.teal, // Chip background color
                              elevation: 4, // Add elevation for depth
                              shadowColor:
                                  Colors.grey.withOpacity(0.3), // Chip shadow
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5), // Adjust chip padding
                              avatar: Icon(
                                Icons.history, // History icon inside the chip
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

                // Obx(() {
                //   return Container(
                //     width: Get.width,
                //     color: Color.fromARGB(255, 224, 248, 249),
                //     child: Wrap(
                //       spacing: 10,
                //       children: [
                //         for (int i = 0;
                //             i < imageController.searchHistory.length;
                //             i++) ...{
                //           GestureDetector(
                //             onTap: () async {
                //               imageController.searchImages(
                //                   imageController.searchHistory[i]);
                //             },
                //             child: Chip(
                //                 label: Text(imageController.searchHistory[i])),
                //           )
                //         }
                //       ],
                //     ),
                //   );
                // });
              }
            }),
            Obx(() {
              return (imageController.searchLoading.value)
                  ? CircularProgressIndicator()
                  : SizedBox.shrink();
            }),
          ],
        );
      }),
    );
  }
}
