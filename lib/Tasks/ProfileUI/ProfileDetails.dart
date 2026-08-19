import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileDetailsScreen());
}

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', scaffoldBackgroundColor: Colors.white),
      home: const ProfileScreen(),
    );
  }
}

/// Simple data holder for profile fields. Everything starts empty.
class ProfileData {
  String name;
  String gender;
  String birthday;
  String phone;
  String email;
  String username;

  ProfileData({
    this.name = '',
    this.gender = '',
    this.birthday = '',
    this.phone = '',
    this.email = '',
    this.username = '',
  });

  ProfileData copy() => ProfileData(
    name: name,
    gender: gender,
    birthday: birthday,
    phone: phone,
    email: email,
    username: username,
  );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Starts empty — nothing hardcoded. Filled once user saves from Edit screen.
  ProfileData _profile = ProfileData();

  Future<void> _openEditScreen() async {
    final result = await Navigator.of(context).push<ProfileData>(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(initialData: _profile.copy()),
      ),
    );
    if (result != null) {
      setState(() => _profile = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasName = _profile.name.isNotEmpty;
    final hasUsername = _profile.username.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  _circleIconButton(Icons.arrow_back_ios_new, () => Navigator.of(context).maybePop()),
                  const Expanded(
                    child: Center(
                      child: Text('Profile',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 45, color: Colors.white),
              ),
              const SizedBox(height: 14),
              Text(
                hasName ? _profile.name : 'Add your name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: hasName ? Colors.black : Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                hasUsername ? '@${_profile.username}' : 'Set a username',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _openEditScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              _menuTile(Icons.settings_outlined, 'Settings'),
              _menuTile(Icons.assignment_outlined, 'My Orders'),
              _menuTile(Icons.location_on_outlined, 'Address'),
              _menuTile(Icons.lock_outline, 'Change Password'),
              const Divider(),
              _menuTile(Icons.help_outline, 'Help & Support'),
              _menuTile(Icons.logout, 'Log out'),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.home_outlined, color: Colors.white),
            Icon(Icons.favorite_border, color: Colors.white),
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.shopping_bag_outlined, color: Colors.white),
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _menuTile(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {},
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final ProfileData initialData;

  const EditProfileScreen({super.key, required this.initialData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _genderController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData.name);
    _genderController = TextEditingController(text: widget.initialData.gender);
    _birthdayController = TextEditingController(text: widget.initialData.birthday);
    _phoneController = TextEditingController(text: widget.initialData.phone);
    _emailController = TextEditingController(text: widget.initialData.email);
    _usernameController = TextEditingController(text: widget.initialData.username);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _save() {
    final updated = ProfileData(
      name: _nameController.text.trim(),
      gender: _genderController.text.trim(),
      birthday: _birthdayController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
    );
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Edit Profile',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 45, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              _inputField('Full name', _nameController),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _inputField('Gender', _genderController)),
                  const SizedBox(width: 12),
                  Expanded(child: _inputField('Birthday', _birthdayController, hint: 'DD-MM-YYYY')),
                ],
              ),
              const SizedBox(height: 14),
              _inputField('Phone number', _phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 14),
              _inputField('Email', _emailController, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _inputField('User name', _usernameController),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Bordered input box, styled like the original static field but now
  /// editable and empty by default (with a placeholder hint).
  Widget _inputField(
      String label,
      TextEditingController controller, {
        String? hint,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: InputBorder.none,
              hintText: hint ?? 'Enter $label',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}