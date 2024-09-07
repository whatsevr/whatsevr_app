import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsevr_app/src/features/update_profile/bloc/bloc.dart';

// Adjust the import
class ProfileUpdatePageArgument {}

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // TextEditingControllers for each field
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _bioController;
  late TextEditingController _addressController;
  late TextEditingController _dobController;
  late TextEditingController _portfolioTitleController;
  late TextEditingController _portfolioDescriptionController;
  late TextEditingController _service1Controller;
  late TextEditingController _service2Controller;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty values or Bloc state
    _nameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    _bioController = TextEditingController();
    _addressController = TextEditingController();
    _dobController = TextEditingController();
    _portfolioTitleController = TextEditingController();
    _portfolioDescriptionController = TextEditingController();
    _service1Controller = TextEditingController();
    _service2Controller = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the tree
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _portfolioTitleController.dispose();
    _portfolioDescriptionController.dispose();
    _service1Controller.dispose();
    _service2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
            ),
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                // Update controllers with initial values from state
                _nameController.text = state.name;
                _userNameController.text = state.userName;
                _emailController.text = state.email;
                _mobileController.text = state.mobile;
                _bioController.text = state.bio;
                _addressController.text = state.address;
                _dobController.text = state.dob;
                _portfolioTitleController.text = state.portfolioTitle;
                _portfolioDescriptionController.text =
                    state.portfolioDescription;
                _service1Controller.text = state.service1;
                _service2Controller.text = state.service2;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        // Personal Info Section
                        _buildSectionHeader('Personal Information'),
                        _buildTextField(
                          controller: _nameController,
                          label: "Name",
                        ),
                        _buildTextField(
                          controller: _userNameController,
                          label: "Username",
                        ),
                        _buildTextField(
                          controller: _emailController,
                          label: "Email",
                        ),
                        _buildTextField(
                          controller: _mobileController,
                          label: "Mobile",
                        ),
                        _buildTextField(
                          controller: _bioController,
                          label: "Bio",
                        ),
                        _buildTextField(
                          controller: _addressController,
                          label: "Address",
                        ),
                        _buildTextField(
                          controller: _dobController,
                          label: "Date of Birth",
                        ),
                        const SizedBox(height: 20),

                        // Service Info Section
                        _buildSectionHeader('Service Information'),
                        _buildTextField(
                          controller: _service1Controller,
                          label: "Service 1",
                        ),
                        _buildTextField(
                          controller: _service2Controller,
                          label: "Service 2",
                        ),
                        const SizedBox(height: 20),

                        // Portfolio Info Section
                        _buildSectionHeader('Portfolio Information'),
                        _buildTextField(
                          controller: _portfolioTitleController,
                          label: "Portfolio Title",
                        ),
                        _buildTextField(
                          controller: _portfolioDescriptionController,
                          label: "Portfolio Description",
                        ),
                        const SizedBox(height: 20),

                        // Profile and Cover Image Section
                        _buildSectionHeader('Images'),
                        _buildImagePicker(
                          label: "Profile Image",
                          currentImage: state.profileImage,
                          onImageSelected: (file) {
                            context
                                .read<ProfileBloc>()
                                .add(UploadProfilePicture(file));
                          },
                        ),
                        _buildImagePicker(
                          label: "Cover Image",
                          currentImage: state.coverImage,
                          onImageSelected: (file) {
                            context
                                .read<ProfileBloc>()
                                .add(UploadCoverPicture(file));
                          },
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        ElevatedButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // Collect values from TextEditingController and dispatch SubmitProfile
                                    final name = _nameController.text;
                                    final userName = _userNameController.text;
                                    final email = _emailController.text;
                                    final mobile = _mobileController.text;
                                    final bio = _bioController.text;
                                    final address = _addressController.text;
                                    final dob = _dobController.text;
                                    final portfolioTitle =
                                        _portfolioTitleController.text;
                                    final portfolioDescription =
                                        _portfolioDescriptionController.text;
                                    final service1 = _service1Controller.text;
                                    final service2 = _service2Controller.text;

                                    // Dispatch SubmitProfile with all the data
                                    context
                                        .read<ProfileBloc>()
                                        .add(SubmitProfile(
                                          name: name,
                                          userName: userName,
                                          email: email,
                                          mobile: mobile,
                                          bio: bio,
                                          address: address,
                                          dob: dob,
                                          portfolioTitle: portfolioTitle,
                                          portfolioDescription:
                                              portfolioDescription,
                                          service1: service1,
                                          service2: service2,
                                        ));
                                  }
                                },
                          child: state.isSubmitting
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text('Submit Profile'),
                        ),

                        if (state.isSuccess)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Profile submitted successfully!',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        if (state.isFailure)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Profile submission failed.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
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
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker({
    required String label,
    required File? currentImage,
    required Function(File) onImageSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final XFile? pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
          child: currentImage == null
              ? Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey[200],
                  child: Icon(Icons.add_a_photo),
                )
              : Image.file(currentImage, height: 100, width: 100),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
