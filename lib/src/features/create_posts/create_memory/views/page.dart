import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';

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
import '../bloc/create_memory_bloc.dart';

class CreateMemoryPageArgument {
  final EnumPostCreatorType postCreatorType;

  CreateMemoryPageArgument({required this.postCreatorType});
}

class CreateMemoryPage extends StatelessWidget {
  final CreateMemoryPageArgument pageArgument;

  const CreateMemoryPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreateMemoryBloc()
        ..add(CreateMemoryInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateMemoryBloc, CreateMemoryState>(
      builder: (BuildContext context, CreateMemoryState state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Create Memory',
            showAiAction: true,
            showInfo: () {
              ProductGuides.showMemoryCreationGuide();
            },
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              const Gap(12),
              Builder(
                builder: (context) {
                  if (state.isVideoMemory == true) {
                    return Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio:
                              state.videoMetaData?.aspectRatio ?? 9 / 12,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            AppNavigationService.newRoute(
                                              RoutesName.fullVideoPlayer,
                                              extras:
                                                  MediaPreviewerPageArguments(
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
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          context.read<CreateMemoryBloc>().add(
                                              const RemoveVideoOrImageEvent());
                                        },
                                        icon: const Icon(
                                          Icons.clear_rounded,
                                          color: Colors.red,
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.only(
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
                                            .read<CreateMemoryBloc>()
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
                                      context.read<CreateMemoryBloc>().add(
                                          PickVideoEvent(pickVideoFile: file));
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
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (state.videoFile != null ||
                            state.thumbnailFile != null)
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
                                            .read<CreateMemoryBloc>()
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
                                        context.read<CreateMemoryBloc>().add(
                                            PickVideoEvent(
                                                pickVideoFile: file));
                                      },
                                    );
                                  },
                                  label: 'Change Video',
                                )
                              ],
                            ],
                          ),
                      ],
                    );
                  }
                  if (state.isImageMemory == true) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ExtendedImage.file(
                              state.imageFile!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            //delete
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<CreateMemoryBloc>()
                                      .add(const RemoveVideoOrImageEvent());
                                },
                                icon: const Icon(
                                  Icons.clear_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state.imageFile != null)
                          Row(
                            children: <Widget>[
                              const Spacer(),
                              WhatsevrButton.filled(
                                miniButton: true,
                                shrink: true,
                                onPressed: () {
                                  CustomAssetPicker.pickImageFromGallery(
                                    onCompleted: (file) {
                                      context
                                          .read<CreateMemoryBloc>()
                                          .add(PickImageEvent(
                                            pickedImageFile: file,
                                          ));
                                    },
                                  );
                                },
                                label: 'Change Image',
                              ),
                            ],
                          ),
                      ],
                    );
                  }
                  return AspectRatio(
                    aspectRatio: WhatsevrAspectRatio.portrait2by3.ratio,
                    child: MaterialButton(
                      onPressed: () {
                        showWhatsevrMediaPickerChoice(
                          onChoosingImageFromGallery: () {
                            CustomAssetPicker.pickImageFromGallery(
                              onCompleted: (file) {
                                context
                                    .read<CreateMemoryBloc>()
                                    .add(PickImageEvent(pickedImageFile: file));
                              },
                            );
                          },
                          onChoosingVideoFromGallery: () {
                            CustomAssetPicker.pickVideoFromGallery(
                              onCompleted: (file) {
                                context
                                    .read<CreateMemoryBloc>()
                                    .add(PickVideoEvent(pickVideoFile: file));
                              },
                            );
                          },
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      child: Text('Add Image or Video',
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                maxLength: 100,
                minLines: 3,
                controller: context.read<CreateMemoryBloc>().titleController,
                hintText: 'Caption',
              ),
              const Gap(12),
              Theme(
                data: ThemeData(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTileItem.flat(
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  title: Text('More Options',
                      style: TextStyle(color: Colors.black)),
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showAppModalSheet(
                          child: SearchAndTagUsersAndCommunityPage(
                            onDone: (selectedUsersUid, selectedCommunitiesUid) {
                              context
                                  .read<CreateMemoryBloc>()
                                  .add(UpdateTaggedUsersAndCommunitiesEvent(
                                    taggedUsersUid: selectedUsersUid,
                                    taggedCommunitiesUid:
                                        selectedCommunitiesUid,
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
                          Text('Mention',
                              style: TextStyle(color: Colors.black)),
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
                                      text:
                                          '${state.taggedUsersUid.length} users',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                  if (state.taggedUsersUid.isNotEmpty &&
                                      state.taggedCommunitiesUid.isNotEmpty)
                                    const TextSpan(
                                      text: ' and ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  if (state
                                      .taggedCommunitiesUid.isNotEmpty) ...[
                                    TextSpan(
                                      text:
                                          '${state.taggedCommunitiesUid.length} communities',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<CreateMemoryBloc>().add(
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
                    const Gap(12),
                    Column(
                      children: [
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
                                    .read<CreateMemoryBloc>()
                                    .add(UpdatePostAddressEvent(
                                      address: placeName,
                                      addressLatitude: lat,
                                      addressLongitude: long,
                                    ));
                              },
                            ));
                          },
                        ),
                        if (state.placesNearbyResponse?.places?.isNotEmpty ??
                            false) ...[
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
                                        .read<CreateMemoryBloc>()
                                        .add(UpdatePostAddressEvent(
                                          address: state
                                              .placesNearbyResponse
                                              ?.places?[index]
                                              .displayName
                                              ?.text,
                                          addressLatitude: state
                                              .placesNearbyResponse
                                              ?.places?[index]
                                              .location
                                              ?.latitude,
                                          addressLongitude: state
                                              .placesNearbyResponse
                                              ?.places?[index]
                                              .location
                                              ?.longitude,
                                        ));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                              itemCount:
                                  state.placesNearbyResponse?.places?.length ??
                                      0,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Gap(12),
                    WhatsevrFormField.invokeCustomFunction(
                      context: context,
                      customFunction: () {},
                    ),
                    const Gap(12),
                    WhatsevrFormField.generalTextField(
                      hintText: 'CTA Action URL',
                    ),
                  ],
                ),
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
                context.read<CreateMemoryBloc>().add(const SubmitPostEvent());
              },
              label: 'Done',
            ),
          ),
        );
      },
    );
  }
}