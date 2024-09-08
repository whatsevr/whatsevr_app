import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
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
                          _buildTextField(
                            controller:
                                context.read<ProfileBloc>().nameController,
                            label: "Name",
                          ),
                          Gap(8),
                          _buildTextField(
                            controller:
                                context.read<ProfileBloc>().emailController,
                            label: "Email",
                          ),
                          Gap(8),
                          _buildTextField(
                            controller:
                                context.read<ProfileBloc>().bioController,
                            label: "Bio",
                            minLines: 3,
                          ),
                          Gap(8),
                          _buildTextField(
                            controller:
                                context.read<ProfileBloc>().addressController,
                            label: "Address",
                          ),
                          Gap(8),
                          _buildTextField(
                            controller:
                                context.read<ProfileBloc>().dobController,
                            label: "Date of Birth",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Service Info Section
                    _buildSectionHeader('Education & Services'),
                    _buildTextField(
                      controller:
                          context.read<ProfileBloc>().service1Controller,
                      label: "Add Service",
                    ),

                    const SizedBox(height: 20),

                    // Portfolio Info Section
                    _buildSectionHeader('Portfolio Information'),

                    _buildTextField(
                      controller: context
                          .read<ProfileBloc>()
                          .portfolioDescriptionController,
                      label: "Portfolio Description",
                      minLines: 5,
                    ),
                    const SizedBox(height: 20),
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

  // Builds a header for sections
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    final int minLines = 1,
  }) {
    var border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Gap(6),
        TextFormField(
          minLines: minLines,
          maxLines: minLines + 5,
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
          ),
        ),
      ],
    );
  }
}
