import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:sparks/model/gender.dart';           // enum + assetPath()
import 'package:sparks/model/profile_card_model.dart';

import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/view/screens/supervisor_profile_page.dart';

class SupervisorCard extends StatefulWidget {
  final ProfileCardInfo supervisor;

  const SupervisorCard({super.key, required this.supervisor});

  @override
  State<SupervisorCard> createState() => _SupervisorCardState();
}

class _SupervisorCardState extends State<SupervisorCard> {
  /* ── helpers ─────────────────────────────────────────── */

  String _getInitials(String name) {
    final parts = name.split(' ');
    return (parts.length >= 2 ? parts[0][0] + parts[1][0] : name[0]).toUpperCase();
  }

  Color _generateRandomColor(String seed) {
    final hash = seed.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r % 156 + 100, g % 156 + 100, b % 156 + 100);
  }

  Future<bool> _assetExists(String? assetPath) async {
    if (assetPath == null || assetPath.isEmpty) return false;
    try {
      await DefaultAssetBundle.of(context).load(assetPath);
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
        SupervisorProfilePage(profile: widget.supervisor),
        'supervisor_profile',
      ),
      child: AspectRatio(
        aspectRatio: 511 / 160,
        child: Container(
          padding: const EdgeInsets.all(13),
          constraints: const BoxConstraints(minWidth: 511, maxWidth: 700),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.blue.withOpacity(.20), width: 1),
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
              /* ── avatar ───────────────────────────────── */
              AspectRatio(
                aspectRatio: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final avatarSize = constraints.maxWidth;
                    return Stack(
                      children: [
                        FutureBuilder<bool>(
                          future: _assetExists(widget.supervisor.imageUrl),
                          builder: (context, snap) {
                            if (snap.data == true) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(widget.supervisor.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                            return CircleAvatar(
                              radius: avatarSize / 2,
                              backgroundColor:
                              _generateRandomColor(widget.supervisor.name),
                              child: Text(
                                _getInitials(widget.supervisor.name),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: avatarSize / 2.5,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            'assets/icons/icon=sheild.svg',
                            width: avatarSize * .3,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /* ── details ──────────────────────────────── */
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.supervisor.name,
                        style: const TextStyle(
                          fontFamily: 'lato',
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Division: ${widget.supervisor.division}',
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

              /* ── action icons ─────────────────────────── */
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset('assets/icons/icon=edit.svg', width: 40),
                  ),
                  SvgPicture.asset(
                    widget.supervisor.gender.assetPath(), // enum => icon
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
