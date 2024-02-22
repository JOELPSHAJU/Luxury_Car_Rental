import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:luxurycars/Universaltools.dart';

class View_Ontap_Images extends StatefulWidget {
  final List<dynamic> images;
  const View_Ontap_Images({super.key, required this.images});

  @override
  State<View_Ontap_Images> createState() => _View_Ontap_ImagesState();
}

int currentindex = 0;

class _View_Ontap_ImagesState extends State<View_Ontap_Images> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .38,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            height: MediaQuery.of(context).size.height * .29,
            width: double.infinity,
            child: InstaImageViewer(
              child: CachedNetworkImage(
                imageUrl: widget.images[currentindex].toString(),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 30,
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: ProjectColors.primarycolor1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .09,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentindex = index;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .0,
                        width: MediaQuery.of(context).size.width * .23,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: currentindex == widget.images[index]
                                    ? ProjectColors.primarycolor1
                                    : Colors.black,
                                width: 2)),
                        child: CachedNetworkImage(
                          imageUrl: widget.images[index].toString(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.grey,
                            size: 30,
                          ),
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: ProjectColors.primarycolor1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
