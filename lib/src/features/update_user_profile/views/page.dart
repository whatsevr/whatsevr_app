import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:whatsevr_app/config/api/response_model/common_data.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/dialogs/common_data_list.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/label_container.dart';
import 'package:whatsevr_app/config/widgets/mask_text.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/previewers/video.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:whatsevr_app/src/features/update_user_profile/bloc/bloc.dart';

// Adjust the import
class UserProfileUpdatePageArgument {
  final UserProfileDetailsResponse? profileDetailsResponse;

  UserProfileUpdatePageArgument({this.profileDetailsResponse});
}

class UserProfileUpdatePage extends StatelessWidget {
  final UserProfileUpdatePageArgument pageArgument;
  const UserProfileUpdatePage({
    super.key,
    required this.pageArgument,
  });

  // TextEditingControllers for each field
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserProfileUpdateBloc()
        ..add(InitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: const WhatsevrAppBar(
              title: 'Update Profile',
              showAiAction: true,
            ),
            body: BlocBuilder<UserProfileUpdateBloc, UserProfileUpdateState>(
              builder: (BuildContext context, UserProfileUpdateState state) {
                return ListView(
                  padding: PadHorizontal.padding,
                  children: <Widget>[
                    const Gap(12),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Gap(25),
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
                                      context.read<UserProfileUpdateBloc>().add(
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
                                      context.read<UserProfileUpdateBloc>().add(
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
                                  height: 120,
                                  width: 120,
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
                                          : state.currentProfileDetailsResponse
                                                      ?.userInfo?.profilePicture !=
                                                  null
                                              ? ExtendedNetworkImageProvider(
                                                  state
                                                          .currentProfileDetailsResponse
                                                          ?.userInfo
                                                          ?.profilePicture ??
                                                      MockData
                                                          .blankProfileAvatar,
                                                  cache: true,
                                                )
                                              : ExtendedNetworkImageProvider(
                                                  MockData.blankProfileAvatar,
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
                          const Gap(22),
                          MaskText(
                            key: ValueKey(
                              state.currentProfileDetailsResponse?.userInfo
                                      ?.mobileNumber ??
                                  '',
                            ), // Add a key to the widget to force rebuild
                            text: state.currentProfileDetailsResponse?.userInfo
                                    ?.mobileNumber ??
                                '',
                            maskLength: 5,
                            maskFirstDigits: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(25),
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
                                              .read<UserProfileUpdateBloc>()
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
                                            .read<UserProfileUpdateBloc>()
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
                                            .read<UserProfileUpdateBloc>()
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
                                            .read<UserProfileUpdateBloc>()
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
                        labelText: 'Personal Info',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            WhatsevrFormField.generalTextField(
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .nameController,
                              headingTitle: 'Name',
                              maxLength: 40,
                              hintText: 'Eg; Erik Smith',
                            ),
                            const Gap(8),
                            WhatsevrFormField.email(
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .publicEmailController,
                              headingTitle: 'Email',
                              maxLength: 60,
                              hintText: 'Eg; erik.smith@gmail.com',
                            ),
                            const Gap(8),
                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .bioController,
                              headingTitle: 'Bio',
                              minLines: 3,
                              maxLength: 300,
                              hintText:
                                  'Eg; hobbies, special interests, goals, urls, emojis etc',
                            ),
                            const Gap(8),
                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .addressController,
                              headingTitle: 'Address',
                              maxLength: 100,
                              hintText:
                                  'Eg; Home, Office, Landmark, City, Country',
                            ),
                            const Gap(8),
                            WhatsevrFormField.datePicker(
                              context: context,
                              controller: TextEditingController(
                                text: state.dob == null
                                    ? ''
                                    : DateFormat('dd-MM-yyyy')
                                        .format(state.dob!),
                              ),
                              headingTitle: 'Birthday',
                              hintText: 'Select Date of Birth',
                              onDateSelected: (DateTime date) {
                                context
                                    .read<UserProfileUpdateBloc>()
                                    .emit(state.copyWith(dob: date));
                              },
                            ),
                            const Gap(8),
                            Builder(
                              builder: (BuildContext context) {
                                final TextEditingController schoolController =
                                    TextEditingController();
                                final TextEditingController degreeController =
                                    TextEditingController();
                                final TextEditingController
                                    degreeTypeController =
                                    TextEditingController();
                                final TextEditingController
                                    startDateController =
                                    TextEditingController();
                                final TextEditingController endDateController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  headingTitle: 'Educations',
                                  hintText: 'Add Education',
                                  customFunction: () {
                                    showAppModalSheet(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          WhatsevrFormField.generalTextField(
                                            headingTitle: 'Enter School',
                                            controller: schoolController,
                                            hintText:
                                                'Eg; Cambridge University',
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField
                                              .invokeCustomFunction(
                                            headingTitle: 'Field of Study',
                                            hintText:
                                                'Eg; Masters in Business Administration',
                                            controller: degreeController,
                                            readOnly: false,
                                            customFunction: () {
                                              showAppModalSheet(
                                                context: context,
                                                child:
                                                    CommonDataSearchSelectPage(
                                                  showEducationDegrees: true,
                                                  onEducationDegreeSelected:
                                                      (EducationDegree p0) {
                                                    degreeController.text =
                                                        p0.title ?? '';
                                                    degreeTypeController.text =
                                                        p0.type ?? '';
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField
                                              .invokeCustomFunction(
                                            readOnly: false,
                                            controller: degreeTypeController,
                                            headingTitle: 'Academic Degree',
                                            hintText:
                                                'Eg; Bachelors, Masters, or Dr.PhD',
                                            customFunction: () {},
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.datePicker(
                                            context: context,
                                            controller: startDateController,
                                            headingTitle: 'Select Start Date',
                                            hintText: 'First day',
                                            onDateSelected: (DateTime date) {
                                              startDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.datePicker(
                                            context: context,
                                            controller: endDateController,
                                            headingTitle: 'Select End Date',
                                            hintText: 'Last day',
                                            onDateSelected: (DateTime date) {
                                              endDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
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
                                              if (degreeController.text.isNotEmpty &&
                                                  schoolController
                                                      .text.isNotEmpty &&
                                                  startDateController
                                                      .text.isNotEmpty &&
                                                  endDateController
                                                      .text.isNotEmpty) {
                                                context
                                                    .read<
                                                        UserProfileUpdateBloc>()
                                                    .add(
                                                      AddOrRemoveEducation(
                                                        education: UiEducation(
                                                          degreeName:
                                                              degreeController
                                                                  .text,
                                                          degreeType:
                                                              degreeTypeController
                                                                  .text,
                                                          startDate: DateFormat(
                                                            'dd-MM-yyyy',
                                                          ).parse(
                                                            startDateController
                                                                .text,
                                                          ),
                                                          endDate: DateFormat(
                                                            'dd-MM-yyyy',
                                                          ).parse(
                                                            endDateController
                                                                .text,
                                                          ),
                                                          institute:
                                                              schoolController
                                                                  .text,
                                                          isOngoingEducation:
                                                              false,
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
                            const Gap(8),
                            //show eduction as list
                            if (state.educations != null) ...<Widget>[
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.educations?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${state.educations?[index].degreeType} - ${state.educations?[index].degreeName}',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<UserProfileUpdateBloc>()
                                              .add(
                                                AddOrRemoveEducation(
                                                  education:
                                                      state.educations?[index],
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

                            Builder(
                              builder: (BuildContext context) {
                                final TextEditingController
                                    companyNameController =
                                    TextEditingController();
                                final TextEditingController
                                    designationController =
                                    TextEditingController();
                                final TextEditingController
                                    workingModeController =
                                    TextEditingController();
                                final TextEditingController
                                    startDateController =
                                    TextEditingController();
                                final TextEditingController endDateController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  headingTitle: 'Work Experience',
                                  hintText: 'Add Work Experience',
                                  customFunction: () {
                                    showAppModalSheet(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          WhatsevrFormField.generalTextField(
                                            headingTitle: 'Enter Company Name',
                                            controller: companyNameController,
                                            hintText: 'Eg; Whatsevr, Google',
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.generalTextField(
                                            headingTitle: 'Enter Designation',
                                            controller: designationController,
                                            hintText:
                                                'Eg; HR Manager, Software Engineer',
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField
                                              .invokeCustomFunction(
                                            headingTitle: 'Select Mode of Work',
                                            controller: workingModeController,
                                            hintText: 'Please select',
                                            customFunction: () {
                                              showAppModalSheet(
                                                flexibleSheet: true,
                                                context: context,
                                                child:
                                                    CommonDataSearchSelectPage(
                                                  showWorkingModes: true,
                                                  onWorkingModeSelected:
                                                      (WorkingMode p0) {
                                                    workingModeController.text =
                                                        p0.mode ?? '';
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.datePicker(
                                            context: context,
                                            controller: startDateController,
                                            headingTitle: 'Start Start Date',
                                            hintText: 'First working day',
                                            onDateSelected: (DateTime date) {
                                              startDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.datePicker(
                                            context: context,
                                            headingTitle: 'End Date',
                                            hintText: 'Last working day',
                                            controller: endDateController,
                                            onDateSelected: (DateTime date) {
                                              endDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
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
                                              if (companyNameController.text.isNotEmpty &&
                                                  workingModeController
                                                      .text.isNotEmpty &&
                                                  startDateController
                                                      .text.isNotEmpty &&
                                                  endDateController
                                                      .text.isNotEmpty &&
                                                  designationController
                                                      .text.isNotEmpty) {
                                                context
                                                    .read<
                                                        UserProfileUpdateBloc>()
                                                    .add(
                                                      AddOrRemoveWorkExperience(
                                                        workExperience:
                                                            UiWorkExperience(
                                                          companyName:
                                                              companyNameController
                                                                  .text,
                                                          isCurrentlyWorking:
                                                              false,
                                                          designation:
                                                              designationController
                                                                  .text,
                                                          workingMode:
                                                              workingModeController
                                                                  .text,
                                                          startDate: DateFormat(
                                                            'dd-MM-yyyy',
                                                          ).parse(
                                                            startDateController
                                                                .text,
                                                          ),
                                                          endDate: DateFormat(
                                                            'dd-MM-yyyy',
                                                          ).parse(
                                                            endDateController
                                                                .text,
                                                          ),
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
                            const Gap(8),
                            if (state.workExperiences != null) ...<Widget>[
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.workExperiences?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${state.workExperiences?[index].companyName} - ${state.workExperiences?[index].workingMode} - ${state.workExperiences?[index].designation}',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<UserProfileUpdateBloc>()
                                              .add(
                                                AddOrRemoveWorkExperience(
                                                  workExperience: state
                                                      .workExperiences?[index],
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
                            WhatsevrFormField.invokeCustomFunction(
                              controller:
                                  TextEditingController(text: state.gender),
                              headingTitle: 'Gender',
                              hintText: 'Please select',
                              customFunction: () {
                                showAppModalSheet(
                                  flexibleSheet: true,
                                  child: CommonDataSearchSelectPage(
                                    showGenders: true,
                                    onGenderSelected: (Gender p0) {
                                      context
                                          .read<UserProfileUpdateBloc>()
                                          .add(UpdateGender(p0.gender));
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                    ],
                    if (state.currentProfileDetailsResponse?.userInfo
                            ?.isPortfolio ==
                        true) ...<Widget>[
                      LabelContainer(
                        labelText: 'Portfolio Info',
                        child: Column(
                          children: <Widget>[
                            WhatsevrFormField.multilineTextField(
                              headingTitle: 'Portfolio Title',
                              hintText:
                                  'List your major expertise, guidance and proficiency',
                              minLines: 2,
                              maxLines: 3,
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .portfolioTitle,
                            ),
                            const Gap(12),
                            WhatsevrFormField.invokeCustomFunction(
                              headingTitle: 'Portfolio Status',
                              hintText:
                                  'Hint; One work only, like Hiring, Searching, Collaborating, Closed',
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .portfolioStatus,
                              readOnly: false,
                              customFunction: () {
                                showAppModalSheet(
                                  child: CommonDataSearchSelectPage(
                                    showProfessionalStatus: true,
                                    onProfessionalStatusSelected:
                                        (professionalStatus) {
                                      context
                                              .read<UserProfileUpdateBloc>()
                                              .portfolioStatus
                                              .text =
                                          professionalStatus.title ?? '';
                                    },
                                  ),
                                );
                              },
                            ),

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
                                  hintText: 'Fill service details',
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
                                            hintText:
                                                'Eg; It Support, Consulting Services, Real Estate, or Educational and training',
                                            controller: titleController,
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.multilineTextField(
                                            headingTitle: 'Enter Description',
                                            hintText:
                                                '''A service description is a clear and simple explanation of what a service provides, how it works, and what value it brings to you. It highlights the main features, benefits, and outcomes of the service, helping you understand what to expect and how it meets your needs. You can also use URL links and emojis.
''',
                                            minLines: 6,
                                            maxLines: 10,
                                            controller: descriptionController,
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
                                                        UserProfileUpdateBloc>()
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
                                              .read<UserProfileUpdateBloc>()
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
                            // Portfolio Info Section

                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<UserProfileUpdateBloc>()
                                  .portfolioDescriptionController,
                              hintText:
                                  '''My portfolio highlights a range of projects, showcasing my skills in [insert specific field, e.g., graphic design, content writing, web development]. Each piece reflects my dedication to quality and creativity, as well as my ability to deliver tailored solutions that meet client needs. Explore my work to see how I can bring your ideas to life. For any inquiries or to get started on your project, visit my website [Insert Website Link] or contact me at [Insert Contact Number]. I’m here to help and collaborate! 
''',
                              headingTitle: 'Portfolio Description',
                              minLines: 8,
                              maxLines: 12,
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                    ],
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        context
                            .read<UserProfileUpdateBloc>()
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
