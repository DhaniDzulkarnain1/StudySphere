import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studysphere/app/theme/app_theme.dart';
import 'dart:math' as math;
import 'dart:async';

class NoisePage extends StatefulWidget {
  const NoisePage({Key? key}) : super(key: key);

  @override
  _NoisePageState createState() => _NoisePageState();
}

class _NoisePageState extends State<NoisePage> with TickerProviderStateMixin {
  double _noiseLevel = 45.0;
  String _description = 'Kondusif';
  List<double> _noiseHistory = [];
  late AnimationController _pulseController;
  Timer? _dataTimer;
  String _lastUpdate = 'Baru saja';
  bool _alertShown = false;

  @override
  void initState() {
    super.initState();
    
    // Pulse animation for connection status
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    // Initialize noise history
    _noiseHistory = List.generate(20, (index) => 45.0);
    
    // Start real-time data simulation
    _startRealTimeMonitoring();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dataTimer?.cancel();
    super.dispose();
  }

  void _startRealTimeMonitoring() {
    _dataTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      
      final random = math.Random();
      double fluctuation = (random.nextDouble() * 4) - 2;
      double newNoise = _noiseLevel + fluctuation;
      
      newNoise = newNoise.clamp(30.0, 100.0);
      
      setState(() {
        _noiseLevel = double.parse(newNoise.toStringAsFixed(1));
        _updateNoiseLevel(_noiseLevel);
        
        _noiseHistory.add(_noiseLevel);
        if (_noiseHistory.length > 20) {
          _noiseHistory.removeAt(0);
        }
        
        _lastUpdate = 'Baru saja';
      });
      
      // Show alert if noise level is too high
      if (_noiseLevel > 75 && !_alertShown) {
        _showNoiseAlert();
        _alertShown = true;
      } else if (_noiseLevel <= 75) {
        _alertShown = false;
      }
    });
  }

  void _showNoiseAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        const double defaultRadius = 20.0;
        const double defaultSpacing = 15.0;
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: defaultSpacing),
              Text(
                'Lingkungan Terlalu Bising!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Segera pindah ke ruangan yang lebih tenang untuk pembelajaran optimal.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Mengerti',
                style: GoogleFonts.poppins(
                  color: AppTheme.primary500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateNoiseLevel(double level) {
    if (level <= 55) {
      _description = 'Kondusif';
    } else if (level <= 75) {
      _description = 'Cukup Kondusif';
    } else {
      _description = 'Tidak Kondusif';
    }
  }

  Color _getLevelColor(double level) {
    if (level <= 55) {
      return AppTheme.primary500;
    } else if (level <= 75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Konstanta untuk konsistensi
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with IoT status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: defaultPadding),
              color: AppTheme.primary400,
              child: Text(
                'Kebisingan',
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      // Real-time noise level card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Live noise reading
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  _noiseLevel.toStringAsFixed(1),
                                  style: GoogleFonts.poppins(
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                    color: _getLevelColor(_noiseLevel),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'dB',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: defaultSpacing),
                            
                            // Status indicator
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getLevelColor(_noiseLevel).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(defaultRadius),
                              ),
                              child: Text(
                                _description,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _getLevelColor(_noiseLevel),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 5),
                            
                            Text(
                              'Diperbarui: $_lastUpdate',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: defaultSpacing * 2),
                      
                      // Modern circular progress meter
                      Container(
                        height: 260,
                        width: 260,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(260, 260),
                              painter: CircularMeterPainter(
                                value: _noiseLevel,
                                color: _getLevelColor(_noiseLevel),
                              ),
                            ),
                            // Center content dengan area yang lebih kecil
                            Container(
                              width: 100,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _noiseLevel <= 55 ? Icons.volume_down :
                                    _noiseLevel <= 75 ? Icons.volume_up :
                                    Icons.volume_up_rounded,
                                    size: 28,
                                    color: _getLevelColor(_noiseLevel),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: _getLevelColor(_noiseLevel),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: defaultSpacing * 2),
                      
                      // Real-time graph
                      Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultRadius),
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grafik Real-time (20 detik terakhir)',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary700,
                              ),
                            ),
                            const SizedBox(height: defaultSpacing),
                            SizedBox(
                              height: 120,
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: LineGraphPainter(
                                  data: _noiseHistory,
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('0', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                Text('55', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                Text('75', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                Text('100', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: defaultSpacing * 2),
                      
                      // Quick reference with better explanation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickReference(
                            '0-55 dB',
                            'Ideal',
                            AppTheme.primary500,
                            'Kondisi optimal untuk belajar',
                          ),
                          _buildQuickReference(
                            '56-75 dB',
                            'Waspada',
                            Colors.orange,
                            'Mulai mengganggu konsentrasi',
                          ),
                          _buildQuickReference(
                            '76+ dB',
                            'Bahaya',
                            Colors.red,
                            'Segera pindah ruangan',
                          ),
                        ],
                      ),
                      
                      // Tambahkan margin bawah
                      const SizedBox(height: defaultSpacing * 2),
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

  Widget _buildQuickReference(String range, String label, Color color, String description) {
    const double defaultRadius = 20.0;
    
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            title: Text(
              '$label ($range)',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            content: Text(
              description,
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                label == 'Ideal' ? Icons.check :
                label == 'Waspada' ? Icons.warning :
                Icons.error_outline,
                color: color,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            range,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Circular Meter Painter
class CircularMeterPainter extends CustomPainter {
  final double value;
  final Color color;

  CircularMeterPainter({
    required this.value,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 40),
      -math.pi * 0.75,
      math.pi * 1.5,
      false,
      bgPaint,
    );

    // Value arc
    final valuePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 40),
      -math.pi * 0.75,
      math.pi * 1.5 * (value / 100),
      false,
      valuePaint,
    );

    // Scale marks and labels dengan positioning yang lebih baik
    final markPaint = Paint()
      ..color = Colors.grey[400]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Draw scale marks and labels
    final markers = [0, 55, 75, 100];
    for (var marker in markers) {
      final angle = -math.pi * 0.75 + (math.pi * 1.5 * marker / 100);
      
      // Scale marks
      final markStart = center + Offset(
        (radius - 50) * math.cos(angle),
        (radius - 50) * math.sin(angle),
      );
      final markEnd = center + Offset(
        (radius - 60) * math.cos(angle),
        (radius - 60) * math.sin(angle),
      );

      canvas.drawLine(markStart, markEnd, markPaint);

      // Text labels dengan positioning yang lebih baik
      textPainter.text = TextSpan(
        text: marker.toString(),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      // Posisi teks di luar arc dengan jarak yang cukup
      double textRadius = radius - 20;
      
      // Adjust positioning based on angle
      double adjustedAngle = angle;
      
      // Special positioning untuk angka tertentu
      if (marker == 0) {
        textRadius = radius - 15;
      } else if (marker == 100) {
        textRadius = radius - 15;
        adjustedAngle -= 0.1; // Slight shift to avoid collision
      }
      
      final textPosition = center + Offset(
        textRadius * math.cos(adjustedAngle) - textPainter.width / 2,
        textRadius * math.sin(adjustedAngle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, textPosition);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Line Graph Painter
class LineGraphPainter extends CustomPainter {
  final List<double> data;

  LineGraphPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (var i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Vertical grid lines
    for (var i = 0; i <= 4; i++) {
      final x = size.width * i / 4;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    // Draw line graph
    final linePaint = Paint()
      ..color = AppTheme.primary500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final x = i * size.width / (data.length - 1);
      final y = size.height - (data[i] / 100 * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);

    // Draw safe zone
    final safeZonePaint = Paint()
      ..color = AppTheme.primary500.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, size.height * 0.45, size.width, size.height),
      safeZonePaint,
    );

    // Draw warning zone
    final warningZonePaint = Paint()
      ..color = Colors.orange.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, size.height * 0.25, size.width, size.height * 0.45),
      warningZonePaint,
    );

    // Draw danger zone
    final dangerZonePaint = Paint()
      ..color = Colors.red.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height * 0.25),
      dangerZonePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}