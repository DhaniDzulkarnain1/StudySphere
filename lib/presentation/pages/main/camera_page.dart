import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studysphere/app/theme/app_theme.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isCameraConnected = true;
  bool _isFullScreen = false;
  
  // Untuk simulasi status kamera IoT
  bool _isCameraOnline = true;
  
  // Untuk timestamp live
  String _currentTime = "";
  late Timer _timeUpdateTimer;
  
  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _startTimeUpdateTimer();
  }
  
  void _updateCurrentTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    });
  }
  
  void _startTimeUpdateTimer() {
    _timeUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });
  }

  @override
  void dispose() {
    _timeUpdateTimer.cancel();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  Widget _buildCameraView() {
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;
    const double smallSpacing = 5.0;

    return Container(
      width: double.infinity,
      height: _isFullScreen ? MediaQuery.of(context).size.height - 150 : 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(defaultRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder untuk feed kamera
            Container(
              color: Colors.black,
              child: Center(
                child: _isCameraConnected
                    ? Icon(
                        Icons.videocam,
                        size: 80,
                        color: Colors.white.withOpacity(0.7),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            size: 60,
                            color: Colors.red.withOpacity(0.8),
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            'Kamera tidak terhubung',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            // Live indicator
            Positioned(
              top: defaultSpacing,
              right: defaultSpacing,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSpacing,
                  vertical: smallSpacing,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(width: smallSpacing),
                    Text(
                      'LIVE',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Current time
            Positioned(
              bottom: defaultSpacing,
              right: defaultSpacing,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSpacing,
                  vertical: smallSpacing,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Text(
                  _currentTime,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Camera status
            Positioned(
              top: defaultSpacing,
              left: defaultSpacing,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSpacing,
                  vertical: smallSpacing,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: _isCameraOnline ? Colors.green : Colors.red,
                      size: 10,
                    ),
                    const SizedBox(width: smallSpacing),
                    Text(
                      _isCameraOnline ? 'Online' : 'Offline',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Fullscreen button (YouTube style)
            Positioned(
              bottom: defaultSpacing,
              left: defaultSpacing,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _toggleFullScreen,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header biru dengan judul
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: defaultPadding),
              color: AppTheme.primary400,
              child: Text(
                "Kamera Pantau",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Konten utama
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Camera Feed
                      _buildCameraView(),
                      
                      const SizedBox(height: defaultSpacing),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}