import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/alert_exception_dialogue_box.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/services/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key,@required this.database, this.job}) : super(key: key);
  final JobModel job;
  final Database database;
  @override
  _EditJobPageState createState() => _EditJobPageState();

  static Future<void> show(BuildContext context, {JobModel job}) async {
    final database = Provider.of<Database>(context,listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditJobPage(database: database, job: job,), fullscreenDialog: true));
  }
}

class _EditJobPageState extends State<EditJobPage> {

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
        if(widget.job!=null){
          allJobNames.remove(widget.job.name);
        }
        if(allJobNames.contains(_name)){
          alertExceptionDialogue(
            context: context,
            heading: "Name already used",
            message: "Please choose a different job name",
          );
        }else{
          String _jobId = widget.job!=null? widget.job.id : DateTime.now().toIso8601String();
          final job = JobModel(name: _name, ratePerHour: _ratePerHour,id: _jobId);
          await widget.database.setJob(job);
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
    if(widget.job!=null){
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job==null?"Add Job":"Edit Job"),
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
        initialValue: _name,
        autofocus: true,
        onSaved: (name)=>_name = name,
        validator:(value)=>value.isNotEmpty?null:"Name can\'t be empty",
        onEditingComplete:()=> _focusNode.requestFocus(),
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Rate per Hour",
        ),
        initialValue: _ratePerHour!=null ?_ratePerHour.toString():null,
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
