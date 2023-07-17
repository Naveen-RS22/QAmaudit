import 'package:flutter/material.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_view_model.dart';
import 'package:qapp/app/res/images.dart';

class GalleryWidget extends StatefulWidget {
  final ImageGalleryViewModal views;
  const GalleryWidget({required this.views, Key? key}) : super(key: key);

  @override
  State<GalleryWidget> createState() => GalleryWidgetState();
}

class GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              for (int i = 0;
                  i <
                      (widget.views.getGalleryListResponseData.data ?? [])
                          .length;
                  i++)
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => showDialog(
                            builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  title: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      ((widget.views.getGalleryListResponseData
                                                      .data ??
                                                  [])[i]
                                              .filePath ??
                                          ''),
                                      height: 500,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          ImagePath.imgThumbnail,
                                          height: 500,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            context: context),
                        child: Column(
                          children: [
                            Image.network(
                              ((widget.views.getGalleryListResponseData.data ??
                                          [])[i]
                                      .filePath ??
                                  ''),
                              height: 110,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImagePath.imgThumbnail,
                                  height: 110,
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                                ('${((widget.views.getGalleryListResponseData.data ?? [])[i].date ?? '').characters.take(10)}${(widget.views.getGalleryListResponseData.data ?? [])[i].unitCode ?? ''}${(widget.views.getGalleryListResponseData.data ?? [])[i].audittype ?? ''}_${(widget.views.getGalleryListResponseData.data ?? [])[i].defectName ?? ''}_${(widget.views.getGalleryListResponseData.data ?? [])[i].fName ?? ''}')
                                    .characters
                                    .take(25)
                                    .toString())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
