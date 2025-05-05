import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './login_screen.dart';  // Import halaman login
import 'package:studysphere/app/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _deviceCodeController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _deviceCodeController.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Mengosongkan judul agar tidak ada title di AppBar
        title: const Text(''),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/regis.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                
                const SizedBox(height: defaultSpacing * 1.5),
                
                // Register Text
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, bottom: defaultSpacing * 2),
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                
                // Email Field
                buildInputField(
                  context: context,
                  controller: _emailController,
                  hintText: "Masukkan email Anda",
                  labelText: "Email *",
                ),
                
                // Password Field
                buildInputField(
                  context: context,
                  controller: _passwordController,
                  hintText: "Masukkan password Anda",
                  labelText: "Password *",
                  isPassword: true,
                ),
                
                // Device Code Field
                buildInputField(
                  context: context,
                  controller: _deviceCodeController,
                  hintText: "Masukkan kode perangkat",
                  labelText: "Kode Perangkat *",
                ),
                
                // Register Button
                Container(
                  width: double.infinity,
                  height: buttonHeight,
                  margin: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing * 2),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implementasi register
                      _validateAndRegister();
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
                      "Daftar",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // Already have an account
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultSpacing * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman login dengan REPLACEMENT
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Masuk",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    bool isPassword = false,
  }) {
    // Konstanta untuk konsistensi
    const double defaultPadding = 20.0;
    const double defaultSpacing = 15.0;
    const double defaultRadius = 20.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword ? _obscureText : false,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black38,
              ),
              filled: false,
              contentPadding: const EdgeInsets.symmetric(
                vertical: defaultSpacing,
                horizontal: defaultPadding,
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
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _validateAndRegister() {
    // Validasi input
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _deviceCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Semua field harus diisi',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Implementasi logika register
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registrasi berhasil!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: AppTheme.primary500,
      ),
    );
    
    // Navigasi kembali ke halaman login
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}