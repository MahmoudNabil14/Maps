import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_cubit.dart';
import 'package:maps/shared/Styles/colors.dart';
import 'package:maps/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  Widget buildDrawerHeader() {
    return const DrawerHeader(child: Center(child: Text("Maps App")));
  }

  Widget buildListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? triangle,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      title: Text(title,style: const TextStyle(fontSize: 18.0),),
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      trailing: triangle ??
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return const Divider(
      thickness: 1.0,
      height: 0.0,
      indent: 40.0,
      endIndent: 40.0,
    );
  }

  Widget buildSocialPlatformIcon(
      {required IconData icon, required String url}) {
    return InkWell(
      child: Icon(icon,color: MyColors.blue, size: 30.0,),
      onTap: () {
        _launchUrl(url);
      },
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          buildSocialPlatformIcon(
              icon: FontAwesomeIcons.facebook,
              url: "https://www.facebook.com/Odda11/"),
          const SizedBox(
            width: 20.0,
          ),
          buildSocialPlatformIcon(
              icon: FontAwesomeIcons.github,
              url: "https://github.com/MahmoudNabil14"),
          const SizedBox(
            width: 20.0,
          ),
          buildSocialPlatformIcon(
              icon: FontAwesomeIcons.linkedin,
              url: "https://www.linkedin.com/in/mahmoud-nabil-b6a8401b5/"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          buildDrawerHeader(),
          buildListItem(
            title: 'Profile',
            leadingIcon: Icons.person,
          ),
          buildDrawerListItemsDivider(),
          buildListItem(
            title: 'History',
            leadingIcon: Icons.history,
          ),
          buildDrawerListItemsDivider(),
          buildListItem(
            title: 'Help',
            leadingIcon: Icons.help,
          ),
          buildDrawerListItemsDivider(),
          buildListItem(
              title: 'Logout',
              leadingIcon: Icons.logout,
              onTap: () {
                PhoneAuthCubit.get(context).signOut();
                Navigator.pushReplacementNamed(context, loginScreen);
              },
              color: Colors.red),
          const SizedBox(height: 300,),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child:  Text("Contact us:", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
          ),
          const SizedBox(height: 20.0,),
          buildSocialMediaIcons()
        ],
      ),
    );
  }
}
