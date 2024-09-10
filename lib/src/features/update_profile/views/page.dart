import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/common_data_list.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/update_profile/bloc/bloc.dart';

import '../../../../config/widgets/mask_text.dart';

// Adjust the import
class ProfileUpdatePageArgument {
  final ProfileDetailsResponse? profileDetailsResponse;

  ProfileUpdatePageArgument({required this.profileDetailsResponse});
}

class ProfileUpdatePage extends StatelessWidget {
  final ProfileUpdatePageArgument pageArgument;
  ProfileUpdatePage({
    Key? key,
    required this.pageArgument,
  }) : super(key: key);

  // TextEditingControllers for each field
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc()..add(InitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: AppBar(
              title: Text('Edit Profile'),
            ),
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return ListView(
                  padding: PadHorizontal.padding,
                  children: [
                    Gap(12),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Gap(25),
                          GestureDetector(
                            onTap: () async {
                              context
                                  .read<ProfileBloc>()
                                  .add(ChangeProfilePictureEvent());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
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
                                            ? FileImage(state.profileImage!)
                                            : state.currentProfileDetailsResponse
                                                        ?.userInfo?.profilePicture !=
                                                    null
                                                ? ExtendedNetworkImageProvider(state
                                                        .currentProfileDetailsResponse
                                                        ?.userInfo
                                                        ?.profilePicture ??
                                                    MockData.imageAvatar)
                                                : ExtendedNetworkImageProvider(
                                                    MockData.imageAvatar),
                                        fit: BoxFit.cover,
                                      )
                                      // : ,
                                      ),
                                ),
                                Positioned(
                                  bottom: -10,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(22),
                          MaskText(
                            key: ValueKey(state.currentProfileDetailsResponse
                                    ?.userInfo?.mobileNumber ??
                                ''), // Add a key to the widget to force rebuild
                            text: state.currentProfileDetailsResponse?.userInfo
                                    ?.mobileNumber ??
                                '',
                            maskLength: 5,
                            maskFirstDigits: false,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Gap(25),
                        ],
                      ),
                    ),

                    Gap(12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SuperFormField.generalTextField(
                            controller:
                                context.read<ProfileBloc>().nameController,
                            headingTitle: "Name",
                            maxLength: 40,
                          ),
                          Gap(8),
                          SuperFormField.email(
                            controller:
                                context.read<ProfileBloc>().emailController,
                            headingTitle: "Email",
                            maxLength: 60,
                          ),
                          Gap(8),
                          SuperFormField.multilineTextField(
                            controller:
                                context.read<ProfileBloc>().bioController,
                            headingTitle: "Bio",
                            minLines: 3,
                            maxLength: 300,
                          ),
                          Gap(8),
                          SuperFormField.multilineTextField(
                            controller:
                                context.read<ProfileBloc>().addressController,
                            headingTitle: "Address",
                            maxLength: 100,
                          ),
                          Gap(8),
                          SuperFormField.datePicker(
                            context: context,
                            controller: TextEditingController(
                                text: state.dob == null
                                    ? ''
                                    : DateFormat('dd-MM-yyyy')
                                        .format(state.dob!)),
                            headingTitle: 'Date of Birth',
                            onDateSelected: (DateTime date) {
                              context
                                  .read<ProfileBloc>()
                                  .emit(state.copyWith(dob: date));
                            },
                          ),
                          Gap(8),
                          SuperFormField.showModalSheetOnTap(
                            context: context,
                            headingTitle: "Add Educations",
                            modalSheetUi: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SuperFormField.generalTextField(
                                  headingTitle: "Enter School",
                                ),
                                Gap(12),
                                SuperFormField.invokeCustomFunction(
                                  context: context,
                                  headingTitle: "Select Degree",
                                  readOnly: false,
                                  customFunction: () {
                                    showAppModalSheet(
                                      context: context,
                                      child: CommonDataSearchSelectPage(
                                        showEducationDegrees: true,
                                      ),
                                    );
                                  },
                                ),
                                Gap(12),
                                SuperFormField.datePicker(
                                  context: context,
                                  headingTitle: "Select Start Date",
                                ),
                                Gap(12),
                                SuperFormField.datePicker(
                                  context: context,
                                  headingTitle: "Select End Date",
                                ),
                                Gap(12),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () {},
                                    child: Text('Add',
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ),
                          Gap(8),
                          SuperFormField.showModalSheetOnTap(
                            context: context,
                            headingTitle: "Work Experience",
                            modalSheetUi: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SuperFormField.generalTextField(
                                  headingTitle: "Enter Organization",
                                ),
                                Gap(12),
                                SuperFormField.invokeCustomFunction(
                                  context: context,
                                  headingTitle: "Select Mode of Work",
                                  customFunction: () {
                                    showAppModalSheet(
                                      context: context,
                                      child: CommonDataSearchSelectPage(
                                        showWorkingModes: true,
                                      ),
                                    );
                                  },
                                ),
                                Gap(12),
                                SuperFormField.datePicker(
                                  context: context,
                                  headingTitle: "Start Start Date",
                                ),
                                Gap(12),
                                SuperFormField.datePicker(
                                  context: context,
                                  headingTitle: "End Date",
                                ),
                                Gap(12),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () {},
                                    child: Text('Add',
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ),
                          Gap(8),
                          SuperFormField.showModalSheetOnTap(
                            context: context,
                            headingTitle: 'Select Gender',
                            modalSheetUi: CommonDataSearchSelectPage(
                              showGenders: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(12),

                    // Service Info Section
                    if (state.currentProfileDetailsResponse?.userInfo
                            ?.isPortfolio ==
                        true) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SuperFormField.generalTextField(
                              headingTitle: "Add Service",
                            ),

                            Gap(12),

                            // Portfolio Info Section

                            SuperFormField.multilineTextField(
                              controller: context
                                  .read<ProfileBloc>()
                                  .portfolioDescriptionController,
                              headingTitle: "Portfolio Description",
                              minLines: 5,
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                    ],
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        context.read<ProfileBloc>().add(SubmitProfile());
                      },
                      child:
                          Text('SAVE', style: TextStyle(color: Colors.white)),
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
