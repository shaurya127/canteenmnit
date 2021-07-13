import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();

  String _img = "";
  String _name = "";
  String _price = "";
  String _desc = "";

  String _validateImg(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String _validateName(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String _validatePrice(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  String _validateDesc(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_img);
      print(_name);
      print("$_price Rs.");
      print(_desc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add a dish",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey("img"),
                        decoration: InputDecoration(labelText: "Image URL"),
                        validator: (val) => _validateImg(val),
                        onSaved: (val) => _img = val,
                      ),
                      TextFormField(
                        key: ValueKey("name"),
                        decoration: InputDecoration(labelText: "Name"),
                        textCapitalization: TextCapitalization.words,
                        validator: (val) => _validateName(val),
                        onSaved: (val) => _name = val,
                      ),
                      TextFormField(
                        key: ValueKey("price"),
                        decoration:
                            InputDecoration(labelText: "Price (in Rs.)"),
                        keyboardType: TextInputType.number,
                        validator: (val) => _validatePrice(val),
                        onSaved: (val) => _price = val,
                      ),
                      TextFormField(
                        key: ValueKey("desc"),
                        decoration: InputDecoration(labelText: "Description"),
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        validator: (val) => _validateDesc(val),
                        onSaved: (val) => _desc = val,
                      ),
                      SizedBox(height: 15),
                      RaisedButton(
                        child: Text("Add"),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
