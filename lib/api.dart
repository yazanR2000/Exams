import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const String baseUrl = "https://ltuc-exams-default-rtdb.firebaseio.com";


// API Class is a Singelton Class
class API{
  static final API _api = API();
  API(){}
  static API getInstance() => _api;
  final List<Exam> _exams = [];
  List<Exam> get exams => _exams;
  Future getExams() async {
    _exams.clear();
    try{
      final response = await http.get(Uri.parse("$baseUrl/Exams.json"));
      final data = json.decode(response.body) as List<dynamic>;
      data.forEach((element) {
        if(element != null){
          _exams.add(Exam(element));
        }
      });
      //print(_exams);
    }catch(err){
      throw "err";
    }
  }
}
class Exam{
  final String subject;
  Exam(this.subject);
  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  bool didIFetchQuestions = false;

  bool checkAnswers = false;

  Future getQuestions() async{
    if(didIFetchQuestions){
      return;
    }
    try{
      _questions.clear();
      final response = await http.get(Uri.parse("$baseUrl/$subject/Questions.json"));
      final data = json.decode(response.body) as List<dynamic>;
      for(int i = 0;i<data.length;i++){
        if(data[i] == null){
          continue;
        }
        _questions.add(Question(i.toString(),data[i], subject));
      }
      _questions.shuffle();
      didIFetchQuestions = true;
    }catch(err){
      throw "err";
    }
  }

}

class Question {
  final String _qId,question,_subject;
  Question(this._qId,this.question,this._subject);

  final List<Map<String,dynamic>> _choices = [];
  List<Map<String,dynamic>> get choices => _choices;

  bool didIFetchChoices = false;
  
  Future getChoices() async {
    if(didIFetchChoices){
      return;
    }
    _choices.clear();
    try{
      final response = await http.get(Uri.parse("$baseUrl/$_subject/Choices/$_qId.json"));
      final data = json.decode(response.body) as Map<String,dynamic>;
      data.forEach((key, value) {
        _choices.add({
          "title" : key,
          "answer" : value
        });
      });
      _choices.shuffle();
      didIFetchChoices = true;
    }catch(err){
      throw "err";
    }
  }
}

class Answer {
  final Question _question;
  int choiceNum = -1;
  Answer(this._question);
}

class ExamAnswers {
  static final ExamAnswers _examAnswers = ExamAnswers();
  ExamAnswers(){}
  static ExamAnswers getInstance() => _examAnswers;

  final List<Answer> _asnwers = [];
  List<Answer> get asnwers => _asnwers;

  int grade = 0;

  void evaluateGrade(){
    for(int i = 0;i<_asnwers.length;i++){
      int choiceNum = _asnwers[i].choiceNum;
      if(choiceNum < 0){
        continue;
      }
      int index = _asnwers[i]._question._choices.indexWhere((element) => element['answer'] == true);
      if(index == choiceNum){
        grade++;
      }
    }
  }

  void clearAswers(){
    grade = 0;
    _asnwers.clear();
  }

  void addAnswer(Answer ans){
    _asnwers.add(ans);
  }
  void deleteAnswer(){
    _asnwers.removeLast();
  }
  void updateAnswer(int choiceNum,int index){
    _asnwers[index].choiceNum = choiceNum;
  }
}