import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],

        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Engage'
            , style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold, fontFamily: '', fontSize: 31)
            ),
          ),
        ),


        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              
              

              const Text(
                'Events Activity',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                  
                      ),

                      child: Column(
                        children: [

                          Spacer(),

                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,

                            ),
                                                        
                          ),

                          Spacer(),

                          Text(
                            'Attended',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                          
                            ),
                          ),

                        ]
                      ),

                    ),

                    Spacer(),
                    
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                      color: Colors.white,
                       borderRadius: BorderRadius.circular(5),
                  
                      ),

                      child: Column(
                        children: [

                          Spacer(),

                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,

                            ),
                                                        
                          ),

                          Spacer(),

                          Text(
                            'Registered',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                          
                            ),
                          ),

                        ]
                      ),

                    ),

                    Spacer(),
                    
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                      color: Colors.white,
                       borderRadius: BorderRadius.circular(5),
                  
                      ),

                      child: Column(
                        children: [

                          Spacer(),

                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,

                            ),
                                                        
                          ),

                          Spacer(),

                          Text(
                            'Unregistered',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                          
                            ),
                          ),

                        ]
                      ),

                    ),

                  ],

                    
                ),

              ),

              const Text(
                'Upcoming Events',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                )

              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [

                        Text(
                          'App Design',
                          style: TextStyle(color: Colors.blue, fontSize: 20), 
                        ),

                        SizedBox(height: 4),

                        Text(
                          'This is the descriptions for the event',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),

                      ]

                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        
                      ),
                      child: const Text('Register'),

                    )

                  ],

                ),

              )

            ],

          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add)
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey[10],
          selectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.upcoming),
              label: 'Upcoming Events',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),

      ),
    );
  }
}