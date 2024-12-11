import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/product_guide/product_guides.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:whatsevr_app/src/features/create_posts/upload_pdf/bloc/upload_pdf_bloc.dart';

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
          appBar: WhatsevrAppBar(
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
                        final double baseHeight = double.infinity;

                        if (state.pdfFile != null) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: baseHeight,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: state.thumbnailFile == null
                                    ? null
                                    : DecorationImage(
                                        image: ExtendedFileImageProvider(
                                          state.thumbnailFile!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              child: state.thumbnailFile == null
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ),
                                          Gap(6),
                                          Text(
                                            'View Pdf',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Gap(6),
                                          Text(
                                            '(${FileMetaData.getFileSize(state.pdfFile?.lengthSync())})',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            CustomAssetPicker.pickDocuments(
                              onCompleted: (file) {
                                context
                                    .read<UploadPdfBloc>()
                                    .add(PickPdfEvent(pickPdfFile: file.first));
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
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Gap(6),
                                Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.pdfFile != null)
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        WhatsevrButton.filled(
                          shrink: true,
                          miniButton: true,
                          onPressed: () {
                            CustomAssetPicker.pickImageFromGallery(
                              aspectRatios: videoPostAspectRatio,
                              onCompleted: (file) {
                                context.read<UploadPdfBloc>().add(
                                      PickThumbnailEvent(
                                        pickedThumbnailFile: file,
                                      ),
                                    );
                              },
                            );
                          },
                          label: 'Add Thumbnail',
                        ),
                        const Gap(6),
                        WhatsevrButton.filled(
                          miniButton: true,
                          shrink: true,
                          onPressed: () {
                            CustomAssetPicker.pickDocuments(
                              onCompleted: (file) {
                                context
                                    .read<UploadPdfBloc>()
                                    .add(PickPdfEvent(pickPdfFile: file.first));
                              },
                            );
                          },
                          label: 'Change Pdf',
                        ),
                      ],
                    ),
                ],
              ),
              const Gap(12),
              WhatsevrFormField.generalTextField(
                maxLength: 100,
                controller: context.read<UploadPdfBloc>().titleController,
                headingTitle: 'Title',
                hintText: 'Enter title for your PDF document',
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                controller: context.read<UploadPdfBloc>().descriptionController,
                maxLength: 5000,
                minLines: 5,
                maxLines: 10,
                headingTitle: 'Description',
                hintText:
                    'Enter description about your PDF document (max 5000 characters)',
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
