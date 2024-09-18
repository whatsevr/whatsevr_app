import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/button.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/place_search_list.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/bloc/create_post_bloc.dart';
import 'package:whatsevr_app/utils/conversion.dart';

class CreateVideoPostPageArgument {
  final EnumPostCreatorType postCreatorType;
  const CreateVideoPostPageArgument({required this.postCreatorType});
}

class CreateVideoPost extends StatelessWidget {
  final CreateVideoPostPageArgument pageArgument;
  const CreateVideoPost({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreateVideoPostBloc()
        ..add(CreatePostInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateVideoPostBloc, CreateVideoPostState>(
      builder: (BuildContext context, CreateVideoPostState state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Create Video Post',
            showAiAction: true,
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              Gap(12),
              Column(
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      double baseHeight = 200;
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
                                      extras: <String>[state.videoFile!.path],
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
                          ],
                        );
                      }
                      if (state.videoFile != null) {
                        return MaterialButton(
                          onPressed: () {
                            context
                                .read<CreateVideoPostBloc>()
                                .add(const PickThumbnailEvent());
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
                          context
                              .read<CreateVideoPostBloc>()
                              .add(const PickVideoEvent());
                        },
                        child: Container(
                          width: double.infinity,
                          height: baseHeight,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
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
                  if (state.videoFile != null || state.thumbnailFile != null)
                    Row(
                      children: <Widget>[
                        if (state.videoFile != null)
                          FutureBuilder<String?>(
                            future: getFileSize(state.videoFile!),
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<dynamic> snapshot,
                            ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  '${snapshot.data}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        Spacer(),
                        if (state.videoFile != null &&
                            state.thumbnailFile != null)
                          WhatsevrButton.outlined(
                            shrink: true,
                            miniButton: true,
                            onPressed: () {
                              context
                                  .read<CreateVideoPostBloc>()
                                  .add(const PickThumbnailEvent());
                            },
                            label: 'Update Thumb',
                          ),
                        if (state.videoFile != null) ...[
                          Gap(6),
                          WhatsevrButton.outlined(
                            miniButton: true,
                            shrink: true,
                            onPressed: () {
                              context
                                  .read<CreateVideoPostBloc>()
                                  .add(const PickVideoEvent());
                            },
                            label: 'Change Video',
                          )
                        ],
                      ],
                    ),
                ],
              ),
              Gap(12),
              WhatsevrFormField.generalTextField(
                maxLength: 100,
                controller: context.read<CreateVideoPostBloc>().titleController,
                hintText: 'Title',
              ),
              Gap(12),
              WhatsevrFormField.multilineTextField(
                maxLength: 5000,
                minLines: 5,
                maxLines: 10,
                hintText: 'Description',
              ),
              Gap(12),
              WhatsevrFormField.multilineTextField(
                hintText: 'Tags (comma separated, max 30)',
              ),
              Gap(12),
              WhatsevrFormField.invokeCustomFunction(
                context: context,
                controller:
                    context.read<CreateVideoPostBloc>().locationController,
                suffixWidget: Icon(Icons.location_on),
                hintText: 'Location',
                customFunction: () {
                  showAppModalSheet(child: PlaceSearchPage());
                },
              ),
              Gap(12),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: WhatsevrButton.filled(
              onPressed: () {
                context
                    .read<CreateVideoPostBloc>()
                    .add(const SubmitPostEvent());
              },
              label: 'Create Post',
            ),
          ),
        );
      },
    );
  }
}
