import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/API/LOGIN/loginmodel.dart';
import 'package:flutter_series/Tasks/API/LOGIN/editprofilescreen.dart';
import 'package:flutter_series/Tasks/API/LOGIN/sessionmanager.dart';
import 'package:flutter_series/Tasks/API/LOGIN/loginscreen.dart';
import 'package:flutter_series/Tasks/API/LOGIN/apiservice.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel currentUser;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future<void> _refreshUser() async {
    try {
      final refreshedUser =
      await apiService.getUserByEmail(currentUser.email);

      if (refreshedUser != null && mounted) {
        setState(() {
          currentUser = refreshedUser;
        });
        await SessionManager.saveSession(refreshedUser);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await SessionManager.clearSession();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginAPIScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final updatedUser = await Navigator.push<UserModel>(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditScreen(user: currentUser),
      ),
    );

    if (updatedUser != null && mounted) {
      await SessionManager.saveSession(updatedUser);

      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            onPressed: () => _openEditProfile(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshUser,
          color: Colors.white,
          backgroundColor: const Color(0xFF151515),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),
            child: Column(
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser.name.split(' ').first,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  child: Column(
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
                          radius: 58,
                          backgroundColor: Colors.black,
                          backgroundImage: currentUser.profileImage != null &&
                              currentUser.profileImage!.isNotEmpty
                              ? NetworkImage(currentUser.profileImage!)
                              : null,
                          child: currentUser.profileImage == null ||
                              currentUser.profileImage!.isEmpty
                              ? Text(
                            currentUser.name.isNotEmpty
                                ? currentUser.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        currentUser.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 7),
                          Flexible(
                            child: Text(
                              currentUser.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 1,
                        color: Colors.grey.shade800,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.verified_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'PROFILE ACTIVE',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  child: Column(
                    children: [
                      _menuItem(
                        icon: Icons.person_outline,
                        title: 'Profile',
                        subtitle: 'View your profile',
                        onTap: () {},
                      ),
                      _divider(),
                      _menuItem(
                        icon: Icons.edit_outlined,
                        title: 'Edit Profile',
                        subtitle: 'Update your information',
                        onTap: () {
                          _openEditProfile(context);
                        },
                      ),
                      _divider(),
                      _menuItem(
                        icon: Icons.logout_outlined,
                        title: 'Logout',
                        subtitle: 'Sign out from your account',
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  'FLUTTER SERIES',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'FLUTTER EDITION',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 9,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '© 2025 All Rights Reserved',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 9,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.grey.shade800,
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade600,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        height: 1,
        color: Colors.grey.shade800,
      ),
    );
  }
}