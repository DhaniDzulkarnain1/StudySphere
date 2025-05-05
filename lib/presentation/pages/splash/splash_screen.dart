import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../pages/guide/guide_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  
  // Animasi untuk elemen-elemen splash
  late Animation<double> _circleYPosition;
  late Animation<double> _circleSize;
  late Animation<Color?> _circleColor;
  late Animation<double> _circleShadowBlur;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoYOffset;
  late Animation<double> _secondLogoOpacity;
  
  @override
  void initState() {
    super.initState();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    
    // Controller untuk seluruh animasi dengan total durasi 5 detik
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    
    _setupAnimations();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mainController.forward().then((_) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const GuideScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, -0.2),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    )),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 800),
            ),
          );
        }
      });
    });
  }
  
  void _setupAnimations() {
    // Animasi posisi Y lingkaran - dari atas layar ke tengah (0-15%)
    _circleYPosition = TweenSequence<double>([
      // Fase 1: Jatuh dari atas ke tengah
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.5, end: 0.0)
          .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 15,
      ),
      // Fase 2-5: Tetap di tengah
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 85,
      ),
    ]).animate(_mainController);
    
    // Animasi ukuran lingkaran - ukuran tetap di awal, baru membesar setelah jatuh (15-80%)
    _circleSize = TweenSequence<double>([
      // Fase 1: Ukuran tetap saat jatuh
      TweenSequenceItem(
        tween: ConstantTween<double>(0.1),
        weight: 15,
      ),
      // Fase 2: Mulai membesar setelah jatuh
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: 0.47)
          .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 15,
      ),
      // Fase 3: Membesar lebih lanjut
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.47, end: 0.70)
          .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      // Fase 4: Membesar hingga melebihi layar
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.70, end: 2.4)
          .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      // Tetap di ukuran maksimum
      TweenSequenceItem(
        tween: ConstantTween<double>(2.4),
        weight: 20,
      ),
    ]).animate(_mainController);
    
    // Animasi warna lingkaran
    _circleColor = TweenSequence<Color?>([
      // Fase 1-2: Warna awal biru muda
      TweenSequenceItem(
        tween: ConstantTween<Color>(const Color(0xFF92C7FF)),
        weight: 30,
      ),
      // Fase 3: Berubah ke warna lebih muda
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFF92C7FF),
          end: const Color(0xFFCCE5FF),
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 15,
      ),
      // Fase 4: Berubah ke warna hampir putih
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFFCCE5FF),
          end: const Color(0xFFEFF7FF),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      // Fase 5: Kembali ke warna biru muda
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFFEFF7FF),
          end: const Color(0xFF92C7FF),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
    ]).animate(_mainController);
    
    // Animasi blur shadow
    _circleShadowBlur = TweenSequence<double>([
      // Fase 1-2: Blur kecil
      TweenSequenceItem(
        tween: ConstantTween<double>(4.0),
        weight: 30,
      ),
      // Fase 3: Meningkat blur
      TweenSequenceItem(
        tween: Tween<double>(begin: 4.0, end: 25.0)
          .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      // Fase 4-5: Tetap blur maksimum
      TweenSequenceItem(
        tween: ConstantTween<double>(25.0),
        weight: 50,
      ),
    ]).animate(_mainController);
    
    // Animasi opacity untuk logo pertama (muncul setelah lingkaran jatuh)
    _logoOpacity = TweenSequence<double>([
      // Fase 1: Tidak terlihat (0-15%)
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 15,
      ),
      // Transisi: Mulai muncul (15-20%)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeIn)),
        weight: 5,
      ),
      // Fase 2-4: Fully visible (20-80%)
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 60,
      ),
      // Fase 5: Tetap visible
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 20,
      ),
    ]).animate(_mainController);
    
    // Animasi logo bergerak ke atas (80-100%)
    _logoYOffset = TweenSequence<double>([
      // Fase 1-4: Tidak bergerak
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 80,
      ),
      // Fase 5: Bergerak ke atas
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -70.0)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_mainController);
    
    // Animasi opacity logo kedua (80-100%)
    _secondLogoOpacity = TweenSequence<double>([
      // Fase 1-4: Tidak muncul
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 80,
      ),
      // Fase 5: Muncul secara perlahan
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
    ]).animate(_mainController);
    
    // Untuk memastikan UI diperbarui
    _mainController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }
  
  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final shortestSide = size.shortestSide;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Ukuran logo yang responsif (35% dari sisi terpendek layar)
    final double logoSize = shortestSide * 0.35;
    
    // Ukuran lingkaran berdasarkan persentase dari sisi terpendek layar
    final double currentCircleSize = shortestSide * _circleSize.value;
    
    // Warna dan efek shadow
    final Color currentCircleColor = _circleColor.value ?? const Color(0xFF92C7FF);
    final double currentBlurRadius = _circleShadowBlur.value;
    
    // Posisi lingkaran - sekarang menggunakan posisi relatif terhadap tengah layar
    final double circleYOffset = _circleYPosition.value * size.height;
    final double circleY = centerY + circleYOffset - (currentCircleSize / 2);
    
    // Posisi X lingkaran - selalu di tengah horizontal
    final double circleX = centerX - (currentCircleSize / 2);
    
    // Posisi logo
    final double logoX = centerX - (logoSize / 2);
    final double logoY = centerY - (logoSize * 0.45) + _logoYOffset.value;
    
    // Posisi logo kedua
    final double secondLogoX = centerX - (logoSize / 2);
    final double secondLogoY = centerY + (logoSize * 0.1);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Lingkaran dengan shadow
          Positioned(
            left: circleX,
            top: circleY,
            child: Container(
              width: currentCircleSize,
              height: currentCircleSize,
              decoration: BoxDecoration(
                color: currentCircleColor,
                shape: BoxShape.circle,
                boxShadow: [
                  // Inner shadow
                  BoxShadow(
                    color: const Color(0x40000000), // 25% opacity
                    offset: const Offset(0, 4),
                    blurRadius: currentBlurRadius,
                    spreadRadius: 0,
                  ),
                  // Drop shadow
                  BoxShadow(
                    color: Color.fromRGBO(204, 229, 255, 
                      _mainController.value > 0.5 ? 1.0 : 0.5),
                    offset: const Offset(0, -2),
                    blurRadius: currentBlurRadius * 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          
          // Logo utama - dengan opacity control
          Positioned(
            left: logoX,
            top: logoY,
            child: Opacity(
              opacity: _logoOpacity.value,
              child: Image.asset(
                'assets/images/logo_studysphere_1.png',
                width: logoSize,
                height: logoSize * 0.9,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Logo kedua - muncul di bawah logo pertama pada fase terakhir
          if (_secondLogoOpacity.value > 0.01)
            Positioned(
              left: secondLogoX,
              top: secondLogoY,
              child: Opacity(
                opacity: _secondLogoOpacity.value,
                child: Transform.scale(
                  scale: _secondLogoOpacity.value,
                  child: Image.asset(
                    'assets/images/logo_studysphere_2.png',
                    width: logoSize,
                    height: logoSize * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}