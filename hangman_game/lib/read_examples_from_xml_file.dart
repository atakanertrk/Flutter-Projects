import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';
import 'dart:async';

class Example{
  String _question,_answer;
  Example(this._question,this._answer);
  factory Example.fromXML(Map<String,String> xml){
    if(xml == null){
      return null;
    }else{
      return Example(xml["question"],xml["answer"]);
    }
  }
  get question => this._question;
  get answer => this._answer;
}

Future<Example> GetSpecifiedExample(BuildContext context, int level, String lang) async {
  print(lang);
  String path = "assets/xmlfiles/examples" + lang + ".xml";
  String xmlString = await DefaultAssetBundle.of(context).loadString(path);
  var raw = XmlDocument.parse(xmlString);
  var elements = raw.findAllElements("example${level}");
  var output = elements.map((element){
    return Example(element.findElements("question").first.text,element.findElements("answer").first.text);
  }).toList().first;
  return output;
}