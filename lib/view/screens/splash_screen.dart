import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
// Import your next screen (e.g., HomeScreen)
// import 'package:your_app/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Declare the player instance as a member of the state
  late AudioPlayer _audioPlayer; // Use late or initialize directly

  @override
  void initState() {
    super.initState();
    // Initialize the player
    _audioPlayer = AudioPlayer();
    _playSoundAndNavigate();
  }

  Future<void> _playSoundAndNavigate() async {
    // Play the sound effect (fire and forget, don't await completion here)
    try {
      
      await _audioPlayer.play(AssetSource('sounds/splash_sound.mp3'));
      debugPrint("Splash sound started playing.");
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }

    // Add a delay for the splash screen duration
    await Future.delayed(const Duration(seconds: 3)); // Adjust duration as needed

    // Navigate to the next screen (replace with your actual navigation logic)
    if (mounted) { // Check if the widget is still in the tree
      // Example using Navigator.pushReplacement to prevent going back to splash
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
      debugPrint("Would navigate to next screen now."); // Placeholder
    }
  }

  @override
  void dispose() {
    // Dispose the player when the widget is removed from the tree
    _audioPlayer.dispose();
    debugPrint("AudioPlayer disposed.");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Removed the incorrect Expanded widget
    return Scaffold(
      body: Container( // Container fills the Scaffold body
        color: Colors.white,
        child: Stack(
          children: [ Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                "assets/animation/splash.json",
                // Optional: You could use the Lottie controller to sync navigation
                // onLoaded: (composition) {
                //   _controller
                //     ..duration = composition.duration
                //     ..forward().whenComplete(() => _navigateToNextScreen());
                // },
              ),
            ),
          ),
          Positioned(
            bottom:0 ,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: SvgPicture.asset(
                "assets/icons/ahya.svg",
                    width: 100,
              ),
            ))

          ]
        ),
      ),
    );
  }
}