import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/place_search_list.dart';
import 'package:whatsevr_app/config/widgets/product_guide/product_guides.dart';
import 'package:whatsevr_app/config/widgets/search_and_tag.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/create_posts/upload_pdf/bloc/create_post_bloc.dart';

import '../../../../../config/widgets/media/thumbnail_selection.dart';
import '../../../previewers/views/page.dart';

class UploadPdfPageArgument {
  final EnumPostCreatorType postCreatorType;
  const UploadPdfPageArgument({required this.postCreatorType});
}

class UploadPdfPage extends StatelessWidget {
  final UploadPdfPageArgument pageArgument;
  const UploadPdfPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => UploadPdfBloc()
        ..add(UploadPdfInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<UploadPdfBloc, UploadPdfState>(
      builder: (BuildContext context, UploadPdfState state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Upload Pdf Doc',
            showAiAction: true,
            showInfo: () {
              ProductGuides.showUploadPdfGuide();
            },
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              const Gap(12),
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: state.thumbnailMetaData?.aspectRatio ?? 16 / 9,
                    child: Builder(
                      builder: (BuildContext context) {
                        double baseHeight = double.infinity;
                        if (state.thumbnailFile != null) {
                          return Stack(
                            children: <Widget>[
                              ExtendedImage.file(
                                state.thumbnailFile!,
                                width: double.infinity,
                                height: baseHeight,
                                fit: BoxFit.cover,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      AppNavigationService.newRoute(
                                        RoutesName.fullVideoPlayer,
                                        extras: PreviewersPageArguments(
                                          videoUrl: state.pdfFile!.path,
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.play_circle_fill_rounded,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                              if (state.pdfMetaData != null)
                                GestureDetector(
                                  onTap: () {
                                    FileMetaData.showMetaData(
                                        state.pdfMetaData);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      '${state.pdfMetaData!.durationInText} | ${state.pdfMetaData!.sizeInText} | ${state.pdfMetaData!.width}x${state.pdfMetaData!.height}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }
                        if (state.pdfFile != null) {
                          return MaterialButton(
                            onPressed: () {
                              showWhatsevrThumbnailSelectionPage(
                                videoFile: state.pdfFile!,
                                aspectRatios: videoPostAspectRatio,
                              ).then((value) {
                                if (value != null) {
                                  context
                                      .read<UploadPdfBloc>()
                                      .add(PickThumbnailEvent(
                                        pickedThumbnailFile: value,
                                      ));
                                }
                              });
                            },
                            minWidth: double.infinity,
                            height: baseHeight,
                            color: Colors.white10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            CustomAssetPicker.pickVideoFromGallery(
                              onCompleted: (file) {
                                context
                                    .read<UploadPdfBloc>()
                                    .add(PickPdfEvent(pickPdfFile: file));
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: baseHeight,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.video_file_rounded,
                                    color: Colors.white, size: 50),
                                Text('Add a video',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.pdfFile != null || state.thumbnailFile != null)
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        if (state.pdfFile != null &&
                            state.thumbnailFile != null)
                          WhatsevrButton.filled(
                            shrink: true,
                            miniButton: true,
                            onPressed: () {
                              showWhatsevrThumbnailSelectionPage(
                                videoFile: state.pdfFile!,
                                aspectRatios: videoPostAspectRatio,
                              ).then((value) {
                                if (value != null) {
                                  context
                                      .read<UploadPdfBloc>()
                                      .add(PickThumbnailEvent(
                                        pickedThumbnailFile: value,
                                      ));
                                }
                              });
                            },
                            label: 'Update Thumb',
                          ),
                        if (state.pdfFile != null) ...[
                          const Gap(6),
                          WhatsevrButton.filled(
                            miniButton: true,
                            shrink: true,
                            onPressed: () {
                              CustomAssetPicker.pickVideoFromGallery(
                                onCompleted: (file) {
                                  context
                                      .read<UploadPdfBloc>()
                                      .add(PickPdfEvent(pickPdfFile: file));
                                },
                              );
                            },
                            label: 'Change Video',
                          )
                        ],
                      ],
                    ),
                ],
              ),
              const Gap(12),
              WhatsevrFormField.generalTextField(
                maxLength: 100,
                controller: context.read<UploadPdfBloc>().titleController,
                hintText: 'Title',
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                controller: context.read<UploadPdfBloc>().descriptionController,
                maxLength: 5000,
                minLines: 5,
                maxLines: 10,
                hintText: 'Description',
              ),
              const Gap(50),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: WhatsevrButton.filled(
              onPressed: () {
                context.read<UploadPdfBloc>().add(const SubmitPostEvent());
              },
              label: 'Done',
            ),
          ),
        );
      },
    );
  }
}
