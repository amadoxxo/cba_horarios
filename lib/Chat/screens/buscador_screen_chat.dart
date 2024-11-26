import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/WidgetsChat/contacts_list.dart';
import 'package:horarios_cba/Models/asignacionCoordinadorModel.dart';
import 'package:horarios_cba/Models/asignacionInstructorModel.dart';
import 'package:horarios_cba/Models/inscripcionAprendizModel.dart';
import 'package:horarios_cba/Models/programacionModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';


// Buscador de contactos.
class BuscadorScreenChat extends StatefulWidget {
  // Variable para almacenar el usuario autenticado.
  final UsuarioModel usuarioAutenticado;
  // Constructor que requiere el usuario autenticado como parámetro.
  const BuscadorScreenChat({super.key, required this.usuarioAutenticado});

  @override
  State<BuscadorScreenChat> createState() => _BuscadorScreenChatState();
}

class _BuscadorScreenChatState extends State<BuscadorScreenChat> {
  // Listas de contactos por cada rol en el aplicativo.
  List<UsuarioModel> contactosAprendices = [];

  List<UsuarioModel> contactosInstructores = [];

  List<UsuarioModel> contactosCoordinadores = [];

  List<UsuarioModel> contactosAdministradores = [];

  @override
  void initState() {
    super.initState();
    // Cargar contactos iniciales
    llamarContactos();
    // Actualizar contactos periodicamente
    actualizarcontactosPeriodicamente();
  }

