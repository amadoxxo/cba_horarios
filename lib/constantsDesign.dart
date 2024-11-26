// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names
// Ignora las advertencias sobre el uso completo de valores hexadecimales y nombres de archivos.

import 'package:flutter/material.dart';

// Definición de colores constantes utilizados en el tema de la aplicación.
// Color principal de la aplicación.
const primaryColor = Colors.green;
// Color de fondo personalizado.
const background1 = Color(0xFFFF2F0F2);
// Color claro para botones.
const botonClaro = Color(0xFF00FF00);
// Color oscuro para botones.
const botonOscuro = Color(0xFF008000);
// Color de sombra para botones.
const botonSombra = Color(0xFF32CD32);
// Color secundario de la aplicación.
const secondaryColor = Color(0xFF000000);
// Valor de padding por defecto.
const defaultPadding = 16.0;

// Definición del tema de la aplicación claro.
ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: background1, // Texto o íconos sobre el color primario.
    secondary: secondaryColor, // Color secundario (negro).
    onSecondary: background1, // Texto o íconos sobre el color secundario.
    error: primaryColor,
    onError: background1, // Texto o íconos sobre el color de error.
    surface: background1, // Superficie como tarjetas, fondos de botones.
    onSurface: Colors.black87, // Texto o íconos sobre la superficie.
  ),
  brightness: Brightness.light, // Establece el tema como claro.
  primaryColor: primaryColor, // Establece el color principal.
  canvasColor: secondaryColor, // Establece el color del lienzo.
  // Ignorar el uso de miembros obsoletos, ya que se ha migrado a un nuevo enfoque.
  // ignore: deprecated_member_use
  scaffoldBackgroundColor: Colors.white, // Color de fondo para Scaffold.
  // Definición del tema para el cajón de navegación.
  drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFF2F0F2)), // Tema para el Drawer.
  // Configuración del tema de texto utilizando Google Fonts con el color principal.
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto grande.
    displayMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto mediano.
    displaySmall: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto pequeño.
    headlineLarge: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado grande.
    headlineMedium: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado mediano.
    headlineSmall: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado pequeño.
    titleLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de título grande.
    titleMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de título mediano.
    titleSmall: TextStyle(
        fontFamily: 'Calibri-Italic',
        fontStyle: FontStyle.italic,
        color: Colors.grey), // Estilo de título pequeño e itálico.
    bodyLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto grande.
    bodyMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto mediano.
    bodySmall: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto pequeño.
    labelLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de etiqueta grande.
    labelMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de etiqueta mediana.
    labelSmall: TextStyle(
        fontFamily: 'Calibri-Light',
        fontWeight: FontWeight.w300,
        color: primaryColor), // Estilo de etiqueta pequeña y ligera.
  ),
  // Configuración del tema de botón elevado con el color principal.
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(primaryColor), // Color de fondo del botón.
      foregroundColor:
          WidgetStatePropertyAll(Colors.white), // Color del texto del botón.
    ),
  ),
  // Configuración del tema del checkbox con el color principal.
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return primaryColor; // Color de fondo cuando está seleccionado.
      }
      return Colors.transparent; // Color de fondo cuando no está seleccionado.
    }),
  ),
  // Configuración del tema del botón flotante de acción con colores específicos.
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF2F0F2),
      foregroundColor: primaryColor), // Colores del FAB.
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor), // Color del indicador de progreso.
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor, // Color del cursor de texto.
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // Color del borde cuando no está enfocado.
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // Color del borde cuando está enfocado.
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // Color del borde cuando hay un error.
    ),
  ),
);

/// Asegura que los números tengan al menos dos dígitos.
String twoDigits(int n) => n.toString().padLeft(2, '0');

/// Formatea las fechas y horas, asegurando un formato consistente.
/// Si la fecha y hora no es válida, devuelve 'Fecha inválida'.
String formatFechaHora(String fechaString) {
  try {
    DateTime fecha =
        DateTime.parse(fechaString); // Parsea la fecha desde una cadena.
    return '${twoDigits(fecha.day)}-${twoDigits(fecha.month)}-${fecha.year} ${twoDigits(fecha.hour)}:${twoDigits(fecha.minute)}';
  } catch (e) {
    return '';
  }
}

/// Formatea las fechas, asegurando un formato consistente.
String formatHora(String fechaString) {
  try {
    DateTime fecha =
        DateTime.parse(fechaString); // Parsea la fecha desde una cadena.
    return '${twoDigits(fecha.hour)}:${twoDigits(fecha.minute)}'; // Formatea la fecha devolviendo solo la hora.
  } catch (e) {
    // Si la fecha no es válida, devuelve una cadena vacía.
    return '';
  }
}

/// Formatea las fechas, asegurando un formato consistente.
String formatFecha(String fechaString) {
  try {
    DateTime fecha =
        DateTime.parse(fechaString); // Parsea la fecha desde una cadena.
    return '${twoDigits(fecha.day)}-${twoDigits(fecha.month)}-${fecha.year}'; // Formatea la fecha devolviendo solo la fecha.
  } catch (e) {
    // Si la fecha no es válida, devuelve una cadena vacía.
    return '';
  }
}

/// Construye un botón con los estilos de diseño especificados.
///
/// El parámetro [text] es el texto que se mostrará en el botón.
/// El parámetro [onPressed] es la función que se ejecutará cuando se presione el botón.
///
/// Devuelve un widget [Container] que contiene un widget [Material] con un estilo específico.
Widget buildButton(String text, VoidCallback onPressed) {
  // Contenedor con un ancho fijo de 200 píxeles y una apariencia personalizada
  // con un borde redondeado, un gradiente de colores y una sombra.
  return Container(
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), // Borde redondeado.
      gradient: const LinearGradient(
        colors: [
          botonClaro, // Color claro del gradiente.
          botonOscuro, // Color oscuro del gradiente.
        ],
      ),
      boxShadow: const [
        BoxShadow(
          color: botonSombra, // Color de la sombra.
          blurRadius: 5, // Radio de desfoque de la sombra.
          offset: Offset(0, 3), // Desplazamiento de la sombra.
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent, // Color transparente para el Material.
      child: InkWell(
        onTap: onPressed, // Función de presionar.
        borderRadius: BorderRadius.circular(10), // Radio del borde redondeado.
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 10), // Padding vertical.
          child: Center(
            child: Text(
              text, // Texto del botón.
              style: const TextStyle(
                color: background1, // Color del texto.
                fontSize: 13, // Tamaño de fuente.
                fontWeight: FontWeight.bold, // Peso de fuente.
                fontFamily: 'Calibri-Bold', // Fuente.
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
