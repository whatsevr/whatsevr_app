import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/src/features/update_profile/bloc/bloc.dart';

// Adjust the import
class ProfileUpdatePageArgument {}

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final ImagePicker _picker = ImagePicker();

  // TextEditingControllers for each field

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
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
                                    image: state.profileImage != null
                                        ? DecorationImage(
                                            image:
                                                FileImage(state.profileImage!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
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

                    const SizedBox(height: 20),
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
                                context.read<ProfileBloc>().userNameController,
                            label: "Username",
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
                                context.read<ProfileBloc>().mobileController,
                            label: "Mobile",
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
          maxLines: minLines,
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
