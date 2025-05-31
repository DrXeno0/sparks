import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/controller/intern_profile_controller.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/utils/email_helper.dart';
import 'package:sparks/view/components/icon_button.dart';
import 'package:sparks/view/components/intern_info_table.dart';
import 'package:sparks/view/components/my_custom_button.dart';
import 'package:sparks/view/theme.dart';

const _kHeaderGap = 40.0;
const _kActionGap = 9.0;
const _kPrimaryAvatarBorder = 1.0;
const _kButtonHeight = 43.0;
const _kCorner = 13.0;

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, required this.intern});

  final Intern intern;
  final InternProfileController _controller = InternProfileController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _Header(intern: intern),
          const SizedBox(height: _kHeaderGap),
          _ActionBar(intern: intern, controller: _controller),
          const SizedBox(height: 30),
          Expanded(
            child:
                SingleChildScrollView(child: InternInfoTable(intern: intern)),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.intern});

  final Intern intern;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cts) {
        final width = cts.maxWidth;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * .3,
              child: Text(
                intern.name,
                style: TextStyle(
                  fontFamily: 'lato',
                  fontSize: width * .04,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.5,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * .2),
              child: _Avatar(
                gender: intern.gender,
                name: intern.name,
                imageUrl: null,
              ),
            ),
            SizedBox(
              width: width * .3,
              child: Text(
                intern.division,
                style: TextStyle(
                  fontFamily: 'lato',
                  fontSize: width * .04,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none,
                  color: _ColorUtil.random(intern.division),
                  letterSpacing: 3.5,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.intern, required this.controller});

  final Intern intern;
  final InternProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /* delete */
        MyButton(
          text: 'Delete Intern',
          iconAsset: 'assets/icons/icon=trash.svg',
          onPressed: () => controller.deleteIntern(context, intern),
          height: _kButtonHeight,
          width: 194,
          borderRadius: _kCorner,
          backgroundColor: white90,
          borderColor: darkRed,
          color: darkGray,
          defaultBorderWidth: 3,
          clickedBorderWidth: 0,
          animationDuration: const Duration(seconds: 1),
        ),
        const SizedBox(width: _kActionGap),

        /* mail */
        MyIconButton(
          iconAsset: 'assets/icons/icon=mail.svg',
          iconWidth: 43,
          iconColor: darkGray,
          backgroundColor: yellow,
          borderColor: darkGray,
          defaultBorderWidth: 3,
          clickedBorderWidth: 0,
          width: 43,
          height: 43,
          borderRadius: _kCorner,
          animationDuration: const Duration(seconds: 1),
          onPressed: () async {
            final sent = await EmailHelper().showEmailComposeDialog(
              context,
              onSend: (sub, body) =>
                  controller.sendEmail(intern.email, sub, body),
            );

            if (sent && context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Email sent')));
            }
          },
        ),
        const SizedBox(width: _kActionGap),

        /* filter placeholder */
        const MyIconButton(
          iconAsset: 'assets/icons/icon=filter.svg',
          iconWidth: 43,
          iconColor: darkGray,
          backgroundColor: white90,
          borderColor: darkGray,
          defaultBorderWidth: 3,
          clickedBorderWidth: 0,
          width: 43,
          height: 43,
          borderRadius: _kCorner,
          animationDuration: Duration(seconds: 1),
        ),
        const SizedBox(width: _kActionGap),

        /* report placeholder */
        const MyIconButton(
          iconAsset: 'assets/icons/report.svg',
          iconWidth: 43,
          iconColor: Colors.white,
          backgroundColor: darkRed,
          borderColor: darkGray,
          defaultBorderWidth: 3,
          clickedBorderWidth: 0,
          width: 43,
          height: 43,
          borderRadius: _kCorner,
          animationDuration: Duration(seconds: 1),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.gender,
    required this.imageUrl,
    required this.name,
  });

  final Gender gender;
  final String? imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (ctx, cts) {
        final size = cts.maxWidth;

        return FutureBuilder<bool>(
          future: _AssetUtil.exists(context, imageUrl),
          builder: (ctx, snap) {
            final showImage = snap.data == true;
            return Stack(
              children: [
                /* avatar pic or fallback */
                if (showImage)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(imageUrl!), fit: BoxFit.cover),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: size / 2,
                    backgroundColor: _ColorUtil.random(name),
                    child: Text(
                      name.initials(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * .5,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: size * .3,
                    height: size * .3,
                    padding: EdgeInsets.all(size * .06),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.cyan.withOpacity(.20),
                        width: _kPrimaryAvatarBorder,
                      ),
                    ),
                    child: SvgPicture.asset(gender.assetPath()),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

extension on String {
  String initials() {
    final parts = split(' ');
    return (parts.length >= 2 ? parts[0][0] + parts[1][0] : this[0])
        .toUpperCase();
  }
}

class _ColorUtil {
  static Color random(String seed) {
    final hash = seed.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }
}

class _AssetUtil {
  static Future<bool> exists(BuildContext ctx, String? path) async {
    if (path == null || path.isEmpty) return false;
    try {
      await DefaultAssetBundle.of(ctx).load(path);
      return true;
    } catch (_) {
      return false;
    }
  }
}
