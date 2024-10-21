import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/country_state_city.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';
import 'package:whatsevr_app/config/widgets/previewers/video.dart';

import '../../../../../config/enums/post_creator_type.dart';
import '../../../../../config/routes/router.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../config/widgets/app_bar.dart';
import '../../../../../config/widgets/button.dart';
import '../../../../../config/widgets/choice_chip.dart';
import '../../../../../config/widgets/common_data_list.dart';
import '../../../../../config/widgets/dynamic_height_views.dart';
import '../../../../../config/widgets/media/asset_picker.dart';
import '../../../../../config/widgets/media/thumbnail_selection.dart';
import '../../../../../config/widgets/pad_horizontal.dart';
import '../../../../../config/widgets/place_search_list.dart';
import '../../../../../config/widgets/product_guide/product_guides.dart';
import '../../../../../config/widgets/search_and_tag.dart';
import '../../../../../config/widgets/showAppModalSheet.dart';
import '../../../../../config/widgets/super_textform_field.dart';

import '../bloc/create_offer_bloc.dart';

class CreateOfferPageArgument {
  final EnumPostCreatorType postCreatorType;

  CreateOfferPageArgument({required this.postCreatorType});
}

class CreateOfferPage extends StatelessWidget {
  final CreateOfferPageArgument pageArgument;

