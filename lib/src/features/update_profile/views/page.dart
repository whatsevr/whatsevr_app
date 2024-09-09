import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/src/features/update_profile/bloc/bloc.dart';

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

  final ImagePicker _picker = ImagePicker();

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
                          Gap(35),
                          GestureDetector(
                            onTap: () async {
                              final XFile? pickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                context.read<ProfileBloc>().add(
                                    UploadProfilePicture(
                                        File(pickedFile.path)));
                              }
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
                          Gap(35),
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
                          SuperTextFormField.general(
                            controller:
                                context.read<ProfileBloc>().nameController,
                            headingTitle: "Name",
                            maxLength: 50,
                          ),
                          Gap(8),
                          SuperTextFormField.email(
                            controller:
                                context.read<ProfileBloc>().emailController,
                            headingTitle: "Email",
                          ),
                          Gap(8),
                          SuperTextFormField.multiline(
                            controller:
                                context.read<ProfileBloc>().bioController,
                            headingTitle: "Bio",
                            minLines: 3,
                          ),
                          Gap(8),
                          SuperTextFormField.multiline(
                            controller:
                                context.read<ProfileBloc>().addressController,
                            headingTitle: "Address",
                          ),
                          Gap(8),
                          SuperTextFormField.datePicker(
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
                        ],
                      ),
                    ),
                    Gap(12),

                    // Service Info Section

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SuperTextFormField.general(
                            controller:
                                context.read<ProfileBloc>().service1Controller,
                            headingTitle: "Add Service",
                          ),

                          Gap(12),

                          // Portfolio Info Section

                          SuperTextFormField.multiline(
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
                );
              },
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blueAccent,
                onPressed: () {
                  context.read<ProfileBloc>().add(SubmitProfile());
                },
                child: Text('SAVE', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
