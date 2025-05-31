import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/model/gender.dart'; // ⬅️ enum + assetPath
import 'package:sparks/model/intern.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/view/screens/profile_page.dart';

class ProfileCard extends StatefulWidget {
  final Intern profile;

  const ProfileCard({super.key, required this.profile});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isSaved = false;

  /* ── helpers ─────────────────────────────────────────── */

  String _getInitials(String name) {
    final parts = name.split(' ');
    return (parts.length >= 2 ? parts[0][0] + parts[1][0] : name[0])
        .toUpperCase();
  }

  Color _generateRandomColor(String seed) {
    final hash = seed.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }

  Future<bool> _assetExists(String? path) async {
    if (path == null || path.isEmpty) return false;
    try {
      await DefaultAssetBundle.of(context).load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  /* ── build ───────────────────────────────────────────── */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => RouteController.goTo(
        ProfilePage(intern: widget.profile),
        'profile',
      ),
      child: AspectRatio(
        aspectRatio: 511 / 160,
        child: Container(
          padding: const EdgeInsets.all(13),
          constraints: const BoxConstraints(minWidth: 511, maxWidth: 700),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.cyan.withOpacity(.20), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* ── avatar ──────────────────────────────── */
              AspectRatio(
                aspectRatio: 1,
                child: LayoutBuilder(
                  builder: (context, cts) {
                    final size = cts.maxWidth;
                    return Stack(
                      children: [
                        FutureBuilder<bool>(
                          future: _assetExists(widget.profile.imageUrl),
                          builder: (ctx, snap) {
                            if (snap.data == true) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(widget.profile.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                            return CircleAvatar(
                              radius: size / 2,
                              backgroundColor:
                                  _generateRandomColor(widget.profile.name),
                              child: Text(
                                _getInitials(widget.profile.name),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size / 2.5,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              /* ── details ─────────────────────────────── */
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.profile.name,
                        style: const TextStyle(
                          fontFamily: 'lato',
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Division: ${widget.profile.division}',
                        style: const TextStyle(
                          fontFamily: 'lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              /* ── actions ─────────────────────────────── */
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      _isSaved
                          ? 'assets/icons/icon=icon12.svg'
                          : 'assets/icons/icon=save.svg',
                      width: 40,
                    ),
                    onPressed: () => setState(() => _isSaved = !_isSaved),
                  ),
                  SvgPicture.asset(
                    widget.profile.gender.assetPath(), // enum-driven icon
                    width: 30,
                    height: 30,
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
