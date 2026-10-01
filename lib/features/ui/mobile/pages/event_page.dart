import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class EventPage extends StatelessWidget{
  const EventPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.keyboard_arrow_left_rounded),
        ),
        body: Padding(
              padding: EdgeInsetsGeometry.all(15),
              child:  Container(
                padding: EdgeInsets.all(35),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.eventsBackground,
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.eventsHeading),
                  ),

                  Text(
                    'Event Description',
                    style: TextStyle(fontSize: 15, color: AppColors.eventsDescription),
                  ),

                  Text(
                    'Conudcted by-',
                    style: TextStyle(fontSize: 10, color: AppColors.eventsConducted),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ElevatedButton(
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('Confirm Your Registration'),
                                content: const Text('test'),
                                actions: [
                                  TextButton(
                                    onPressed: (){

                                    }, 
                                    child: const Text('No')
                                  ),

                                  TextButton(
                                    onPressed: (){

                                    }, 
                                    child: const Text('Yes')
                                  ),
                                ],
                              );
                            }
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.registerButtonBackground,
                          foregroundColor: AppColors.registerButtonforeground
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        )
                      ),

                    ],
                  )

                ],
              )


            ),
          ),
        
      )
    );
    
  }
}