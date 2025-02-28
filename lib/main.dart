import 'dart:io';
import 'preview_convert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Picker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final List<File> _images = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to pick multiple images from the gallery
  Future<void> _pickImages() async {
    final List<XFile>? pickedFile = await _picker.pickMultiImage();

    if (pickedFile != null) {
      setState(() {
        for (int temp = 0; temp < pickedFile.length; temp++) {
          _images.add(File(pickedFile[temp].path));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(189, 6, 10, 0.80),
        title: Text(
          "Convert Images to PDF",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Align(
        alignment: Alignment.topCenter, // Ensures the Column starts at the top
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: [
            Expanded(
              child:
                  _images.isNotEmpty
                      // ? Image.file(_image!, height: 200)
                      ? Container(
                        height: 500,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: gridView(_images),
                      )
                      : Center(
                        child: Text(
                          "No image selected",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromRGBO(52, 163, 83, 1), // ✅ Corrected
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 17, horizontal: 33),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // ✅ Rounded corners
                        ),
                      ),
                    ),
                    icon: Icon(Icons.photo, size: 22, color: Colors.white),
                    label: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: _pickImages,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromRGBO(66, 128, 239, 1), // ✅ Corrected
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 17, horizontal: 33),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // ✅ Rounded corners
                        ),
                      ),
                    ),

                    onPressed: () {
                      _images.isNotEmpty
                          ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => Convert(
                                    image: _images,
                                  ), // Navigate to SecondPage
                            ),
                          )
                          : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No Image was Selected...")),
                          );
                    },
                    icon: Icon(Icons.send, color: Colors.white, size: 22),
                    label: Text(
                      "Convert",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget gridView(List<File> images) {
  //   return ReorderableGridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2, // Number of columns
  //       crossAxisSpacing: 20,
  //       mainAxisSpacing: 20,
  //       childAspectRatio: 1.0,
  //     ),
  //     onReorder: (oldIndex, newIndex) {
  //       setState(() {
  //         final item = _images.removeAt(oldIndex);
  //         _images.insert(newIndex, item);
  //       });
  //     },
  //     itemCount: images.length,
  //     itemBuilder: (context, index) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: Colors.grey[300],
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Stack(
  //           children: [
  //             Align(
  //               alignment: Alignment.center,
  //               child: Image.file(images[index]),
  //             ),
  //             Positioned(
  //               top: 5, // Adjust this value to position correctly
  //               right: 5, // Adjust this value to position correctly
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Color.fromRGBO(189, 6, 10, 0.80),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 width: 25, // Ensure it's a proper size for the icon
  //                 height: 25,
  //                 child: IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       _images.removeAt(index);
  //                     });
  //                   },
  //                   icon: Icon(Icons.close, color: Colors.white, size: 18),
  //                   padding: EdgeInsets.zero, // Remove extra padding
  //                   constraints: BoxConstraints(), // Remove default constraints
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget gridView(List<File> images) {
    return ReorderableGridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.0,
      ),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final item = _images.removeAt(oldIndex);
          _images.insert(newIndex, item);
        });
      },
      itemCount: images.length,
      itemBuilder: (context, index) {
        return KeyedSubtree(
          key: ValueKey(images[index].path), // Unique key for each item
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.file(images[index]),
                ),
                Positioned(
                  top: 5, // Adjust this value to position correctly
                  right: 5, // Adjust this value to position correctly
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(229, 67, 53, 0.80),
                      shape: BoxShape.circle,
                    ),
                    width: 25, // Ensure it's a proper size for the icon
                    height: 25,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _images.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.close, color: Colors.white, size: 18),
                      padding: EdgeInsets.zero, // Remove extra padding
                      constraints:
                          BoxConstraints(), // Remove default constraints
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// 52,163,83
// 66,128,239
// 229,67,53 created by Nexio Developer Group (mobile - neeche wali line me)