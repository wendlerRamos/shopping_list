import 'package:flutter/material.dart';

class FormSearchList extends StatefulWidget {
  @override
  _FormSearchListState createState() => _FormSearchListState();
}

class _FormSearchListState extends State<FormSearchList> {
  @override
  Widget build(BuildContext context) {
    
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Informe o código da lista',
                labelText: 'Código *',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o código da lista';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                
                color: Color.fromARGB(255, 0, 38, 66),
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Buscando a lista ... ')));
                    
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.orange[50],),
                    Padding(padding: EdgeInsets.only(left: 10.0),),
                    Text('Buscar', style: TextStyle(color: Colors.orange[50]),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
