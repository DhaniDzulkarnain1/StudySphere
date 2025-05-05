import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './register_screen.dart';  // Import halaman register
import 'package:studysphere/presentation/pages/main/main_screen.dart';  // Import MainScreen untuk navigasi
import 'package:studysphere/app/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Konstanta untuk konsistensi
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;
    const double buttonHeight = 60.0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                
                // Login Image
                Container(
                  width: double.infinity,
                  height: 250,
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/login.png',
                    fit: BoxFit.contain,
                  ),
                ),
                
                // Login Text
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, top: defaultPadding, bottom: defaultSpacing * 2),
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w600, // SemiBold
                      color: Colors.black,
                    ),
                  ),
                ),
                
                // Email Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Masukkan email Anda',
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultSpacing,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password Anda',
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultSpacing,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                            borderSide: BorderSide(color: AppTheme.primary400, width: 1.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Login Button
                Padding(
                  padding: const EdgeInsets.only(top: defaultSpacing * 2, left: defaultPadding, right: defaultPadding, bottom: defaultSpacing),
                  child: SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke MainScreen setelah login
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius * 2.5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        "Masuk",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Implementasi lupa password
                    },
                    child: Text(
                      "Lupa Password?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primary400,
                      ),
                    ),
                  ),
                ),
                
                // Don't have an account
                Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman register dengan REPLACEMENT
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Daftar",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary400,
                          ),
                        ),
                      ),
                    ],
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