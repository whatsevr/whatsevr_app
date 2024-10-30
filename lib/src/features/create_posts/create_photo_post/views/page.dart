import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../config/enums/post_creator_type.dart';
import '../../../../../config/widgets/app_bar.dart';
import '../../../../../config/widgets/buttons/button.dart';
import '../../../../../config/widgets/dialogs/place_search_list.dart';
import '../../../../../config/widgets/dialogs/search_and_tag.dart';
import '../../../../../config/widgets/dialogs/showAppModalSheet.dart';
import '../../../../../config/widgets/dynamic_height_views.dart';
import '../../../../../config/widgets/media/aspect_ratio.dart';
import '../../../../../config/widgets/media/asset_picker.dart';
import '../../../../../config/widgets/media/media_pick_choice.dart';
import '../../../../../config/widgets/pad_horizontal.dart';
import '../../../../../config/widgets/product_guide/product_guides.dart';
import '../../../../../config/widgets/textfield/super_textform_field.dart';
import '../bloc/create_photo_post_bloc.dart';

class CreatePhotoPostPageArgument {
  final EnumPostCreatorType postCreatorType;

  CreatePhotoPostPageArgument({required this.postCreatorType});
}

class CreatePhotoPostPage extends StatelessWidget {
  final CreatePhotoPostPageArgument pageArgument;

  CreatePhotoPostPage({super.key, required this.pageArgument});
  int? selectedSwipeAbleViewIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreatePhotoPostBloc()
        ..add(CreateOfferInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreatePhotoPostBloc, CreatePhotoPostState>(
      builder: (BuildContext context, CreatePhotoPostState state) {
        return Scaffold(
          appBar: WhatsevrAppBar(
            title: 'Create Photo Post',
            showAiAction: true,
            showInfo: () {
              ProductGuides.showPhotoPostCreationGuide();
            },
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              const Gap(12),
              Builder(
                builder: (context) {
                  if (state.uiImageData.isNotEmpty) {
                    return SwipeAbleDynamicHeightViews(
                      selectedViewIndex: selectedSwipeAbleViewIndex,
                      onViewIndexChanged: (index) {
                        selectedSwipeAbleViewIndex = index;
                      },
                      key: UniqueKey(),
                      children: [
                        for (UiImageData uiFileData in state.uiImageData) ...[
                          Stack(
                            children: [
                              ExtendedImage.file(
                                uiFileData.file!,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<CreatePhotoPostBloc>()
                                        .add(RemoveVideoOrImageEvent(
                                          uiFileData: uiFileData,
                                        ),);
                                  },
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    );
                  }

                  return AspectRatio(
                    aspectRatio: WhatsevrAspectRatio.square.ratio,
                    child: MaterialButton(
                      onPressed: () {
                        showWhatsevrMediaPickerChoice(
                          onChoosingImageFromGallery: () {
                            CustomAssetPicker.pickImageFromGallery(
                              onCompleted: (file) {
                                context
                                    .read<CreatePhotoPostBloc>()
                                    .add(PickImageEvent(pickedImageFile: file));
                              },
                              aspectRatios: imagePostAspectRatio,
                            );
                          },
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      child: Text('Add Image',
                          style: TextStyle(color: Colors.white),),
                    ),
                  );
                },
              ),
              const Gap(8),
              if (state.uiImageData.isNotEmpty &&
                  state.uiImageData.length !=
                      context.read<CreatePhotoPostBloc>().maxImageCount)
                WhatsevrButton.outlined(
                  label: 'Pick images',
                  onPressed: () {
                    showWhatsevrMediaPickerChoice(
                      onChoosingImageFromGallery: () {
                        CustomAssetPicker.pickImageFromGallery(
                          onCompleted: (file) {
                            context
                                .read<CreatePhotoPostBloc>()
                                .add(PickImageEvent(pickedImageFile: file));
                          },
                          aspectRatios: imagePostAspectRatio,
                        );
                      },
                    );
                  },
                ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                maxLength: 150,
                minLines: 1,
                maxLines: 5,
                controller: context.read<CreatePhotoPostBloc>().titleController,
                hintText: 'Title',
              ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                maxLength: 2200,
                minLines: 5,
                maxLines: 20,
                controller:
                    context.read<CreatePhotoPostBloc>().descriptionController,
                hintText: 'Description',
              ),
              const Gap(12),
              Column(
                children: [
                  WhatsevrFormField.invokeCustomFunction(
                    context: context,
                    controller: TextEditingController(
                      text: state.selectedPostLocation ?? '',
                    ),
                    suffixWidget: const Icon(Icons.location_on),
                    hintText: 'Location',
                    customFunction: () {
                      showAppModalSheet(child: PlaceSearchByNamePage(
                        onPlaceSelected: (placeName, lat, long) {
                          context
                              .read<CreatePhotoPostBloc>()
                              .add(UpdatePostAddressEvent(
                                address: placeName,
                                addressLatitude: lat,
                                addressLongitude: long,
                              ),);
                        },
                      ),);
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
                                  .read<CreatePhotoPostBloc>()
                                  .add(UpdatePostAddressEvent(
                                    address: state.placesNearbyResponse
                                        ?.places?[index].displayName?.text,
                                    addressLatitude: state.placesNearbyResponse
                                        ?.places?[index].location?.latitude,
                                    addressLongitude: state.placesNearbyResponse
                                        ?.places?[index].location?.longitude,
                                  ),);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                            state.placesNearbyResponse?.places?.length ?? 0,
                      ),
                    ),
                  ],
                ],
              ),
              const Gap(12),
              Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showAppModalSheet(
                        child: SearchAndTagUsersAndCommunityPage(
                          onDone: (selectedUsersUid, selectedCommunitiesUid) {
                            context
                                .read<CreatePhotoPostBloc>()
                                .add(UpdateTaggedUsersAndCommunitiesEvent(
                                  taggedUsersUid: selectedUsersUid,
                                  taggedCommunitiesUid: selectedCommunitiesUid,
                                ),);
                          },
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.black),
                        Gap(4),
                        Text('Tag', style: TextStyle(color: Colors.black)),
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
                            context.read<CreatePhotoPostBloc>().add(
                                const UpdateTaggedUsersAndCommunitiesEvent(
                                    clearAll: true,),);
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
                ],
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
                context
                    .read<CreatePhotoPostBloc>()
                    .add(const SubmitPostEvent());
              },
              label: 'Done',
            ),
          ),
        );
      },
    );
  }
}
