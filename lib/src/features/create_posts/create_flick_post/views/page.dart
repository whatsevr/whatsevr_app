import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

import '../../../../../config/enums/post_creator_type.dart';
import '../../../../../config/routes/router.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../config/widgets/app_bar.dart';
import '../../../../../config/widgets/button.dart';
import '../../../../../config/widgets/media/asset_picker.dart';
import '../../../../../config/widgets/media/meta_data.dart';
import '../../../../../config/widgets/media/thumbnail_selection.dart';
import '../../../../../config/widgets/pad_horizontal.dart';
import '../../../../../config/widgets/place_search_list.dart';
import '../../../../../config/widgets/product_guide/product_guides.dart';
import '../../../../../config/widgets/search_and_tag.dart';
import '../../../../../config/widgets/showAppModalSheet.dart';
import '../../../../../config/widgets/super_textform_field.dart';

import '../../../media_previewer/views/page.dart';
import '../bloc/create_flick_bloc.dart';

class CreateFlickPostPageArgument {
  final EnumPostCreatorType postCreatorType;

  CreateFlickPostPageArgument({required this.postCreatorType});
}

class CreateFlickPostPage extends StatelessWidget {
  final CreateFlickPostPageArgument pageArgument;
  const CreateFlickPostPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreateFlickPostBloc()
        ..add(CreatePostInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateFlickPostBloc, CreateFlickPostState>(
      builder: (BuildContext context, CreateFlickPostState state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Create Flick',
            showAiAction: true,
            showInfo: () {
              ProductGuides.showFlickPostCreationGuide();
            },
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              const Gap(12),
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: state.videoMetaData?.aspectRatio ?? 9 / 12,
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
                                        extras: MediaPreviewerPageArguments(
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
                                GestureDetector(
                                  onTap: () {
                                    FileMetaData.showMetaData(
                                        state.videoMetaData);
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
                                      '${state.videoMetaData!.durationInText} | ${state.videoMetaData!.sizeInText} | ${state.videoMetaData!.width}x${state.videoMetaData!.height}',
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
                        if (state.videoFile != null) {
                          return MaterialButton(
                            onPressed: () {
                              showWhatsevrThumbnailSelectionPage(
                                videoFile: state.videoFile!,
                                allowPickFromGallery: false,
                                aspectRatios: flicksAspectRatio,
                              ).then((value) {
                                if (value != null) {
                                  context
                                      .read<CreateFlickPostBloc>()
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
                                    .read<CreateFlickPostBloc>()
                                    .add(PickVideoEvent(pickVideoFile: file));
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
                  if (state.videoFile != null || state.thumbnailFile != null)
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        if (state.videoFile != null &&
                            state.thumbnailFile != null)
                          WhatsevrButton.filled(
                            shrink: true,
                            miniButton: true,
                            onPressed: () {
                              showWhatsevrThumbnailSelectionPage(
                                videoFile: state.videoFile!,
                                aspectRatios: flicksAspectRatio,
                              ).then((value) {
                                if (value != null) {
                                  context
                                      .read<CreateFlickPostBloc>()
                                      .add(PickThumbnailEvent(
                                        pickedThumbnailFile: value,
                                      ));
                                }
                              });
                            },
                            label: 'Update Thumb',
                          ),
                        if (state.videoFile != null) ...[
                          const Gap(6),
                          WhatsevrButton.filled(
                            miniButton: true,
                            shrink: true,
                            onPressed: () {
                              CustomAssetPicker.pickVideoFromGallery(
                                onCompleted: (file) {
                                  context
                                      .read<CreateFlickPostBloc>()
                                      .add(PickVideoEvent(pickVideoFile: file));
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
                controller: context.read<CreateFlickPostBloc>().titleController,
                hintText: 'Title',
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                controller:
                    context.read<CreateFlickPostBloc>().descriptionController,
                maxLength: 5000,
                minLines: 5,
                maxLines: 10,
                hintText: 'Description',
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                controller:
                    context.read<CreateFlickPostBloc>().hashtagsController,
                hintText: 'Hashtags (start with #, max 30)',
              ),
              const Gap(12),
              WhatsevrFormField.invokeCustomFunction(
                context: context,
                controller: TextEditingController(
                  text: state.selectedAddress ?? '',
                ),
                suffixWidget: const Icon(Icons.location_on),
                hintText: 'Location',
                customFunction: () {
                  showAppModalSheet(child: PlaceSearchByNamePage(
                    onPlaceSelected: (placeName, lat, long) {
                      context
                          .read<CreateFlickPostBloc>()
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
                const Gap(8),
                SizedBox(
                  height: 22,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<CreateFlickPostBloc>()
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
                      return const Gap(4);
                    },
                    itemCount: state.placesNearbyResponse?.places?.length ?? 0,
                  ),
                ),
              ],
              const Gap(18),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  showAppModalSheet(
                    child: SearchAndTagUsersAndCommunityPage(
                      onDone: (selectedUsersUid, selectedCommunitiesUid) {
                        context
                            .read<CreateFlickPostBloc>()
                            .add(UpdateTaggedUsersAndCommunitiesEvent(
                              taggedUsersUid: selectedUsersUid,
                              taggedCommunitiesUid: selectedCommunitiesUid,
                            ));
                      },
                    ),
                  );
                },
                child: const Row(
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
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Selected ',
                              style: TextStyle(color: Colors.black),
                            ),
                            if (state.taggedUsersUid.isNotEmpty) ...[
                              TextSpan(
                                text: '${state.taggedUsersUid.length} users',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                            if (state.taggedUsersUid.isNotEmpty &&
                                state.taggedCommunitiesUid.isNotEmpty)
                              const TextSpan(
                                text: ' and ',
                                style: TextStyle(color: Colors.black),
                              ),
                            if (state.taggedCommunitiesUid.isNotEmpty) ...[
                              TextSpan(
                                text:
                                    '${state.taggedCommunitiesUid.length} communities',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CreateFlickPostBloc>().add(
                            const UpdateTaggedUsersAndCommunitiesEvent(
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
                context
                    .read<CreateFlickPostBloc>()
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
