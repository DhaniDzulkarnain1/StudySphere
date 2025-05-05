import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studysphere/app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/logout_dialog.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  // State timer untuk frontend
  int _totalDurationInMinutes = 45;
  int _remainingTimeInSeconds = 38 * 60 + 15; // 38:15 tersisa
  String _targetTimeString = "10:15"; // Jam selesai (frontend only)
  
  // Gradien untuk efek shimmer
  final Gradient _shimmerGradient = LinearGradient(
    colors: [
      const Color(0xFF27486B), // Warna utama text
      const Color(0xFF4C8DD1), // Warna highlight
      const Color(0xFF27486B), // Kembali ke warna utama
    ],
    stops: const [0.35, 0.5, 0.65],
    begin: const Alignment(-1.0, 0.0),
    end: const Alignment(1.0, 0.0),
    tileMode: TileMode.clamp,
  );
  
  @override
  void initState() {
    super.initState();
    // Setup untuk animasi shimmer
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Durasi 3 detik untuk shimmer
    )..repeat();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Format waktu untuk tampilan countdown
  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Menghitung persentase waktu tersisa (untuk progress circle)
  double _calculateProgress() {
    int totalTimeInSeconds = _totalDurationInMinutes * 60;
    return _remainingTimeInSeconds / totalTimeInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    // Konstanta untuk konsistensi
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;
    
    // Mendapatkan ukuran layar untuk responsivitas
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width * 0.43; // Menyesuaikan lebar card
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan greeting animasi shimmer dan ikon logout
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Greeting dengan efek shimmer
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return _shimmerGradient.createShader(
                                Rect.fromLTWH(
                                  -_animationController.value * bounds.width * 3,
                                  0,
                                  bounds.width * 3,
                                  bounds.height,
                                ),
                              );
                            },
                            child: Text(
                              'Hi Spheriess!',
                              style: GoogleFonts.roboto(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Warna dasar saat shader applied
                              ),
                            ),
                          );
                        },
                      ),
                      // Icon logout dengan GestureDetector
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const LogoutDialog(),
                          ).then((result) {
                            if (result == true) {
                              // Kembali ke halaman login dengan pop sampai halaman pertama
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            }
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/images/icon_logout.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF27486B), // primary-900
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Card durasi belajar - diperbesarkan dan diperbaiki sesuai desain Figma
                Container(
                  width: double.infinity,
                  height: 210, // Diperbesarkan
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF27486B), // 100%
                        Color(0xFF4C8DD1), // 76%
                      ],
                      stops: [0.0, 0.76],
                    ),
                    borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                  ),
                  child: Row(
                    children: [
                      // Text durasi belajar
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Durasi Belajar',
                              style: GoogleFonts.roboto(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEFF7FF), // primary-50
                              ),
                            ),
                            const SizedBox(height: defaultSpacing),
                            Padding(
                              padding: const EdgeInsets.only(left: defaultSpacing),
                              child: Text(
                                '$_totalDurationInMinutes Menit',
                                style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Timer circle dengan display statis untuk prototype
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background circle
                              CustomPaint(
                                size: const Size(150, 150),
                                painter: StaticCirclePainter(
                                  color: Colors.white.withOpacity(0.5),
                                  strokeWidth: 5.0,
                                ),
                              ),
                              
                              // Progress circle - menggunakan persentase waktu tersisa
                              CustomPaint(
                                size: const Size(150, 150),
                                painter: CountDownPainter(
                                  progress: _calculateProgress(), // Kalkulasi dari state
                                  color: Colors.white,
                                  strokeWidth: 5.0,
                                ),
                              ),
                              
                              // Timer content - menampilkan waktu tersisa
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _formatTime(_remainingTimeInSeconds), // Menampilkan waktu tersisa
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/icon_timer.svg',
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _targetTimeString, // Jam selesai
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: defaultSpacing * 3), // Ditambahkan untuk menurunkan posisi Data sensor
                
                // Data sensor title
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: defaultSpacing),
                  child: Text(
                    'Data sensor',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600, // semibold
                      color: Colors.black,
                    ),
                  ),
                ),
                
                // Sensor cards - Diperbesarkan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Intensitas Cahaya Card
                    Container(
                      width: cardWidth,
                      height: 255, // Diperbesarkan sesuai desain Figma
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFEFF7FF), // 0%
                            Color(0xFFB0D7FF), // 100%
                          ],
                        ),
                        borderRadius: BorderRadius.circular(defaultRadius * 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/icon_light_bulb.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            'Intensitas Cahaya',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.normal, // regular
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            '350 Lux',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600, // semibold
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          // Button Cek Detail yang diperbaiki
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                // Akan diimplementasikan untuk navigasi ke halaman detail
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary900.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(defaultRadius * 0.6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Cek Detail',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Tingkat Kebisingan Card
                    Container(
                      width: cardWidth,
                      height: 255, // Diperbesarkan sesuai desain Figma
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFEFF7FF), // 0%
                            Color(0xFFB0D7FF), // 100%
                          ],
                        ),
                        borderRadius: BorderRadius.circular(defaultRadius * 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/icon_sound_wave.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            'Tingkat Kebisingan',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.normal, // regular
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            '90,5 dB',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600, // semibold
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          // Button Cek Detail yang diperbaiki
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                // Akan diimplementasikan untuk navigasi ke halaman detail
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary900.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(defaultRadius * 0.6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Cek Detail',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Menambahkan space di bagian bawah yang lebih besar
                const SizedBox(height: defaultSpacing * 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Painter untuk lingkaran statis (background)
class StaticCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  
  StaticCirclePainter({
    required this.color,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - (strokeWidth / 2);
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    // Draw background circle
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant StaticCirclePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

// Custom painter untuk lingkaran countdown dengan progress statis
class CountDownPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0 (percentage remaining)
  final Color color;
  final double strokeWidth;
  
  CountDownPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - (strokeWidth / 2);
    
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress; // Progress animation
    
    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CountDownPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}