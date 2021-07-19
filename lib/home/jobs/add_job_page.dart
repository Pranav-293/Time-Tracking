import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
  static Future<void> show(BuildContext context) async{
    await Navigator.of(context).push(
      MaterialPageRoute(builder:(context)=>AddJobPage(),
      fullscreenDialog: true)
    );
  }
}

class _AddJobPageState extends State<AddJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job"),),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget _buildContent() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:_buildForm(),
        ),
      ),
    ),
  );
}

Widget _buildForm() {
  return Form(
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
    ),
    TextFormField(
      decoration: InputDecoration(
        labelText: "Rate per Hour",
      ),
      keyboardType: TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
    ),
  ];
}
