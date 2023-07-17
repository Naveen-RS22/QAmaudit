import 'package:flutter/material.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';

class ProfileToolBar extends StatefulWidget {
  const ProfileToolBar({Key? key}) : super(key: key);

  @override
  State<ProfileToolBar> createState() => _ProfileToolBarState();
}

class _ProfileToolBarState extends State<ProfileToolBar> {
  var userName = '';
  var rollCode = '';
  var displayName = '';
  var locationCode = '';
  @override
  void initState() {
    getUserName();
    getRoleName();
    getDisplayUserName();
    getLocationCode();
    super.initState();
  }

  getUserName() async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);

    setState(() {
      userName = userN;
    });
  }

  getRoleName() async {
    String roll =
        await SharedPreferenceHelper.getString(Constants.currentRoleName);

    setState(() {
      rollCode = roll;
    });
  }

  getLocationCode() async {
    String locationCod =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);

    setState(() {
      locationCode = locationCod;
    });
  }

  getDisplayUserName() async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);

    setState(() {
      displayName = userN.isEmpty ? '' : userN[0].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, Constants.profileRoute);
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.res.color.bgColorBlue.withOpacity(0.3)),
            child: Center(
              child: Text(
                displayName,
                style: TextStyle(
                  color: context.res.color.bgColorBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: context.res.color.bgColorBlue,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rollCode,
                  style: TextStyle(
                    color: context.res.color.textGray,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      locationCode,
                      style: TextStyle(
                          color: context.res.color.textGray,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