  // Función para llamar contactos y actualizarlos periodicamente en un intervalo de tiempo
  void actualizarcontactosPeriodicamente() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      llamarContactos();
    }
  }

  // Función para llamar contactos
  Future<void> llamarContactos() async {
    // Verifica el rol del usuario autenticado y llama a la función correspondiente
    // para cargar los contactos en función del rol.
    if (widget.usuarioAutenticado.rol == 'Aprendiz') {
      llamarContactosAprendiz();
    } else if (widget.usuarioAutenticado.rol == 'Instructor') {
      llamarContactosInstructor();
    } else if (widget.usuarioAutenticado.rol == 'Coordinador') {
      llamarContactosCoordinador();
    } else if (widget.usuarioAutenticado.rol == 'Administrador') {
      llamarContactosAdministrador();
    }
  }

  // Función para llamar contactos si el usuario autenticado es aprendiz
  Future<void> llamarContactosAprendiz() async {
    // Obtiene la lista de usuarios, programaciones e inscripciones desde la base de datos
    List<UsuarioModel> usuarios = await getUsuarios();
    List<ProgramacionModel> programaciones = await getProgramaciones();
    List<InscripcionAprendizModel> inscripciones = await getInscripciones();

    // Encuentra las inscripciones del usuario autenticado
    List<InscripcionAprendizModel> inscripcionesAutenticado = inscripciones
        .where((inscripcion) =>
            inscripcion.usuario == widget.usuarioAutenticado.id)
        .toList();

    // Filtra y obtiene los usuarios que son aprendices y están inscritos en las mismas fichas
    contactosAprendices = usuarios
        .where((usuario) =>
            usuario.rol == 'Aprendiz' &&
            usuario.estado &&
            usuario.id != widget.usuarioAutenticado.id &&
            inscripcionesAutenticado.any((inscripcionAutenticado) =>
                inscripciones.any((inscripcion) =>
                    inscripcion.usuario == usuario.id &&
                    inscripcion.ficha.id == inscripcionAutenticado.ficha.id)))
        .toList();

    // Filtra y obtiene los usuarios que son instructores y están asociados a las mismas fichas
    contactosInstructores = usuarios
        .where((usuario) =>
            usuario.rol == 'Instructor' &&
            usuario.estado &&
            programaciones.any((programacion) =>
                programacion.usuario.id == usuario.id &&
                inscripcionesAutenticado.any((inscripcionAutenticado) =>
                    programacion.ficha == inscripcionAutenticado.ficha.id)))
        .toList();

    // Filtra y obtiene los usuarios que son administradores
    contactosAdministradores = usuarios
        .where((usuario) => usuario.rol == 'Administrador' && usuario.estado)
        .toList();

    // Elimina duplicados asegurando que cada usuario aparezca solo una vez en cada lista
    if (mounted) {
      setState(() {
        contactosAprendices = contactosAprendices.toSet().toList();
        contactosInstructores = contactosInstructores.toSet().toList();
        contactosAdministradores = contactosAdministradores.toSet().toList();
      });
    }
  }

  // Función para llamar contactos si el usuario autenticado es instructor
  Future<void> llamarContactosInstructor() async {
    // Obtiene la lista de usuarios, programaciones, inscripciones,
    // asignaciones de instructores y asignaciones de coordinadores desde la base de datos
    List<UsuarioModel> usuarios = await getUsuarios();
    List<ProgramacionModel> programaciones = await getProgramaciones();
    List<InscripcionAprendizModel> inscripciones = await getInscripciones();
    List<AsignacionInstructorModel> asignacionesInstructor =
        await getAsignacionesInstructor();
    List<AsignacionCoordinadorModel> asignacionesCoordinador =
        await getAsignacionesCoordinador();

    // Encuentra las programaciones asociadas al usuario autenticado
    List<ProgramacionModel> programacionesAutenticado = programaciones
        .where((programacion) =>
            programacion.usuario.id == widget.usuarioAutenticado.id)
        .toList();

    // Encuentra las asignaciones de instructor del usuario autenticado
    List<AsignacionInstructorModel> asignacionesAutenticado =
        asignacionesInstructor
            .where((asignacion) =>
                asignacion.usuario.id == widget.usuarioAutenticado.id)
            .toList();

    // Filtra y obtiene los usuarios que son aprendices y están asociados a las mismas fichas
    contactosAprendices = usuarios
        .where((usuario) =>
            usuario.rol == 'Aprendiz' &&
            usuario.estado &&
            programaciones.any((programacion) =>
                programacion.usuario.id == widget.usuarioAutenticado.id &&
                inscripciones.any((inscripcion) =>
                    inscripcion.ficha.id == programacion.ficha &&
                    inscripcion.usuario == usuario.id)))
        .toList();

    // Filtra y obtiene los usuarios que son instructores y están asociados al mismo programa
    // o bajo la misma coordinación
    contactosInstructores = usuarios
        .where((usuario) =>
            usuario.rol == 'Instructor' &&
            usuario.estado &&
            usuario.id != widget.usuarioAutenticado.id &&
            (programaciones.any((programacion) =>
                    programacion.usuario.id == usuario.id &&
                    programacionesAutenticado.any((programacionAutenticado) =>
                        programacionAutenticado.ficha == programacion.ficha)) ||
                asignacionesInstructor.any((asignacion) =>
                    asignacion.usuario.id == usuario.id &&
                    asignacionesAutenticado.any((asignacionAutenticado) =>
                        asignacionesCoordinador.any((asignacionCoordinador) =>
                            asignacionAutenticado.programa == asignacionCoordinador.programa.id &&
                            asignacion.programa == asignacionCoordinador.programa.id)))))
        .toList();

    // Filtra y obtiene los usuarios que son coordinadores y están asociados al mismo programa
    contactosCoordinadores = usuarios
        .where((usuario) =>
            usuario.rol == 'Coordinador' &&
            usuario.estado &&
            (asignacionesInstructor.any((asignacion) =>
                    asignacion.usuario.id == widget.usuarioAutenticado.id &&
                    asignacionesCoordinador.any((asignacionCoordinador) =>
                        asignacionCoordinador.programa.id == asignacion.programa &&
                        asignacionCoordinador.usuario == usuario.id)) ||
                programaciones.any((programacion) =>
                    programacion.usuario.id == widget.usuarioAutenticado.id &&
                    asignacionesCoordinador.any((asignacion) =>
                        asignacion.usuario == usuario.id &&
                        programacion.planeacion.resultadoAprendizaje.competencia
                                .programa.id ==
                            asignacion.programa.id))))
        .toList();

    // Filtra y obtiene los usuarios que son administradores
    contactosAdministradores = usuarios
        .where((usuario) => usuario.rol == 'Administrador' && usuario.estado)
        .toList();

    // Elimina duplicados asegurando que cada usuario aparezca solo una vez en cada lista
    if (mounted) {
      setState(() {
        contactosAprendices = contactosAprendices.toSet().toList();
        contactosInstructores = contactosInstructores.toSet().toList();
        contactosCoordinadores = contactosCoordinadores.toSet().toList();
        contactosAdministradores = contactosAdministradores.toSet().toList();
      });
    }
  }

  // Función para llamar contactos si el usuario autenticado es coordinador
  Future<void> llamarContactosCoordinador() async {
    // Obtiene la lista de usuarios, programaciones, asignaciones de instructores
    // y asignaciones de coordinadores desde la base de datos
    List<UsuarioModel> usuarios = await getUsuarios();
    List<ProgramacionModel> programaciones = await getProgramaciones();
    List<AsignacionInstructorModel> asignacionesInstructor =
        await getAsignacionesInstructor();
    List<AsignacionCoordinadorModel> asignacionesCoordinador =
        await getAsignacionesCoordinador();

    // Filtra y obtiene los usuarios que son instructores y están asociados al mismo programa
    // o bajo la misma coordinación
    contactosInstructores = usuarios
        .where((usuario) =>
            usuario.rol == 'Instructor' &&
            usuario.estado &&
            (asignacionesInstructor.any((asignacion) =>
                    asignacion.usuario.id == usuario.id &&
                    asignacionesCoordinador.any((asignacionCoordinador) =>
                        asignacionCoordinador.programa.id ==
                            asignacion.programa &&
                        asignacionCoordinador.usuario ==
                            widget.usuarioAutenticado.id)) ||
                programaciones.any((programacion) =>
                    programacion.usuario.id == usuario.id &&
                    asignacionesCoordinador.any((asignacion) =>
                        asignacion.usuario == widget.usuarioAutenticado.id &&
                        programacion.planeacion.resultadoAprendizaje.competencia
                                .programa.id ==
                            asignacion.programa.id))))
        .toList();

    // Filtra y obtiene los usuarios que son coordinadores
    contactosCoordinadores = usuarios
        .where((usuario) =>
            usuario.rol == 'Coordinador' &&
            usuario.estado &&
            usuario.id != widget.usuarioAutenticado.id)
        .toList();

    // Filtra y obtiene los usuarios que son administradores
    contactosAdministradores = usuarios
        .where((usuario) => usuario.rol == 'Administrador' && usuario.estado)
        .toList();

    // Elimina duplicados asegurando que cada usuario aparezca solo una vez en cada lista
    if (mounted) {
      setState(() {
        contactosInstructores = contactosInstructores.toSet().toList();
        contactosCoordinadores = contactosCoordinadores.toSet().toList();
        contactosAdministradores = contactosAdministradores.toSet().toList();
      });
    }
  }

  // Función para llamar contactos si el usuario autenticado es administrador
  Future<void> llamarContactosAdministrador() async {
    // Obtiene la lista de usuarios desde la base de datos
    List<UsuarioModel> usuarios = await getUsuarios();

    // Filtra y obtiene los usuarios según su rol
    contactosAprendices = usuarios
        .where((usuario) => usuario.rol == 'Aprendiz' && usuario.estado)
        .toList();

    contactosInstructores = usuarios
        .where((usuario) => usuario.rol == 'Instructor' && usuario.estado)
        .toList();

    contactosCoordinadores = usuarios
        .where((usuario) => usuario.rol == 'Coordinador' && usuario.estado)
        .toList();

    contactosAdministradores = usuarios
        .where((usuario) =>
            usuario.rol == 'Administrador' &&
            usuario.estado &&
            usuario.id != widget.usuarioAutenticado.id)
        .toList();

    // Elimina duplicados asegurando que cada usuario aparezca solo una vez en cada lista
    if (mounted) {
      setState(() {
        contactosAprendices = contactosAprendices.toSet().toList();
        contactosInstructores = contactosInstructores.toSet().toList();
        contactosCoordinadores = contactosCoordinadores.toSet().toList();
        contactosAdministradores = contactosAdministradores.toSet().toList();
      });
    }
  }

  // Función para obtener las pestañas de las listas de contactos según el rol del usuario autenticado.
  List<Tab> getTabs() {
    // Verifica el rol del usuario autenticado y obtiene las pestañas correspondientes
    List<Tab> tabs = [];
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabs.add(const Tab(text: "Aprendices"));
    }
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabs.add(const Tab(text: "Instructores"));
    }
    if (widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabs.add(const Tab(text: "Coordinadores"));
    }
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabs.add(const Tab(text: "Administradores"));
    }
    // retorna las pestañas obtenidas
    return tabs;
  }

  // Función para obtener las vistas de las listas de contactos según el rol del usuario autenticado.
  List<Widget> getTabViews() {
    // Verifica el rol del usuario autenticado y obtiene las vistas correspondientes
    List<Widget> tabViews = [];
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabViews.add(ContactsList(
        contactos: contactosAprendices,
        usuarioAutenticado: widget.usuarioAutenticado,
      ));
    }
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabViews.add(ContactsList(
        contactos: contactosInstructores,
        usuarioAutenticado: widget.usuarioAutenticado,
      ));
    }
    if (widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabViews.add(ContactsList(
        contactos: contactosCoordinadores,
        usuarioAutenticado: widget.usuarioAutenticado,
      ));
    }
    if (widget.usuarioAutenticado.rol == "Aprendiz" ||
        widget.usuarioAutenticado.rol == "Instructor" ||
        widget.usuarioAutenticado.rol == "Coordinador" ||
        widget.usuarioAutenticado.rol == "Administrador") {
      tabViews.add(ContactsList(
        contactos: contactosAdministradores,
        usuarioAutenticado: widget.usuarioAutenticado,
      ));
    }
    // retorna las vistas obtenidas
    return tabViews;
  }

  // Función para construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Listas que contendrán tanto las pestañas como las vistas de las listas de contactos del usuario autenticado.
    List<Tab> tabs = getTabs();
    List<Widget> tabViews = getTabViews();

    
    return SafeArea(
      // Controlador de pestañas
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          // Encabezado de la interfaz de usuario
          appBar: AppBar(
            // Botón de retroceder
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
            ),
            backgroundColor: background1,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: Image.asset('assets/img/logo.png'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const Text(
                  'CBA Mosquera',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: false,
            // Encabezado de la barra de pestañas obtenidas de la función [getTabs]
            bottom: TabBar(
              indicatorColor: primaryColor,
              indicatorWeight: 4,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: tabs, // Pestañas
              dividerColor: Colors.transparent,
            ),
          ),
          // Cuerpo de las vistas de la barra de pestañas obtenidas de la función [getTabViews]
          body: TabBarView(
            children: tabViews, // Vistas de las pestañas
          ),
        ),
      ),
    );
  }
}
