import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/place_search_list.dart';
import 'package:whatsevr_app/config/widgets/search_and_tag.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/bloc/create_post_bloc.dart';
import 'package:whatsevr_app/src/features/full_video_player/views/page.dart';
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
                                      extras: FullVideoPlayerPageArguments(
                                        videoUrl: state.videoFile!.path,
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
                            if (state.videoMetaData != null)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  '${state.videoMetaData!.durationInText} | ${state.videoMetaData!.sizeInText} | ${state.videoMetaData!.width}x${state.videoMetaData!.height}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
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
                        Spacer(),
                        if (state.videoFile != null &&
                            state.thumbnailFile != null)
                          WhatsevrButton.filled(
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
                          WhatsevrButton.filled(
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
                controller:
                    context.read<CreateVideoPostBloc>().hashtagsController,
                hintText: 'Hashtags (start with #, max 30)',
              ),
              Gap(12),
              WhatsevrFormField.invokeCustomFunction(
                context: context,
                controller: TextEditingController(
                  text: state.selectedAddress ?? '',
                ),
                suffixWidget: Icon(Icons.location_on),
                hintText: 'Location',
                customFunction: () {
                  showAppModalSheet(child: PlaceSearchByNamePage(
                    onPlaceSelected: (placeName, lat, long) {
                      context
                          .read<CreateVideoPostBloc>()
                          .add(UpdatePostAddressEvent(
                            address: placeName,
                            addressLatitude: lat,
                            addressLongitude: long,
                          ));
                    },
                  ));
                },
              ),
              if (state.placesNearbyResponse?.places?.isNotEmpty ?? false) ...[
                Gap(8),
                SizedBox(
                  height: 22,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<CreateVideoPostBloc>()
                              .add(UpdatePostAddressEvent(
                                address: state.placesNearbyResponse
                                    ?.places?[index].displayName?.text,
                                addressLatitude: state.placesNearbyResponse
                                    ?.places?[index].location?.latitude,
                                addressLongitude: state.placesNearbyResponse
                                    ?.places?[index].location?.longitude,
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${state.placesNearbyResponse?.places?[index].displayName?.text}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gap(4);
                    },
                    itemCount: state.placesNearbyResponse?.places?.length ?? 0,
                  ),
                ),
              ],
              Gap(18),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  showAppModalSheet(
                    child: SearchAndTagUsersAndCommunityPage(
                      onDone: (selectedUsersUid, selectedCommunitiesUid) {
                        context
                            .read<CreateVideoPostBloc>()
                            .add(UpdateTaggedUsersAndCommunitiesEvent(
                              taggedUsersUid: selectedUsersUid,
                              taggedCommunitiesUid: selectedCommunitiesUid,
                            ));
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    Gap(4),
                    Text('Tag People', style: TextStyle(color: Colors.black)),
                    Spacer(),
                    Icon(Icons.arrow_right_rounded, color: Colors.black),
                  ],
                ),
              ),
              if (state.taggedUsersUid.isNotEmpty ||
                  state.taggedCommunitiesUid.isNotEmpty) ...[
                Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Selected ',
                              style: TextStyle(color: Colors.black),
                            ),
                            if (state.taggedUsersUid.isNotEmpty) ...[
                              TextSpan(
                                text: '${state.taggedUsersUid.length} users',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                            if (state.taggedUsersUid.isNotEmpty &&
                                state.taggedCommunitiesUid.isNotEmpty)
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(color: Colors.black),
                              ),
                            if (state.taggedCommunitiesUid.isNotEmpty) ...[
                              TextSpan(
                                text:
                                    '${state.taggedCommunitiesUid.length} communities',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CreateVideoPostBloc>().add(
                            UpdateTaggedUsersAndCommunitiesEvent(
                                clearAll: true));
                      },
                      child: const Icon(
                        Icons.clear_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
              Gap(50),
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
