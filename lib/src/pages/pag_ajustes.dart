import 'package:flutter/material.dart';
import 'package:preferencias_usuario/src/misWidgets/menu.dart';
import 'package:preferencias_usuario/src/preferencias/usuario.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class PaginaAjustes extends StatefulWidget {
  static final String routeName = 'ajustes';

  @override
  _PaginaAjustesState createState() => _PaginaAjustesState();
}

class _PaginaAjustesState extends State<PaginaAjustes> {
  bool   _colorSecundario;
  int    _genero = 1;
  String _nombre;
  TextEditingController _textControler;
  final preferenciasUsaurio = new PreferenciasUsaurio();
 
  @override ///metodo que se ejecuta apenas se inicializa este estado osea cuando ingresa a esta pagina
  void initState() { 
    super.initState();
    preferenciasUsaurio.lastPage = PaginaAjustes.routeName;
    this._genero = preferenciasUsaurio.genero;
    this._colorSecundario = preferenciasUsaurio.colorSecundario;
    this._nombre = this.preferenciasUsaurio.nombreUsuario;
    //cargarPreferencias();  
    _textControler = new TextEditingController(text: this.preferenciasUsaurio.nombreUsuario);  
  }
  
  /* cargarPreferencias() async{
    SharedPreferences preferencias = await SharedPreferences.getInstance();
    _genero =  preferencias.getInt('genero');
    setState(() {});
  } */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: this.preferenciasUsaurio.colorSecundario ? Colors.teal : Colors.blue[400],
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
              value: _colorSecundario,
              title: Text('Color secundario'),
              onChanged: (value) {
                setState(() {
                  this._colorSecundario = value;
                  this.preferenciasUsaurio.colorSecundario = value;
                });
              }),
          RadioListTile(
              value: 1,
              title: Text('Masculino'),
              groupValue: _genero,
              onChanged: _setSelectedRsdio,
              ),
          RadioListTile(
              value: 2,
              title: Text('Femenino'),
              groupValue: _genero,
              onChanged: _setSelectedRsdio),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textControler,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono '
              ),
              onChanged: (value){
                this.preferenciasUsaurio.nombreUsuario = value;
              },
            ),
          ),

        ],
      ),
    );
  }

  /* Future<void> */ _setSelectedRsdio(int value) async {
  
    this.preferenciasUsaurio.genero = value;
    this._genero = value;
    setState(() {});
  }
}
