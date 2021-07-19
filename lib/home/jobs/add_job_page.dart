import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddJobPage(), fullscreenDialog: true));
  }
}

class _AddJobPageState extends State<AddJobPage> {

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _submit() {
    if(_validateAndSaveForm()){
      print('form is saved with name: $_name and rate: $_ratePerHour');
      //TODO: add the job to the fireStore
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Job"),
        actions: [
          TextButton(onPressed: _submit,
              child: Text(
                "Save", style: TextStyle(fontSize: 20, color: Colors.white),)),
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }


  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _formItems(),
      ),
    );
  }

  List<Widget> _formItems() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: "Job name",
        ),
        onSaved: (name)=>_name = name,
        validator:(value)=>value.isNotEmpty?null:"Name can\'t be empty",
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Rate per Hour",
        ),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (rate)=>_ratePerHour= int.tryParse(rate) ?? 0,
      ),
    ];
  }
}
