import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/alert_exception_dialogue_box.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/services/database.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key,@required this.database}) : super(key: key);
  final Database database;
  @override
  _AddJobPageState createState() => _AddJobPageState();

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context,listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddJobPage(database: database,), fullscreenDialog: true));
  }
}

class _AddJobPageState extends State<AddJobPage> {

  FocusNode _focusNode;

  bool isLoading = false;

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });
    if(_validateAndSaveForm()) {
      try{
        final jobs = await widget.database.streamJobs().first;
        final allJobNames = jobs.map((job) => job.name).toList();
        if(allJobNames.contains(_name)){
          alertExceptionDialogue(
            context: context,
            heading: "Name already used",
            message: "Please choose a different job name",
          );
        }else{
          final job = JobModel(name: _name, ratePerHour: _ratePerHour);
          await widget.database.createJob(job);
          Navigator.pop(context);
        }
      } on FirebaseException catch(e) {
        alertExceptionDialogue(context:context,
        heading: "Operation failed",
        message: e.toString());
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

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
      child: AbsorbPointer(
        absorbing: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _formItems(),
        ),
      ),
    );
  }

  List<Widget> _formItems() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: "Job name",
        ),
        autofocus: true,
        onSaved: (name)=>_name = name,
        validator:(value)=>value.isNotEmpty?null:"Name can\'t be empty",
        onEditingComplete:()=> _focusNode.requestFocus(),
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Rate per Hour",
        ),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSaved: (rate)=>_ratePerHour= int.tryParse(rate) ?? 0,
        focusNode: _focusNode,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}
