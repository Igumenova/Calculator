import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Calc(),
)
);

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}



class _CalcState extends State<Calc> {
  double WidthScreen=0;
  double HeightScreen=0;

  String result="0";
  String input="";

  Widget calcbutton(String btntxt){
    return  SizedBox(
      height:HeightScreen*0.1-5,
      width: WidthScreen/4-5,
      child: TextButton(
        onPressed: (){
          calculation(btntxt);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white12,
          backgroundColor:Colors.white12,
        ),
        child: Text('$btntxt',
          style: const TextStyle(
            fontSize: 35,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    WidthScreen = MediaQuery.of(context).size.width;
    HeightScreen = MediaQuery.of(context).size.height;
    double height=0;
    double width=0;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Калькулятор'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        Row(children: [
          Container(
            height: HeightScreen*0.1,
            width: WidthScreen,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(
              input,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
         ],),
        Row(children: [
          Container(
            height: HeightScreen*0.3,
            width: WidthScreen,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 65,
                color: Colors.white,
              ),
            ),
          ),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [calcbutton('CE')],),
            Column(children: [calcbutton('C')],),
            Column(children: [calcbutton('+/-')],),
            Column(children: [calcbutton('/')],),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [calcbutton('7')],),
            Column(children: [calcbutton('8')],),
            Column(children: [calcbutton('9')],),
            Column(children: [calcbutton('*')],),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [calcbutton('4')],),
            Column(children: [calcbutton('5')],),
            Column(children: [calcbutton('6')],),
            Column(children: [calcbutton('-')],),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [calcbutton('1')],),
            Column(children: [calcbutton('2')],),
            Column(children: [calcbutton('3')],),
            Column(children: [calcbutton('+')],),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [calcbutton('.')],),
            Column(children: [calcbutton('0')],),
            Column(children: [calcbutton('⌫')],),
            Column(children: [calcbutton('=')],),
          ],),
      ]),
    );
  }

  calculation (String text){
    var a;
    var b;
    var c;

    setState(() {
      if (text=="CE"){
        result="0";
      }
      if (text=="C"){
        input="";
        result="0";
      }

      if (double.tryParse(text)!=null || text=='.'){
        if (text=='.' && result.contains('.')!=false){
          return;
        }
        result=result+text;
        if (result.length>18){
          result=result.substring(0, result.length-1);
        }
        if(result[0]=='0' && result[1]!='.'){
          result=result.substring(1);
        }
        if (input.isNotEmpty && input[input.length-1]=="="){
          input='';
          result=text;
        }
      }
      if (text=='+/-'){
        if(result.contains('-')==false && result!='0'){
          result='-' + result;
        }
        else if (result!='0'){
          result=result.substring(1,result.length);
        }
      }
      if (text=='⌫'){
        result=result.substring(0, result.length-1);
        if (result=="") result="0";
      }
      if (text=='-' || text=='+' || text=='/' || text=='*' || text=="=" ){
        if (input.isEmpty || input[input.length-1]=="="){
          input=result+text;
          result='0';
        }
        else if (input.isNotEmpty){
          a=double.tryParse(input.substring(0, input.length-1));
          b=double.tryParse(result);

          if(input.contains('+')){
            c=(a+b).toStringAsFixed((a+b).truncateToDouble() == (a+b) ? 0 : 1); //(a+b).toString()+text
          }
          else if(input.contains('*')){
            c=(a*b).toStringAsFixed((a*b).truncateToDouble() == (a*b) ? 0 : 1); //(a+b).toString()+text
          }
          else if(input.contains('/')){
            c=(a/b).toStringAsFixed((a/b).truncateToDouble() == (a/b) ? 0 : 1); //(a+b).toString()+text
          }
          else if(input.contains('-')){
            c=(a-b).toStringAsFixed((a-b).truncateToDouble() == (a-b) ? 0 : 1); //(a+b).toString()+text
          }

          if (text=="="){
            input=input+result+text;
            result=c.toString();
          }
          else{
            input=c+text;
            result="0";
          }
        }
      }
    });
  }
}


