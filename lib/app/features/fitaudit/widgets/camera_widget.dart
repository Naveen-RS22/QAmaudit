import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';

class CameraWidget extends StatefulWidget {
  final FitAuditViewModal viewsData;

  const CameraWidget({Key? key, required this.viewsData}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  int currentCameraIndex = 0;
  List<File> capturedImages = [];
  File? selectedImage;
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;
  bool isFocusing = false;
  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[currentCameraIndex], ResolutionPreset.medium);
    await controller?.initialize();
    setState(() {});
  }

  void captureImage() async {
    try {
      if (!controller!.value.isInitialized) {
        return;
      }
      final image = await controller?.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now()}.png';
      final imagePath = path.join(directory.path, fileName);
      final compressedImageFile = await compressImage(File(image!.path));
      await compressedImageFile.copy(imagePath);
      print('Image located at: $imagePath');
      capturedImages.add(File(imagePath));
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<File> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final targetPath =
        path.join(tempPath, '${DateTime.now().millisecondsSinceEpoch}.jpg');

    var result = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      quality: 98,
      minWidth: 1024,
      minHeight: 1024,
    );

    return result!;
  }

  void switchCamera() {
    currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
    controller =
        CameraController(cameras[currentCameraIndex], ResolutionPreset.medium);
    controller?.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void deleteImage(int index) async {
    final imageFile = capturedImages[index];
    if (await imageFile.exists()) {
      if (selectedImage == imageFile) {
        setState(() {
          selectedImage = null;
        });
      }
      await imageFile.delete();
      capturedImages.removeAt(index);
      setState(() {});
    }
  }

  Future<void> saveAllImages() async {
    if (capturedImages.isNotEmpty) {
      widget.viewsData.postImageUploadList(context, capturedImages);
      // print((DateTime.now().toString().split('.')[1]));
      for (final imageFile in capturedImages) {
        print(
            '${imageFile.path.split(' ')[1].split('.')[1]}.${imageFile.path.split(' ')[1].split('.')[2]}');
        // await GallerySaver.saveImage(imageFile.path);

        print('Image Saved: ${imageFile.path}');
      }
      setState(() {
        if (capturedImages.isNotEmpty) {
        } else if (capturedImages.isEmpty) {
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        selectedImage = null;
      });
    } else {
      final snackBar = SnackBar(
        content: const Text('no images captured',
            style: TextStyle(
              fontSize: 20,
            )),
        backgroundColor: (const Color(0xFFFF0000)),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // capturedImages.clear();
  }

  Future<void> clearAllImages() async {
    setState(() {
      capturedImages.clear();
    });
  }

  void _onCameraViewTap(TapDownDetails details) {
    if (controller!.value.isInitialized) {
      final x = details.globalPosition.dx;
      final y = details.globalPosition.dy;
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final focusX = x / screenWidth;
      final focusY = y / screenHeight;

      setState(() {
        isFocusing = true;
      });
      controller?.setExposurePoint(Offset(focusX, focusY));
      controller?.setFocusPoint(Offset(focusX, focusY));
      controller?.setExposureMode(ExposureMode.auto);
      controller?.setFocusMode(FocusMode.auto).then((_) {
        setState(() {
          isFocusing = false;
        });
      });
    }
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }

  void showImagePreview(File imageFile) {
    _transformationController.value = Matrix4.identity();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int initialImageIndex = capturedImages.indexOf(imageFile);
        if (initialImageIndex == -1) {
          initialImageIndex = 0; // Set to 0 if imageFile is not found
        }
        int currentImageIndex = initialImageIndex;
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                heightFactor: 0.8,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTapDown: _handleDoubleTapDown,
                        onDoubleTap: _handleDoubleTap,
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          child: Image.file(capturedImages[currentImageIndex]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              if (currentImageIndex <
                                  capturedImages.length - 1) {
                                setState(() {
                                  currentImageIndex++;
                                  _transformationController.value =
                                      Matrix4.identity();
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (currentImageIndex > 0) {
                                setState(() {
                                  currentImageIndex--;
                                  _transformationController.value =
                                      Matrix4.identity();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      // Expanded(
                      //   child: GridView.builder(
                      //     itemCount: capturedImages.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 1,
                      //       crossAxisSpacing: 7.0,
                      //       mainAxisSpacing: 7,
                      //       mainAxisExtent: 190,
                      //     ),
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       int rev = capturedImages.length - 1 - index;
                      //       if (rev < 0 || rev >= capturedImages.length) {
                      //         return Container(); // Skip rendering if index is invalid
                      //       }
                      //       return Stack(
                      //         children: [
                      //           GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 showImagePreview(capturedImages[rev]);
                      //               });
                      //             },
                      //             child: Image.file(capturedImages[rev]),
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> showExitPopup() async {
    bool willLeave = false;
    // show the confirm dialog

    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Are you sure want to leave?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      willLeave = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No')),
                if (capturedImages.isNotEmpty) ...[
                  ElevatedButton(
                    onPressed: () {
                      saveAllImages();
                      willLeave = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save And Exit'),
                  ),
                ]
              ],
            ));
    return willLeave;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Camera'),
              const SizedBox(
                width: 800,
              ),
              if (capturedImages.isNotEmpty) const Spacer(),
              Text(
                '${capturedImages.length} image(s)',
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: clearAllImages,
                child: const Text('Clear All'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: saveAllImages,
                child: const Text('Save All Images'),
              ),
            ],
          ),
        ),
        body: Row(
          children: <Widget>[
            Stack(
              children: [
                if (controller?.value.isInitialized == true)
                  GestureDetector(
                    onTapDown: _onCameraViewTap,
                    child: CameraPreview(controller!),
                  ),
                if (selectedImage != null)
                  GestureDetector(
                    onTap: () => showImagePreview(selectedImage!),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                if (isFocusing)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.8,
                  // color: Colors.blue,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // FloatingActionButton(
                          //   onPressed: switchCamera,
                          //   child: const Icon(Icons.switch_camera),
                          // ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              onPressed: captureImage,
                              child: const Icon(
                                Icons.camera,
                                size: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: capturedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 7,
                  mainAxisExtent: 190,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int rev = capturedImages.length - 1 - index;
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showImagePreview(capturedImages[rev]);
                        },
                        child: Image.file(capturedImages[rev]),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 40,
                          ),
                          onPressed: () {
                            deleteImage(rev);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Stack(
              children: [
                // Expanded(
                //   child: selectedImage != null
                //       ? GestureDetector(
                //           onDoubleTapDown: _handleDoubleTapDown,
                //           onDoubleTap: _handleDoubleTap,
                //           child: InteractiveViewer(
                //             transformationController: _transformationController,
                //             boundaryMargin: const EdgeInsets.all(30.0),
                //             child: Image.file(selectedImage!),
                //           ),
                //         )
                //       : const SizedBox(),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
