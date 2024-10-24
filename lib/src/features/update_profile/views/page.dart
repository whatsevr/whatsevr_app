import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/common_data.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/common_data_list.dart';
import 'package:whatsevr_app/config/widgets/label_container.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/previewers/video.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/update_profile/bloc/bloc.dart';

import 'package:whatsevr_app/config/widgets/mask_text.dart';

// Adjust the import
class ProfileUpdatePageArgument {
  final ProfileDetailsResponse? profileDetailsResponse;

  ProfileUpdatePageArgument({required this.profileDetailsResponse});
}

class ProfileUpdatePage extends StatelessWidget {
  final ProfileUpdatePageArgument pageArgument;
  const ProfileUpdatePage({
    super.key,
    required this.pageArgument,
  });

  // TextEditingControllers for each field
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProfileBloc()..add(InitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: const WhatsevrAppBar(
              title: 'Update Profile',
              showAiAction: true,
            ),
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (BuildContext context, ProfileState state) {
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
                                    withCircleCropperUi: true,
                                    aspectRatios: [
                                      WhatsevrAspectRatio.square,
                                    ],
                                    onCompleted: (file) {
                                      context.read<ProfileBloc>().add(
                                            ChangeProfilePictureEvent(
                                              profileImage: file,
                                            ),
                                          );
                                    },
                                  );
                                },
                                onChoosingImageFromGallery: () {
                                  CustomAssetPicker.pickImageFromGallery(
                                    withCircleCropperUi: true,
                                    aspectRatios: [
                                      WhatsevrAspectRatio.square,
                                    ],
                                    onCompleted: (file) {
                                      context.read<ProfileBloc>().add(
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
                                              state.profileImage!)
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
                                          context.read<ProfileBloc>().add(
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
                                        context.read<ProfileBloc>().add(
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
                                        context.read<ProfileBloc>().add(
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
                                                videoFile: file);
                                        thumbnail =
                                            await showWhatsevrThumbnailSelectionPage(
                                                videoFile: file);
                                        context.read<ProfileBloc>().add(
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
                              controller:
                                  context.read<ProfileBloc>().nameController,
                              headingTitle: 'Name',
                              maxLength: 40,
                            ),
                            const Gap(8),
                            WhatsevrFormField.email(
                              controller: context
                                  .read<ProfileBloc>()
                                  .publicEmailController,
                              headingTitle: 'Email',
                              maxLength: 60,
                            ),
                            const Gap(8),
                            WhatsevrFormField.multilineTextField(
                              controller:
                                  context.read<ProfileBloc>().bioController,
                              headingTitle: 'Bio',
                              minLines: 3,
                              maxLength: 300,
                            ),
                            const Gap(8),
                            WhatsevrFormField.multilineTextField(
                              controller:
                                  context.read<ProfileBloc>().addressController,
                              headingTitle: 'Address',
                              maxLength: 100,
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
                              headingTitle: 'Date of Birth',
                              onDateSelected: (DateTime date) {
                                context
                                    .read<ProfileBloc>()
                                    .emit(state.copyWith(dob: date));
                              },
                            ),
                            const Gap(8),
                            Builder(
                              builder: (BuildContext context) {
                                TextEditingController schoolController =
                                    TextEditingController();
                                TextEditingController degreeController =
                                    TextEditingController();
                                TextEditingController degreeTypeController =
                                    TextEditingController();
                                TextEditingController startDateController =
                                    TextEditingController();
                                TextEditingController endDateController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  context: context,
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
                                        ),
                                        const Gap(12),
                                        WhatsevrFormField.invokeCustomFunction(
                                          context: context,
                                          headingTitle: 'Select Degree',
                                          controller: degreeController,
                                          readOnly: false,
                                          customFunction: () {
                                            showAppModalSheet(
                                              context: context,
                                              child: CommonDataSearchSelectPage(
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
                                        WhatsevrFormField.generalTextField(
                                          readOnly: true,
                                          controller: degreeTypeController,
                                          headingTitle: 'Degree Type',
                                        ),
                                        const Gap(12),
                                        WhatsevrFormField.datePicker(
                                          context: context,
                                          controller: startDateController,
                                          headingTitle: 'Select Start Date',
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
                                              context.read<ProfileBloc>().add(
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
                                    ));
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
                                          context.read<ProfileBloc>().add(
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
                                TextEditingController companyNameController =
                                    TextEditingController();
                                TextEditingController designationController =
                                    TextEditingController();
                                TextEditingController workingModeController =
                                    TextEditingController();
                                TextEditingController startDateController =
                                    TextEditingController();
                                TextEditingController endDateController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  context: context,
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
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.generalTextField(
                                            headingTitle: 'Enter Designation',
                                            controller: designationController,
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField
                                              .invokeCustomFunction(
                                            context: context,
                                            headingTitle: 'Select Mode of Work',
                                            controller: workingModeController,
                                            customFunction: () {
                                              showAppModalSheet(
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
                                                context.read<ProfileBloc>().add(
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
                                          context.read<ProfileBloc>().add(
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
                              context: context,
                              controller:
                                  TextEditingController(text: state.gender),
                              headingTitle: 'Gender',
                              hintText: 'Select Gender',
                              customFunction: () {
                                showAppModalSheet(
                                  child: CommonDataSearchSelectPage(
                                    showGenders: true,
                                    onGenderSelected: (Gender p0) {
                                      context
                                          .read<ProfileBloc>()
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

                    // Service Info Section
                    if (state.currentProfileDetailsResponse?.userInfo
                            ?.isPortfolio ==
                        true) ...<Widget>[
                      LabelContainer(
                        labelText: 'Portfolio Info',
                        child: Column(
                          children: <Widget>[
                            WhatsevrFormField.generalTextField(
                              headingTitle: 'Title',
                              hintText: 'Enter Portfolio Title',
                              controller:
                                  context.read<ProfileBloc>().portfolioTitle,
                            ),
                            const Gap(12),
                            WhatsevrFormField.generalTextField(
                              headingTitle: 'Status',
                              hintText: 'Add Status on Portfolio',
                              controller:
                                  context.read<ProfileBloc>().portfolioStatus,
                            ),

                            const Gap(12),
                            Builder(
                              builder: (BuildContext context) {
                                TextEditingController titleController =
                                    TextEditingController();
                                TextEditingController descriptionController =
                                    TextEditingController();

                                return WhatsevrFormField.invokeCustomFunction(
                                  context: context,
                                  headingTitle: 'Services',
                                  hintText: 'Add Service you provide',
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
                                          ),
                                          const Gap(12),
                                          WhatsevrFormField.multilineTextField(
                                            headingTitle: 'Enter Description',
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
                                                context.read<ProfileBloc>().add(
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
                                          context.read<ProfileBloc>().add(
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
                                  .read<ProfileBloc>()
                                  .portfolioDescriptionController,
                              headingTitle: 'Portfolio Description',
                              minLines: 5,
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
                        context.read<ProfileBloc>().add(const SubmitProfile());
                      },
                      child: const Text('SAVE',
                          style: TextStyle(color: Colors.white)),
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
