import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class Convert extends StatefulWidget {
  final List<File> image;
  Convert({super.key, required this.image});

  @override
  _ConvertState createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  TextEditingController _controller = TextEditingController();
  int selectedButton = 0;
  List<String> labels = ["No Margin", "Small Margin", "Big Margin"];

  Future<void> createPdf(BuildContext context, List<File> _images) async {
    final pdf = pw.Document();

    for (var imageFile in _images) {
      final image = pw.MemoryImage(imageFile.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                margin: pw.EdgeInsets.all(
                  selectedButton * 5,
                ), // Adds margin around the image
                child: pw.Image(image),
              ),
            );
          },
        ),
      );
    }

    // Ask user where to save the file
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No directory selected! PDF not saved.")),
      );
      return;
    }

    // Ask user for file name
    String fileName = await _askFileName(context);
    if (fileName.isEmpty) return;

    // Save the file in the selected directory
    final filePath = "$selectedDirectory/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Show success message and open the file
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("PDF saved to: $filePath")));

    OpenFile.open(filePath);
  }

  Future<String> _askFileName(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    String fileName = "";

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Enter File Name"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter PDF name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  fileName = controller.text.trim();
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
    );

    return fileName;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(title: Text("Convert Images to PDF")),
  //       body: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: List.generate(labels.length, (index) {
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 20.0,
  //                   vertical: 20,
  //                 ),
  //                 child: ElevatedButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: WidgetStateProperty.all(
  //                       selectedButton == index
  //                           ? Colors.blue
  //                           : Colors.grey[400],
  //                     ),
  //                     shape: WidgetStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(
  //                           15,
  //                         ), // ✅ Rounded corners
  //                       ),
  //                     ),
  //                     padding: WidgetStateProperty.all(
  //                       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     setState(() {
  //                       selectedButton = index;
  //                     });
  //                   },
  //                   child: Text(
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color:
  //                           selectedButton == index
  //                               ? Colors.white
  //                               : Colors.white,
  //                     ),
  //                     labels[index].split(' ').join('\n'),
  //                   ),
  //                 ),
  //               );
  //             }),
  //           ), // ✅ Fixed GridView height issue
  //           Align(
  //             alignment: Alignment.center,
  //             child: Container(
  //               padding: EdgeInsets.all(selectedButton * 5),
  //               height: (141.4 * 4) / 2,
  //               width: (100 * 4) / 2,

  //               decoration: BoxDecoration(
  //                 color: Colors.grey[400],
  //                 // border: Border.all(
  //                 //   color: Colors.black, // Border color
  //                 //   width: 2, // Border width
  //                 // ),
  //               ),
  //               child: Image.file(widget.image[0]),
  //             ),
  //           ),
  //           Spacer(),
  //           Container(
  //             width: double.infinity, // Expands to full width
  //             margin: EdgeInsets.symmetric(
  //               horizontal: 20,
  //               vertical: 10,
  //             ), // Margin
  //             child: ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: WidgetStateProperty.all(Colors.blue),
  //                 shape: WidgetStateProperty.all(
  //                   RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(
  //                       5,
  //                     ), // ✅ Rounded corners
  //                   ),
  //                 ),
  //                 padding: WidgetStateProperty.all(
  //                   EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                 ),
  //               ),
  //               onPressed: () => createPdf(context, widget.image),
  //               child: Text(
  //                 "Save as PDF",
  //                 style: TextStyle(color: Colors.white, fontSize: 20),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false, // ✅ Prevents sliding
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(189, 6, 10, 0.80),
          title: Text(
            "Convert Images to PDF",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(labels.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: 20,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        selectedButton == index
                            ? Colors.blue
                            : Colors.grey[400],
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedButton = index;
                      });
                    },
                    child: Text(
                      labels[index].split(' ').join('\n'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(selectedButton * 5),
                height: (141.4 * 4) / 2,
                width: (100 * 4) / 2,
                decoration: BoxDecoration(color: Colors.grey[400]),
                child: Image.file(widget.image[0]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Text(
                    "Created by Nexio Dev Group",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Contact at : ", textAlign: TextAlign.center),
                      Text(
                        ' +91 8905924424',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),

            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromRGBO(66, 128, 239, 1),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
                onPressed: () => createPdf(context, widget.image),
                child: Text(
                  "Save as PDF",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.0,
      ),
      itemCount: labels.length, // Ensure correct button count
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ButtonStyle(
            // fixedSize: WidgetStateProperty.all(Size(2000, 50)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // ✅ Rounded corners
              ),
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            backgroundColor: WidgetStateProperty.all(
              index == selectedButton ? Colors.blue : Colors.grey[300],
            ),
          ),
          onPressed: () {
            setState(() {
              selectedButton = index;
            });
          },
          child: Text(
            labels[index],
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
