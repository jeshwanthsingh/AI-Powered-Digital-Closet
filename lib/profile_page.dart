import 'package:flutter/material.dart';
import 'dart:ui';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _headerHeight = 260;
  
  // Mock data - would come from your backend in a real app
  final Map<String, dynamic> userData = {
    "name": "Alex Morgan",
    "email": "alex.morgan@example.com",
    "items": 124,
    "outfits": 15,
    "favorites": 32,
    "memberSince": "November 2023",
    "style": "Casual Contemporary"
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Profile Header
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Header background with gradient
                Container(
                  height: _headerHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryColor,
                        primaryColor.withOpacity(0.8),
                        secondaryColor.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                
                // Decorative patterns
                Positioned(
                  top: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 0.1,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Profile card
                Positioned(
                  top: _headerHeight - 80,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      elevation: 8,
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Profile image with stacked elements
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Outer circle
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                secondaryColor,
                                                primaryColor,
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Inner white circle
                                        Container(
                                          width: 94,
                                          height: 94,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // Profile icon or image
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: theme.colorScheme.secondary.withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 45,
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ),
                                        // "Pro" badge
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: const Text(
                                              "PRO",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    // User info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userData['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userData['email'],
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          // Style tag
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: secondaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: secondaryColor.withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              userData['style'],
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Stats row
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildStatItem(context, userData['items'].toString(), "Items", Icons.checkroom_outlined),
                                      _buildDivider(),
                                      _buildStatItem(context, userData['outfits'].toString(), "Outfits", Icons.style_outlined),
                                      _buildDivider(),
                                      _buildStatItem(context, userData['favorites'].toString(), "Favorites", Icons.favorite_outline),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Spacing after profile card
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
          
          // Tab bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: primaryColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Account"),
                  Tab(text: "Preferences"),
                  Tab(text: "Privacy"),
                ],
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),
          
          // Tab content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Account settings
                _buildAccountTab(context),
                
                // Preferences settings
                _buildPreferencesTab(context),
                
                // Privacy settings
                _buildPrivacyTab(context),
              ],
            ),
          ),
        ],
      ),
      // Sign out floating action button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Sign out functionality
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        backgroundColor: primaryColor,
        icon: const Icon(Icons.logout),
        label: const Text("SIGN OUT"),
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          size: 20,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey[300],
    );
  }
  
  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: onTap ?? () {},
    );
  }
  
  Widget _buildSettingsSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildAccountTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildSettingsSection(
          context,
          "PERSONAL INFORMATION",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.person_outline,
              title: "Edit Profile",
              subtitle: "Change your name, email, and profile photo",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.style_outlined,
              title: "Fashion Style",
              subtitle: userData['style'],
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.calendar_today_outlined,
              title: "Member Since",
              subtitle: userData['memberSince'],
              trailing: null,
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "CONNECTED ACCOUNTS",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.cloud_outlined,
              title: "Cloud Backup",
              subtitle: "Backup your wardrobe to the cloud",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.calendar_month_outlined,
              title: "Calendar",
              subtitle: "Connect your calendar for outfit planning",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.chat_outlined,
              title: "Connected Social Accounts",
              subtitle: "Share your outfits on social media",
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "SUBSCRIPTION",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.workspace_premium,
              title: "Premium Features",
              subtitle: "Pro Member • Renews Aug 15, 2025",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.payment_outlined,
              title: "Payment Methods",
              subtitle: "Manage your payment options",
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPreferencesTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildSettingsSection(
          context,
          "APPEARANCE",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.palette_outlined,
              title: "App Theme",
              subtitle: "Light mode",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.format_size,
              title: "Text Size",
              subtitle: "Medium",
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "NOTIFICATIONS",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.notifications_outlined,
              title: "Push Notifications",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.email_outlined,
              title: "Email Notifications",
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.wb_sunny_outlined,
              title: "Weather Alerts",
              subtitle: "Get notified about weather changes",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "ADVANCED",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.language,
              title: "Language",
              subtitle: "English (US)",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.storage_outlined,
              title: "Storage",
              subtitle: "45.8 MB used",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.cached,
              title: "Clear Cache",
              subtitle: "Free up space on your device",
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPrivacyTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildSettingsSection(
          context,
          "SECURITY",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Last changed 3 months ago",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.security,
              title: "Two-Factor Authentication",
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "PRIVACY",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.visibility_outlined,
              title: "Profile Visibility",
              subtitle: "Only friends can see your profile",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.location_on_outlined,
              title: "Location Services",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.share_outlined,
              title: "Outfit Sharing",
              subtitle: "Control who can see your outfits",
            ),
          ],
        ),
        _buildSettingsSection(
          context,
          "DATA",
          [
            _buildSettingsTile(
              context: context,
              icon: Icons.download_outlined,
              title: "Download Your Data",
              subtitle: "Get a copy of your wardrobe data",
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.delete_outline,
              title: "Delete Account",
              subtitle: "Permanently delete your account and data",
            ),
          ],
        ),
        // Add extra space at the bottom for the FAB
        const SizedBox(height: 80),
      ],
    );
  }
}

// Tab bar delegate
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, {this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (shrinkOffset > 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar || backgroundColor != oldDelegate.backgroundColor;
  }
}