import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:whatsevr_app/config/api/response_model/common_data.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/choice_chip.dart';
import 'package:whatsevr_app/config/widgets/dialogs/common_data_list.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/label_container.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/previewers/video.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:whatsevr_app/src/features/update_community_profile/bloc/bloc.dart';

// Adjust the import
class CommunityProfileUpdatePageArgument {
  final CommunityProfileDataResponse? profileDetailsResponse;

  CommunityProfileUpdatePageArgument({required this.profileDetailsResponse});
}

class CommunityProfileUpdatePage extends StatelessWidget {
  final CommunityProfileUpdatePageArgument pageArgument;
  const CommunityProfileUpdatePage({
    super.key,
    required this.pageArgument,
  });

  // TextEditingControllers for each field
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommunityProfileUpdateBloc()
        ..add(InitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: const WhatsevrAppBar(
              title: 'Edit Community',
              showAiAction: true,
            ),
            body: BlocBuilder<CommunityProfileUpdateBloc,
                CommunityProfileUpdateState>(
              builder:
                  (BuildContext context, CommunityProfileUpdateState state) {
                return ListView(
                  padding: PadHorizontal.padding,
                  children: <Widget>[
                    const Gap(12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  showWhatsevrMediaPickerChoice(
                                    onChoosingImageFromCamera: () async {
                                      CustomAssetPicker.captureImage(
                                        quality: 50,
                                        withCircleCropperUi: true,
                                        aspectRatios: [
                                          WhatsevrAspectRatio.square,
                                        ],
                                        onCompleted: (file) {
                                          context
                                              .read<
                                                  CommunityProfileUpdateBloc>()
                                              .add(
                                                ChangeProfilePictureEvent(
                                                  profileImage: file,
                                                ),
                                              );
                                        },
                                      );
                                    },
                                    onChoosingImageFromGallery: () {
                                      CustomAssetPicker.pickImageFromGallery(
                                        quality: 50,
                                        withCircleCropperUi: true,
                                        aspectRatios: [
                                          WhatsevrAspectRatio.square,
                                        ],
                                        onCompleted: (file) {
                                          context
                                              .read<
                                                  CommunityProfileUpdateBloc>()
                                              .add(
                                                ChangeProfilePictureEvent(
                                                  profileImage: file,
                                                ),
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.none,
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      width: 80,
                                      padding: const EdgeInsets.all(16),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image: state.profileImage != null
                                              ? ExtendedFileImageProvider(
                                                  state.profileImage!,
                                                )
                                              : state
                                                          .currentProfileDetailsResponse
                                                          ?.communityInfo
                                                          ?.profilePicture !=
                                                      null
                                                  ? ExtendedNetworkImageProvider(
                                                      state
                                                              .currentProfileDetailsResponse
                                                              ?.communityInfo
                                                              ?.profilePicture ??
                                                          MockData
                                                              .blankCommunityAvatar,
                                                      cache: true,
                                                    )
                                                  : ExtendedNetworkImageProvider(
                                                      MockData
                                                          .blankCommunityAvatar,
                                                      cache: true,
                                                    ),
                                          fit: BoxFit.cover,
                                        ),
                                        // : ,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: Column(
                                  children: [
                                    WhatsevrFormField.multilineTextField(
                                      controller: context
                                          .read<CommunityProfileUpdateBloc>()
                                          .titleController,
                                      headingTitle: 'Title',
                                      minLines: 4,
                                      maxLines: 4,
                                      maxLength: 40,
                                      hintText:
                                          'Hint; In crafting titles, balance clarity, engagement, and focus to attract users and build vibrant, purpose-driven communities.',
                                    ),
                                    const Gap(8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(25),
                          WhatsevrFormField.multilineTextField(
                            controller: context
                                .read<CommunityProfileUpdateBloc>()
                                .bioController,
                            headingTitle: 'Bio',
                            minLines: 1,
                            maxLength: 300,
                            hintText: 'Eg; Focus, Expertise, or Movement',
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Require admin approval to join?'),
                              ),
                              WhatsevrChoiceChip(
                                label: 'Yes',
                                choiced: state.requireJoiningApproval ?? false,
                                switchChoice: (value) {
                                  context
                                      .read<CommunityProfileUpdateBloc>()
                                      .add(
                                        ChangeApproveJoiningRequestEvent(),
                                      );
                                },
                              ),
                              Gap(4),
                              WhatsevrChoiceChip(
                                label: 'No',
                                choiced:
                                    !(state.requireJoiningApproval ?? false),
                                switchChoice: (value) {
                                  context
                                      .read<CommunityProfileUpdateBloc>()
                                      .add(
                                        ChangeApproveJoiningRequestEvent(),
                                      );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(12),
                    ExpansionTile(
                      dense: true,
                      title: const Text(
                        'Cover Media',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      initiallyExpanded: true,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      children: <Widget>[
                        for (UiCoverMedia coverMedia
                            in state.coverMedia ?? <UiCoverMedia>[])
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    ExtendedImage.network(
                                      coverMedia.imageUrl ??
                                          MockData.imagePlaceholder(
                                            'Cover Media',
                                          ),
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      cache: true,
                                      enableLoadState: false,
                                    ),
                                    if (coverMedia.isVideo == true)
                                      Align(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                              Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          onPressed: () {
                                            showVideoPreviewDialog(
                                              context: context,
                                              videoUrl: coverMedia.videoUrl,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<
                                                  CommunityProfileUpdateBloc>()
                                              .add(
                                                AddOrRemoveCoverMedia(
                                                  removableCoverMedia:
                                                      coverMedia,
                                                ),
                                              );
                                        },
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                showWhatsevrMediaPickerChoice(
                                  onChoosingImageFromCamera: () async {
                                    CustomAssetPicker.captureImage(
                                      aspectRatios: [
                                        WhatsevrAspectRatio.landscape,
                                        WhatsevrAspectRatio.widescreen16by9,
                                      ],
                                      onCompleted: (file) {
                                        context
                                            .read<CommunityProfileUpdateBloc>()
                                            .add(
                                              AddOrRemoveCoverMedia(
                                                coverImage: file,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                  onChoosingImageFromGallery: () {
                                    CustomAssetPicker.pickImageFromGallery(
                                      aspectRatios: [
                                        WhatsevrAspectRatio.landscape,
                                        WhatsevrAspectRatio.widescreen16by9,
                                      ],
                                      onCompleted: (file) {
                                        context
                                            .read<CommunityProfileUpdateBloc>()
                                            .add(
                                              AddOrRemoveCoverMedia(
                                                coverImage: file,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Add Cover Image',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Gap(12),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                showWhatsevrMediaPickerChoice(
                                  onChoosingImageFromGallery: () {
                                    CustomAssetPicker.pickVideoFromGallery(
                                      onCompleted: (file) async {
                                        File? thumbnail =
                                            await getThumbnailFile(
                                          videoFile: file,
                                        );
                                        thumbnail =
                                            await showWhatsevrThumbnailSelectionPage(
                                          videoFile: file,
                                        );
                                        context
                                            .read<CommunityProfileUpdateBloc>()
                                            .add(
                                              AddOrRemoveCoverMedia(
                                                coverImage: thumbnail,
                                                coverVideo: file,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Add Cover Video',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                      ],
                    ),
                    const Gap(12),
                    ...<Widget>[
                      LabelContainer(
                        labelText: 'Basic Info',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<CommunityProfileUpdateBloc>()
                                  .descriptionConroller,
                              headingTitle: 'Description',
                              minLines: 7,
                              maxLines: 8,
                              maxLength: 300,
                              hintText:
                                  '''Hint; Purpose: Clearly state what the group is about in one sentence.
Value: Highlight why users should join or what they’ll gain.
Guidelines: Mention 1-2 key rules to maintain harmony.
Call to Action: End with a simple invite to participate.

''',
                            ),
                            const Gap(8),
                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<CommunityProfileUpdateBloc>()
                                  .addressController,
                              headingTitle: 'Address',
                              maxLength: 100,
                              hintText: 'Eg; Home, Office, Landmark, City, Country',
                            ),
                            const Gap(8),
                            // Service Info Section
                            WhatsevrFormField.invokeCustomFunction(
                              headingTitle: 'Status',
                              hintText: 'Hint; Short innovative or volatile keyword',
                              controller: context
                                  .read<CommunityProfileUpdateBloc>()
                                  .statusController,
                                  readOnly: false,
                                  customFunction: (){
                                    showAppModalSheet(
                                  child: CommonDataSearchSelectPage(
                                    showProfessionalStatus: true,
                                    onProfessionalStatusSelected:
                                        (professionalStatus) {
                                      context
                                              .read<CommunityProfileUpdateBloc>()
                                              .statusController
                                              .text =
                                          professionalStatus.title ?? '';
                                    },
                                  ),
                                );
                                  },
                            ),
                            const Gap(8),
                            const Gap(12),
                            Builder(
                              builder: (BuildContext context) {
                                final TextEditingController titleController =
                                    TextEditingController();
                                final TextEditingController
                                    descriptionController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  headingTitle: 'Services',
                                  hintText: 'Click on the + icon to add services',
                                  suffixWidget:
                                      const Icon(Icons.add_circle_rounded),
                                  customFunction: () {
                                    showAppModalSheet(
                                      context: context,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          WhatsevrFormField.generalTextField(
                                            headingTitle: 'Enter Title',
                                            controller: titleController,
                                            hintText: 'Eg; Education, Health, Gadgets',
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.multilineTextField(
                                            headingTitle: 'Enter Description',
                                            controller: descriptionController,
                                            hintText: 'Eg; We provide the best education services in the city',
                                          ),
                                          const Gap(12),
                                          MaterialButton(
                                            minWidth: double.infinity,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              if (titleController
                                                      .text.isNotEmpty &&
                                                  descriptionController
                                                      .text.isNotEmpty) {
                                                context
                                                    .read<
                                                        CommunityProfileUpdateBloc>()
                                                    .add(
                                                      AddOrRemoveService(
                                                        service: UiService(
                                                          serviceName:
                                                              titleController
                                                                  .text,
                                                          serviceDescription:
                                                              descriptionController
                                                                  .text,
                                                        ),
                                                      ),
                                                    );
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const Gap(12),
                            if (state.services != null) ...<Widget>[
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.services?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${state.services?[index].serviceName} - ${state.services?[index].serviceDescription} ',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<
                                                  CommunityProfileUpdateBloc>()
                                              .add(
                                                AddOrRemoveService(
                                                  service:
                                                      state.services?[index],
                                                  isRemove: true,
                                                ),
                                              );
                                        },
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Gap(2);
                                },
                              ),
                              const Gap(8),
                            ],
                           
                          ],
                        ),
                      ),
                      const Gap(12),
                    ],
                    const Gap(12),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        context
                            .read<CommunityProfileUpdateBloc>()
                            .add(const SubmitProfile());
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
