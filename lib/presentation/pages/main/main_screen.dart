import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:studysphere/app/theme/app_theme.dart';
// Import halaman-halaman untuk setiap tab
import 'home_page.dart';
import 'lamp_page.dart';
import 'noise_page.dart';
import 'camera_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Controller untuk menangani PageView
  final _pageController = PageController(initialPage: 0);

  /// Controller untuk menangani bottom nav bar
  final _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Daftar halaman
  final List<Widget> _pages = [
    const HomePage(),
    const LampPage(),
    const NoisePage(),
    const CameraPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: AnimatedNotchBottomBar(
          /// Parameter yang diperlukan
          kIconSize: 24.0, // Ukuran ikon
          kBottomRadius: 0.0, // Ubah ke 0 agar tidak ada jarak di sudut
          
          /// Provide NotchBottomBarController
          notchBottomBarController: _controller,
          color: AppTheme.primary400, // Warna biru dari StudySphere
          showLabel: true,
          notchColor: AppTheme.primary400, // Warna notch sama dengan bar
          
          /// Ubah menjadi true agar tidak ada margin samping
          removeMargins: true,
          
          // Sesuaikan dengan lebar layar
          bottomBarWidth: MediaQuery.of(context).size.width,
          durationInMilliSeconds: 300,
          
          // Parameter tambahan jika tersedia di versi package Anda
          // kMarginBottom: 0, // Uncomment jika parameter ini tersedia
          
          bottomBarItems: [
            // Item Home
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home_rounded,
                color: Colors.white.withOpacity(0.5),
              ),
              activeItem: const Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
              itemLabel: 'Home',
            ),
            
            // Item Lamp
            BottomBarItem(
              inActiveItem: Icon(
                Icons.lightbulb_outline_rounded,
                color: Colors.white.withOpacity(0.5),
              ),
              activeItem: const Icon(
                Icons.lightbulb_rounded,
                color: Colors.white,
              ),
              itemLabel: 'Lamp',
            ),
            
            // Item Noise
            BottomBarItem(
              inActiveItem: Icon(
                Icons.volume_up_outlined,
                color: Colors.white.withOpacity(0.5),
              ),
              activeItem: const Icon(
                Icons.volume_up_rounded,
                color: Colors.white,
              ),
              itemLabel: 'Noise',
            ),
            
            // Item Kamera
            BottomBarItem(
              inActiveItem: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white.withOpacity(0.5),
              ),
              activeItem: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
              itemLabel: 'Camera',
            ),
          ],
          onTap: (index) {
            // Pindah halaman ketika tab di-tap
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}