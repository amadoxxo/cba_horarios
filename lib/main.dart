// ignore_for_file: must_be_immutable
// Desactiva la advertencia de clases inmutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:horarios_cba/Splash/page/SplashScreen.dart';
import 'package:horarios_cba/firebase_options.dart';
import 'package:provider/provider.dart'; // Manejo del estado de la aplicación
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'constantsDesign.dart'; // Diseño de la interfaz
import 'package:flutter/material.dart'; // Biblioteca principal de Flutter
import 'provider.dart'; // Proveedor de estado de la aplicación

// Función principal de la aplicación
void main() async {
  // Asegura que los widgets estén inicializados antes de ejecutar la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase con las opciones predeterminadas para la plataforma actual
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación utilizando `AppProvider` para gestionar el estado
  runApp(const AppProvider(
    child: MyApp(),
  ));
}

// Clase principal que representa la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor con clave opcional

  @override
  Widget build(BuildContext context) {
    final appState = AppState(); // Instancia que gestiona el estado global

    // Proporciona `AppState` a los widgets hijos mediante `ChangeNotifierProvider`
    return ChangeNotifierProvider<AppState>(
      create: (context) => appState,
      // Envuelve el contenido en un `GestureDetector` para manejar la inactividad
      child: GestureDetector(
        behavior: HitTestBehavior.translucent, // Propaga gestos a widgets hijos
        // Reinicia el temporizador de inactividad al tocar la pantalla
        //onTap: () => appState.startInactivityTimer(),
        // Reinicia el temporizador al deslizar la pantalla
        //onPanDown: (_) => appState.startInactivityTimer(),
        // Reinicia el temporizador al arrastrar la pantalla
        //onPanUpdate: (_) => appState.startInactivityTimer(),
        // Reinicia el temporizador al dejar de arrastrar la pantalla
        //onPanEnd: (_) => appState.startInactivityTimer(),
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            SfGlobalLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es'),
          ],
          locale: const Locale('es'),
          title: "Horarios CBA",
          navigatorKey: navigatorKey,
          theme: lightTheme, // Define el tema de la aplicación
          debugShowCheckedModeBanner: false, // Oculta el banner de modo debug
          home: const SafeArea(child: SplashScreen()), // Pantalla de inicio (SplashScreen)
        ),
      ),
    );
  }
}
