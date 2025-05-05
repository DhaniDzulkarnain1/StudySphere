import 'package:flutter/material.dart';
import 'package:studysphere/app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math' as math;

class LampPage extends StatefulWidget {
  const LampPage({Key? key}) : super(key: key);

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> with SingleTickerProviderStateMixin {
  // Sensor & lampu state
  bool _isLampOn = false;
  int _currentLux = 383; // Nilai awal intensitas cahaya (data dummy)
  late Timer _sensorTimer;
  
  // Animasi lampu
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup animasi pulse
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    // Timer untuk simulasi pembacaan sensor IoT
    _sensorTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateSensorReading();
    });
    
    // Tentukan status lampu berdasarkan intensitas cahaya awal
    _updateLampStatus();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _sensorTimer.cancel();
    super.dispose();
  }

  // Simulasi pembacaan sensor IoT
  void _updateSensorReading() {
    setState(() {
      // Simulasi fluktuasi nilai sensor (data dummy)
      final random = math.Random();
      
      // Randomly determine if room is bright or dark
      bool isBrightEnvironment = random.nextBool();
      
      if (isBrightEnvironment) {
        // Ruangan terang: 300-500 Lux
        _currentLux = 300 + random.nextInt(200);
      } else {
        // Ruangan gelap: 100-250 Lux
        _currentLux = 100 + random.nextInt(150);
      }
      
      _updateLampStatus();
    });
  }
  
  // Update status lampu berdasarkan intensitas cahaya
  void _updateLampStatus() {
    // Lampu menyala jika intensitas cahaya di bawah threshold
    // Threshold: 250 Lux - di bawah ini lampu akan menyala
    setState(() {
      _isLampOn = _currentLux < 250;
    });
  }

  // Tentukan kategori intensitas cahaya saat ini
  String _getCurrentCategory() {
    if (_currentLux < 300) {
      return "Rendah";
    } else if (_currentLux <= 400) {
      return "Sedang";
    } else {
      return "Tinggi";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definisikan konstanta spacing untuk konsistensi
    const double defaultMargin = 20.0;
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header biru dengan judul Pencahayaan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: defaultPadding),
              color: AppTheme.primary400,
              child: Text(
                "Pencahayaan",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ilustrasi lampu dengan sensor
                    Container(
                      height: 275,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultSpacing),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius * 2),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.primary200,
                            AppTheme.primary300,
                          ]
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // Efek cahaya ketika lampu menyala
                          if (_isLampOn)
                            Positioned(
                              top: 20, // Sesuaikan dengan posisi lampu
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Container(
                                    width: 180 * _pulseAnimation.value,
                                    height: 180 * _pulseAnimation.value,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amber.withOpacity(0.4),
                                          blurRadius: 80,
                                          spreadRadius: 40,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          
                          // Lampu yang lebih cantik
                          Positioned(
                            top: 10, // Posisikan lampu lebih ke atas lagi
                            child: Column(
                              children: [
                                // Tali lampu
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: Colors.brown.shade500,
                                ),
                                
                                // Bagian atas lampu (penggantung)
                                Container(
                                  height: 18,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade800,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Lampu bulat modern
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: _isLampOn ? Colors.amber.shade50 : Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: _isLampOn ? Colors.amber.shade300 : Colors.grey.shade400,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _isLampOn 
                                          ? Colors.amber.withOpacity(0.3) 
                                          : Colors.black.withOpacity(0.1),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _isLampOn ? Icons.light_mode : Icons.light_mode_outlined,
                                      size: 40,
                                      color: _isLampOn ? Colors.amber.shade600 : Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Status lampu diposisikan di bagian bawah dengan jarak yang lebih besar
                          Positioned(
                            bottom: 30, // Kembali ke posisi lebih bawah
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Status Lampu: ${_isLampOn ? 'Hidup' : 'Mati'}!",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Menyesuaikan dengan sensor cahaya",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Card intensitas cahaya saat ini - Dipisah menjadi blok
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultSpacing),
                      padding: const EdgeInsets.symmetric(vertical: defaultSpacing, horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primary400,
                            AppTheme.primary300,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pencahayaan Saat Ini",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "$_currentLux Lux",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Bar indikator cahaya - sebagai blok terpisah
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultSpacing),
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        color: Colors.blue.shade50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tingkat Intensitas",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Progress bar dan indikator
                          Stack(
                            children: [
                              // Background
                              Container(
                                height: 12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              
                              // Progress berdasarkan nilai sensor
                              Container(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 
                                  ((_currentLux - 100) / 400).clamp(0.0, 1.0) * 0.8, // 0.8 faktor untuk margin
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _getCurrentCategory() == "Rendah" 
                                        ? Colors.orange.shade300 
                                        : _getCurrentCategory() == "Sedang"
                                          ? Colors.green.shade400
                                          : Colors.blue.shade400,
                                      _getCurrentCategory() == "Rendah" 
                                        ? Colors.orange.shade500 
                                        : _getCurrentCategory() == "Sedang"
                                          ? Colors.green.shade600
                                          : Colors.blue.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          
                          // Indikator range
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "100",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "300",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "400",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "500",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildIndicator("Rendah", Colors.orange.shade400),
                              _buildIndicator("Sedang", Colors.green.shade500),
                              _buildIndicator("Tinggi", Colors.blue.shade500),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Panduan intensitas cahaya
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultSpacing),
                      child: Column(
                        children: [
                          Text(
                            "Intensitas Cahaya yang\nBaik untuk Belajar",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: defaultSpacing),
                          
                          // Card informasi rentang intensitas
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: defaultSpacing, horizontal: defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(defaultRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Rendah
                                _buildIntensityCategory(
                                  label: "Rendah",
                                  range: "100 - 300\nLUX",
                                  isHighlighted: _getCurrentCategory() == "Rendah",
                                ),
                                
                                // Divider
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                
                                // Sedang
                                _buildIntensityCategory(
                                  label: "Sedang",
                                  range: "301 - 400\nLUX",
                                  isHighlighted: _getCurrentCategory() == "Sedang",
                                ),
                                
                                // Divider
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                
                                // Tinggi
                                _buildIntensityCategory(
                                  label: "Tinggi",
                                  range: "401 - 500\nLUX",
                                  isHighlighted: _getCurrentCategory() == "Tinggi",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Ruang kosong di bawah
                    const SizedBox(height: defaultSpacing * 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget untuk indikator kecil pada bar tingkat intensitas
  Widget _buildIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  
  // Widget untuk kategori intensitas cahaya
  Widget _buildIntensityCategory({
    required String label,
    required String range,
    bool isHighlighted = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
            color: isHighlighted ? AppTheme.primary800 : Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          range,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isHighlighted ? AppTheme.primary800 : Colors.black87,
          ),
        ),
      ],
    );
  }
}