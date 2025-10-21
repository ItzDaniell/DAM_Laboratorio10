import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contenedor como AppBar (Header de la aplicación)
            Container(
              color: Colors.black,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      // Caja de texto con icono y texto "Hoy"
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo_nav_bar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          HoverButton(
                            text: "Peliculas",
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          HoverButton(
                            text: "Series de TV",
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          HoverButton(
                            text: "Niños y Familia",
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          HoverButton(
                            text: "Marcas",
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          HoverButton(
                            text: "Episodios gratis",
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    HoverButton(
                      text: "Ingresar",
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    HoverButton(
                      text: "Suscribete Ahora",
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          HeroBanner(
            title: 'Los planes empiezan desde S/.13,33/mes',
          ),
          PlanesSection(),
        ],
      ),
      )
    );
  }
}

class HoverButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const HoverButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  Color _adjustHoverColor(Color color, double amount) {
    // Use HSL to change lightness in an accessible way
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final luminance = widget.backgroundColor.computeLuminance();
    // If background is dark, lighten on hover; if light, darken on hover
    final hoverAmount = luminance < 0.5 ? 0.08 : -0.08;
    final targetColor = _isHovered
        ? _adjustHoverColor(widget.backgroundColor, hoverAmount)
        : widget.backgroundColor;

    // For text contrast, try to keep readable color; if background changes enough, recompute
    final textOnTarget = ThemeData.estimateBrightnessForColor(targetColor) ==
            Brightness.dark
        ? Colors.white
        : Colors.black;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: targetColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
          border: Border.all(
            color: widget.backgroundColor == Colors.transparent
                ? Colors.grey
                : widget.backgroundColor.withOpacity(0.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 120),
                style: TextStyle(
                  color: widget.textColor == Colors.transparent
                      ? textOnTarget
                      : widget.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                child: Text(widget.text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroBanner extends StatelessWidget {
  final String title;

  const HeroBanner({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen de fondo
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/series-netflix.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Capa de oscurecimiento
        Container(
          height: 500,
          width: double.infinity,
          color: Colors.black.withOpacity(0.4),
        ),

        // Texto centrado
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Suscribete Ahora',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlanesSection extends StatelessWidget {
  const PlanesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        'titulo': 'Básico con anuncios',
        'precio': '12x S/.13,33 al mes',
        'descripcion': '2 dispositivos a la vez.',
        'color': Colors.grey[200],
      },
      {
        'titulo': 'Estandar',
        'precio': '12x S/.20,83',
        'descripcion': '2 dispositivos a la vez, resolución HD.',
        'color': Colors.amber[100],
      },
      {
        'titulo': 'Platino',
        'precio': '12x S/.27,49',
        'descripcion': '4 dispositivos a la vez, Resolución 4K Ultra HD, Audio Dolby Atmos',
        'color': Colors.blue[100],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Planes disponibles",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: plans.map((plan) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: plan['color'] as Color?,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              plan['titulo'] as String,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              plan['precio'] as String,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              plan['descripcion'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Seleccionar"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
