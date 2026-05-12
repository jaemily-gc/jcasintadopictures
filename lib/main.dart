import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const JCAsintadoApp());
}

class JCAsintadoApp extends StatelessWidget {
  const JCAsintadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JC Asintado Pictures',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String fbUrl = 'https://m.facebook.com/AsintadoPictures';

  Future<void> _openFacebook() async {
    final Uri uri = Uri.parse(fbUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050505), Color(0xFF180000), Color(0xFF050505)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1050),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isMobile = constraints.maxWidth < 850;

                    return isMobile
                        ? Column(
                            children: [
                              _brandSection(),
                              const SizedBox(height: 35),
                              _qrSection(),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: _brandSection()),
                              const SizedBox(width: 45),
                              Expanded(flex: 4, child: _qrSection()),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _brandSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: _glassBox(),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 28),
        _contactSection(),
      ],
    );
  }

  Widget _contactSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'CONNECT WITH US',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.8,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.mail_outline_rounded, color: Colors.white, size: 16),
            ],
          ),

          const SizedBox(height: 18),

          _contactRow(Icons.email_rounded, 'jcasintadopictures@gmail.com'),

          const SizedBox(height: 1.1),

          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _openFacebook,
            child: _contactRow(
              Icons.facebook_rounded,
              'facebook.com/AsintadoPictures',
              isLink: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text, {bool isLink = false}) {
    return _HoverContactRow(icon: icon, text: text, isLink: isLink);
  }

  Widget _qrSection() {
    return Column(
      children: [
        const Text(
          'Tap the QR Code to visit JC Asintado™ Pictures official Facebook page.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
        ),

        const SizedBox(height: 20),

        _HoverFacebookButton(onPressed: _openFacebook),

        const SizedBox(height: 28),

        InkWell(
          onTap: _openFacebook,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _glassBox(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset('assets/qr.jpg', fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _glassBox() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: Colors.white.withOpacity(0.10)),
      boxShadow: [
        BoxShadow(
          color: Colors.redAccent.withOpacity(0.12),
          blurRadius: 35,
          spreadRadius: 2,
        ),
      ],
    );
  }
}

class _HoverContactRow extends StatefulWidget {
  const _HoverContactRow({
    required this.icon,
    required this.text,
    this.isLink = false,
  });

  final IconData icon;
  final String text;
  final bool isLink;

  @override
  State<_HoverContactRow> createState() => _HoverContactRowState();
}

class _HoverContactRowState extends State<_HoverContactRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isLink ? SystemMouseCursors.click : MouseCursor.defer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
            ),
            child: Icon(widget.icon, color: Colors.white, size: 18),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              style: TextStyle(
                color: _isHovered ? Colors.white : Colors.white60,
                fontSize: 15.2,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.45,
                height: 2.15,
              ),
              child: Text(widget.text),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverFacebookButton extends StatefulWidget {
  const _HoverFacebookButton({required this.onPressed});

  final Future<void> Function() onPressed;

  @override
  State<_HoverFacebookButton> createState() => _HoverFacebookButtonState();
}

class _HoverFacebookButtonState extends State<_HoverFacebookButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: const Icon(Icons.facebook),
        label: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          style: TextStyle(
            color: Colors.white,
            fontSize: _isHovered ? 12.6 : 13.2,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          child: const Text('MESSAGE US ON FACEBOOK'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
