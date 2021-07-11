import 'package:flutter/cupertino.dart';

abstract class Database{

}
class FireStoreDatabase implements Database{
  FireStoreDatabase({@required this.uid}) : assert(uid!=null);
  final String uid;
}