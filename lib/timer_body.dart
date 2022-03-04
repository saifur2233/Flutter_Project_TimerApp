import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_timerapp/timer.dart';
import 'package:my_timerapp/timer_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  CountDownTimer work = CountDownTimer(workName: "work", workTime: 30);
  CountDownTimer shortBreak = CountDownTimer(workName: "Short Break", workTime: 5);
  CountDownTimer longBreak = CountDownTimer(workName: "Long Break", workTime: 15);
  List<CountDownTimer> listofCD = [];
  int selectedIndex = 0;

  Future addWorkTimer(BuildContext context){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Add", style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          content: SafeArea(
            child: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      hintText: "Work Name",
                      filled: true,
                      fillColor: Colors.lightBlueAccent,
                      focusColor: Colors.lightBlue
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        hintText: "Work Time in Minutes",
                        filled: true,
                        fillColor: Colors.lightBlueAccent,
                        focusColor: Colors.lightBlue
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Add"),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      }
    );
  }
  @override

  void initState(){
    listofCD = [work, shortBreak,longBreak];

    super.initState();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) {
        return StreamBuilder<TimerModel>(
          stream: listofCD.isNotEmpty ? listofCD[selectedIndex].stream() : null,
          builder: (context, snapshot) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...listofCD.map((CountDownTimer countDown) =>
                              InputChip(
                                onPressed: (){
                                  countDown.startCountDown();
                                  setState(() {
                                    selectedIndex = listofCD.indexWhere((element) => element.workName == countDown.workName && element.workTime == countDown.workTime);
                                  });
                                },
                                label: Text(countDown.workName, style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.pink,
                                onDeleted: (){},
                                deleteIconColor: Colors.white,
                              ),
                          ).toList(),

                          MaterialButton(
                              onPressed: (){
                                addWorkTimer(context);
                              },
                            child: Icon(Icons.add, color: Colors.white,),
                            color: Colors.pink[900],
                          ),
                        ],
                      ),
                    ),
                  ),
                  snapshot.hasData?
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,),
                          child: CircularPercentIndicator(
                            lineWidth: 10.0,
                            center: Text(
                              snapshot.data!.time,
                              style: TextStyle(color: Colors.white,fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            radius: 160,
                            percent: snapshot.data!.percent,
                            progressColor: Colors.pink,
                          ),
                        ),
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,),
                        child: CircularPercentIndicator(
                          lineWidth: 10.0,
                          center: Text(
                            "00:00",
                            style: TextStyle(color: Colors.white,fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          radius: 160,
                          percent: 1,
                          progressColor: Colors.pink,
                        ),
                      ),
                    ),
                  )
                  ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            child: Text("Start",style: TextStyle(fontSize: 20, color: Colors.white),),
                              color: Colors.pink,
                              onPressed: (){
                              listofCD[selectedIndex].start();
                              },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: MaterialButton(
                            child: Text("Restart",style: TextStyle(fontSize: 20, color: Colors.white),),
                            color: Colors.pink,
                            onPressed: (){
                              listofCD[selectedIndex].restart();
                            },
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }
}
