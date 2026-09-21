import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/API/LOGIN/apiservice.dart';
import 'package:flutter_series/Tasks/API/LOGIN/loginmodel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_series/Tasks/API/LOGIN/cloudinaryservice.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserModel user;

  const ProfileEditScreen({super.key, required this.user});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController passwordController;

  final ApiService apiService = ApiService();

  bool isLoading = false;
  bool obscurePassword = true;
  File? pickedImage;
  bool isUploadingImage = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.name);
    passwordController = TextEditingController(text: widget.user.password);
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked == null) return;

    final file = File(picked.path);

    setState(() {
      pickedImage = file;
      isUploadingImage = true;
    });

    try {
      final imageUrl = await CloudinaryService.uploadImage(file);

      await apiService.updateProfileImage(
        widget.user.email,
        imageUrl,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture updated'),
          backgroundColor: Colors.black,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.black,
        ),
      );
    }

    setState(() {
      isUploadingImage = false;
    });
  }

  Future<void> saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final updatedUser = await apiService.updateProfile(
        widget.user.email,
        nameController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.black,
        ),
      );

      Navigator.pop(context, updatedUser);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.black,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Stack(
                    alignment: Alignment.bottomRight,

                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),

                        child: CircleAvatar(
                          radius: 65,

                          backgroundColor: const Color(0xFF202020),

                          backgroundImage: pickedImage != null
                              ? FileImage(pickedImage!)
                              : (widget.user.profileImage != null
                              ? NetworkImage(
                            widget.user.profileImage!,
                          )
                              : null)
                          as ImageProvider?,

                          child: (
                              pickedImage == null &&
                                  widget.user.profileImage == null
                          )
                              ? Text(
                            nameController.text.isNotEmpty
                                ? nameController.text[0]
                                .toUpperCase()
                                : '?',

                            style: const TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : null,
                        ),
                      ),

                      GestureDetector(
                        onTap: isUploadingImage
                            ? null
                            : pickAndUploadImage,

                        child: Container(
                          height: 42,
                          width: 42,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,

                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),

                          child: isUploadingImage
                              ? const Padding(
                            padding: EdgeInsets.all(10),

                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                              : const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    nameController.text.isNotEmpty
                        ? nameController.text
                        : 'YOUR PROFILE',

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    widget.user.email,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildLabel('FULL NAME'),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: nameController,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),

                    cursorColor: Colors.white,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }

                      if (value.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }

                      return null;
                    },

                    decoration: _inputDecoration(
                      icon: Icons.person_outline,
                      hint: 'Enter your name',
                    ),
                  ),

                  const SizedBox(height: 25),

                  _buildLabel('PASSWORD'),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: passwordController,

                    obscureText: obscurePassword,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),

                    cursorColor: Colors.white,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }

                      if (value.length < 6) {
                        return 'Minimum 6 characters';
                      }

                      return null;
                    },

                    decoration: _inputDecoration(
                      icon: Icons.lock_outline,
                      hint: 'Enter your password',
                    ).copyWith(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },

                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,

                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: ElevatedButton(
                      onPressed: isLoading ? null : saveChanges,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        disabledBackgroundColor:
                        Colors.grey.shade800,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      child: isLoading
                          ? const SizedBox(
                        height: 23,
                        width: 23,

                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2.5,
                        ),
                      )
                          : const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 21,
                          ),

                          SizedBox(width: 10),

                          Text(
                            'SAVE CHANGES',

                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),

                        child: Text(
                          'PROFILE SETTINGS',

                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        text,

        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required IconData icon,
    required String hint,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 14,
      ),

      prefixIcon: Icon(
        icon,
        color: Colors.grey.shade500,
        size: 21,
      ),

      filled: true,

      fillColor: const Color(0xFF151515),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide(
          color: Colors.grey.shade800,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(
          color: Colors.white,
          width: 1.3,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
      ),
    );
  }
}