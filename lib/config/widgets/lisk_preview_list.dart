import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/services/launch_url.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

class LinksPreviewListView extends StatefulWidget {
  final List<String> urls;
  final bool largePreview;
  const LinksPreviewListView(
      {super.key, required this.urls, this.largePreview = true});

  @override
  State<LinksPreviewListView> createState() => _LinksPreviewListViewState();
}

class _LinksPreviewListViewState extends State<LinksPreviewListView> {
  List<String> urlWithHttps = [];
  Map<String, PreviewData> data = {};
  @override
  void initState() {
    super.initState();
    for (final url in widget.urls) {
      // add https:// to the url if it doesn't have it
      if (!url.startsWith('http')) {
        urlWithHttps.add('https://$url');
      } else {
        urlWithHttps.add(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urlWithHttps.length,
      itemBuilder: (context, index) => Align(
        alignment: Alignment.centerLeft,
        child: LinkPreview(
          enableAnimation: true,
          onPreviewDataFetched: (previewData) {
            setState(() {
              data = {
                ...data,
                urlWithHttps[index]: previewData,
              };
            });
          },
          previewData: data[urlWithHttps[index]],
          text: urlWithHttps[index],
          width: MediaQuery.of(context).size.width,
          linkStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          onLinkPressed: (url) {
            launchWebURL(context, url: url);
          },
          previewBuilder: (ctx, previewData) {
            return GestureDetector(
                onTap: () {
                  launchWebURL(context, url: urlWithHttps[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Builder(builder: (context) {
                    if (widget.largePreview) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            previewData.title ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (previewData.image != null) ...[
                            Gap(10),
                            ExtendedImage.network(
                              previewData.image!.url,
                              enableLoadState: false,
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              width: double.infinity,
                            )
                          ],
                          Gap(10),
                          Text(
                            previewData.description ?? '',
                            maxLines: 10,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      );
                    }
                    return ListTile(
                      title: Text(
                        previewData.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        previewData.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      leading: previewData.image != null
                          ? ExtendedImage.network(
                              previewData.image!.url,
                              enableLoadState: false,
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              width: 100,
                            )
                          : null,
                    );
                  }),
                ));
          },
        ),
      ),
    );
  }
}
