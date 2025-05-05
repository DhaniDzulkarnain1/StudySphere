import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';
import 'package:studysphere/app/theme/app_theme.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Konstanta untuk konsistensi
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Illustration
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                  width: size.width,
                  height: 312,
                  child: Image.asset(
                    'assets/images/study_illustration.png',
                    fit: BoxFit.contain,
                  ),
                ),
                
                // Welcome Text
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: defaultPadding, bottom: defaultSpacing),
                  child: Text(
                    "Selamat Datang!",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Description
                Container(
                  margin: const EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultSpacing * 4,
                  ),
                  width: double.infinity,
                  child: Text(
                    "Kendalikan Pencahayaan, Kebisingan, dan Durasi Belajar dalam Satu Aplikasi",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                
                // Register Button
                Container(
                  margin: const EdgeInsets.only(bottom: defaultSpacing),
                  width: 216,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman register
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => 
                              const RegisterScreen(),
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: Center(
                      child: Text(
                        "Daftar",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Login Button
                Container(
                  margin: const EdgeInsets.only(bottom: defaultSpacing * 2),
                  width: 216,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigasi ke login screen dengan animasi yang sama seperti dari splash
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => 
                              const LoginScreen(),
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
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppTheme.primary400,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Center(
                      child: Text(
                        "Masuk",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}