import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/models/porfile_card_model.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/ui/screens/profile_page.dart';

class ProfileCard extends StatefulWidget {
  final ProfileCardInfo profile;

  const ProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.profile.isSaved;
  }

  void toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
      widget.profile.isSaved = _isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProfilePage, passing the internId from the model.
        RouteController.goTo(ProfilePage(internId: widget.profile.internId), "profile");
      },
      child: AspectRatio(
        aspectRatio: 511 / 160,
        child: Container(
          padding: const EdgeInsets.all(13),
          constraints: const BoxConstraints(minWidth: 511, maxWidth: 700),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.cyan.withValues(alpha: 0.20),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile image with shield overlay.
              AspectRatio(
                aspectRatio: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double svgSize = constraints.maxWidth;
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(widget.profile.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            "assets/icons/icon=shield.svg",
                            width: svgSize * 0.3,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Profile details.
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.profile.name,
                        style: const TextStyle(
                          fontFamily: "lato",
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Division: ${widget.profile.division}",
                        style: const TextStyle(
                          fontFamily: "lato",
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Save button and gender icon.
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: toggleSave,
                    padding: EdgeInsets.zero,
                    icon: !_isSaved
                        ? SvgPicture.asset(
                      "assets/icons/icon=save.svg",
                      width: 40,
                    )
                        : SvgPicture.asset(
                      "assets/icons/icon=icon12.svg",
                      width: 40,
                    ),
                  ),
                  SvgPicture.asset(
                    widget.profile.gender == "male"
                        ? "assets/icons/male.svg"
                        : widget.profile.gender == "female"
                        ? "assets/icons/female.svg"
                        : "assets/icons/not_applicable.svg",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