  CreateOfferPage({super.key, required this.pageArgument});
  int? selectedSwipeAbleViewIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreateOfferBloc()
        ..add(CreateOfferInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateOfferBloc, CreateOfferState>(
      builder: (BuildContext context, CreateOfferState state) {
        return Scaffold(
          appBar: WhatsevrAppBar(
            title: 'Create Offer',
            showAiAction: true,
            showInfo: () {
              ProductGuides.showOfferCreationGuide();
            },
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              const Gap(12),
              WhatsevrFormField.generalTextField(
                maxLength: 150,
                minLines: 1,
                maxLines: 5,
                controller: context.read<CreateOfferBloc>().titleController,
                hintText: 'Title',
              ),
              const Gap(12),
              Builder(
                builder: (context) {
                  if (state.uiFilesData.isNotEmpty) {
                    return SwipeAbleDynamicHeightViews(
                      selectedViewIndex: selectedSwipeAbleViewIndex,
                      onViewIndexChanged: (index) {
                        selectedSwipeAbleViewIndex = index;
                      },
                      key: UniqueKey(),
                      children: [
                        for (UiFileData uiFileData in state.uiFilesData) ...[
                          if (uiFileData.type == UiFileTypes.image) ...[
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
                                          .read<CreateOfferBloc>()
                                          .add(RemoveVideoOrImageEvent(
                                            uiFileData: uiFileData,
                                          ));
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
                          if (uiFileData.type == UiFileTypes.video) ...[
                            Stack(
                              children: [
                                ExtendedImage.file(
                                  uiFileData.thumbnailFile!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        showVideoPreviewDialog(
                                          context: context,
                                          videoUrl: uiFileData.file!.path,
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
                                      context
                                          .read<CreateOfferBloc>()
                                          .add(RemoveVideoOrImageEvent(
                                            uiFileData: uiFileData,
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 6,
                                  child: WhatsevrButton.filled(
                                    shrink: true,
                                    miniButton: true,
                                    onPressed: () {
                                      showWhatsevrThumbnailSelectionPage(
                                        videoFile: uiFileData.file!,
                                        allowPickFromGallery: false,
                                        aspectRatios: offerPostAspectRatio,
                                      ).then((value) {
                                        if (value != null) {
                                          context
                                              .read<CreateOfferBloc>()
                                              .add(ChangeVideoThumbnail(
                                                pickedThumbnailFile: value,
                                                uiFileData: uiFileData,
                                              ));
                                        }
                                      });
                                    },
                                    label: 'Update Cover',
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                                    .read<CreateOfferBloc>()
                                    .add(PickImageEvent(pickedImageFile: file));
                              },
                              aspectRatios: offerPostAspectRatio,
                            );
                          },
                          onChoosingVideoFromGallery: () {
                            CustomAssetPicker.pickVideoFromGallery(
                              onCompleted: (file) {
                                context
                                    .read<CreateOfferBloc>()
                                    .add(PickVideoEvent(pickedVideoFile: file));
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
              const Gap(8),
              if (state.uiFilesData.isNotEmpty &&
                  state.uiFilesData.length !=
                      context.read<CreateOfferBloc>().maxVideoCount +
                          context.read<CreateOfferBloc>().maxImageCount)
                WhatsevrButton.outlined(
                  label: 'Pick image or video',
                  onPressed: () {
                    showWhatsevrMediaPickerChoice(
                      onChoosingImageFromGallery: () {
                        CustomAssetPicker.pickImageFromGallery(
                          onCompleted: (file) {
                            context
                                .read<CreateOfferBloc>()
                                .add(PickImageEvent(pickedImageFile: file));
                          },
                          aspectRatios: offerPostAspectRatio,
                        );
                      },
                      onChoosingVideoFromGallery: () {
                        CustomAssetPicker.pickVideoFromGallery(
                          onCompleted: (file) {
                            context
                                .read<CreateOfferBloc>()
                                .add(PickVideoEvent(pickedVideoFile: file));
                          },
                        );
                      },
                    );
                  },
                ),
              const Gap(12),
              WhatsevrFormField.multilineTextField(
                maxLength: 5000,
                minLines: 5,
                maxLines: 20,
                controller:
                    context.read<CreateOfferBloc>().descriptionController,
                hintText: 'Description',
              ),
              const Gap(12),
              WhatsevrFormField.invokeCustomFunction(
                context: context,
                maxLength: 35,
                readOnly: false,
                controller: context.read<CreateOfferBloc>().statusController,
                hintText: 'Status',
                customFunction: () {
                  showAppModalSheet(
                      child: CommonDataSearchSelectPage(
                    showProfessionalStatus: true,
                    onProfessionalStatusSelected: (professionalStatus) {
                      context.read<CreateOfferBloc>().statusController.text =
                          professionalStatus.title ?? '';
                    },
                  ));
                },
              ),
              const Gap(12),
              Column(
                children: [
                  WhatsevrFormField.invokeCustomFunction(
                    context: context,
                    suffixWidget: const Icon(Icons.location_on),
                    hintText: 'Target Area',
                    customFunction: () {
                      showAppModalSheet(child: CountryStateCityPage(
                        onPlaceSelected: (countryName, stateName, cityName) {
                          context
                              .read<CreateOfferBloc>()
                              .add(AddOrRemoveTargetAddressEvent(
                                countryName: countryName,
                                stateName: stateName,
                                cityName: cityName,
                              ));
                        },
                      ));
                    },
                  ),
                  const Gap(12),
                  for (String address
                      in state.selectedTargetAddresses ?? []) ...[
                    Row(
                      children: [
                        Text(address),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CreateOfferBloc>()
                                .add(AddOrRemoveTargetAddressEvent(
                                  removableTargetAddress: address,
                                ));
                          },
                          child: const Icon(Icons.clear_rounded,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const Gap(12),
              ExpansionTileItem.flat(
                title: Text('More Details'),
                childrenPadding: EdgeInsets.zero,
                tilePadding: EdgeInsets.zero,
                children: [
                  //target gender choice chip
                  Row(
                    children: [
                      Text('Audience'),
                      const Spacer(),
                      for (String audience
                          in context.read<CreateOfferBloc>().targetGender) ...[
                        WhatsevrChoiceChip(
                          label: audience,
                          selected: state.selectedTargetGender == audience,
                          onSelected: (value) {
                            context.read<CreateOfferBloc>().add(
                                UpdateTargetGenderEvent(
                                    targetGender: audience));
                          },
                        ),
                        const Gap(4),
                      ],
                    ],
                  ),
                  const Gap(12),
                  Column(
                    children: [
                      WhatsevrFormField.invokeCustomFunction(
                        controller: TextEditingController(
                          text: state.ctaAction ?? '',
                        ),
                        context: context,
                        hintText: 'User Action',
                        customFunction: () {
                          showAppModalSheet(
                              child: CommonDataSearchSelectPage(
                            showCtaActions: true,
                            onCtaActionSelected: (ctaAction) {
                              context.read<CreateOfferBloc>().add(
                                  UpdateCtaActionEvent(
                                      ctaAction: ctaAction.action));
                            },
                          ));
                        },
                      ),
                      const Gap(12),
                      WhatsevrFormField.generalTextField(
                        controller: context
                            .read<CreateOfferBloc>()
                            .ctaActionUrlController,
                        hintText: 'Action URL',
                        onChanged: (value) {
                          if (state.ctaAction == null) {
                            SmartDialog.showToast(
                                'Please select a User action first');
                            context
                                .read<CreateOfferBloc>()
                                .ctaActionUrlController
                                .clear();
                          }
                        },
                      ),
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
                              onDone:
                                  (selectedUsersUid, selectedCommunitiesUid) {
                                context
                                    .read<CreateOfferBloc>()
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
                            Text('Tag', style: TextStyle(color: Colors.black)),
                            Spacer(),
                            Icon(Icons.arrow_right_rounded,
                                color: Colors.black),
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
                                context.read<CreateOfferBloc>().add(
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
                    ],
                  ),
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
                context.read<CreateOfferBloc>().add(const SubmitPostEvent());
              },
              label: 'Done',
            ),
          ),
        );
      },
    );
  }
}
