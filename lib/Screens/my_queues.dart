import 'package:digiq/MyProfileModel/profilemodel.dart';
import 'package:digiq/PostServices/post_services.dart';
import 'package:digiq/MyProfileModel/singlequeuemodel.dart';
import 'package:digiq/GetServices/twilio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Constants/constants.dart';
import '../GetServices/get_services.dart';
import 'package:google_fonts/google_fonts.dart';
class MyQueues extends StatefulWidget {
  const MyQueues({Key? key}) : super(key: key);

  @override
  _MyQueuesState createState() => _MyQueuesState();
}

class _MyQueuesState extends State<MyQueues> {
  PostServices p1 = PostServices();
  GetServices g1 = GetServices();
  TwilioService t1 = TwilioService();
  void changePage(int index){
    setState(() {
      if(index == 1){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/myqueues', (Route<dynamic> route) => false);
      }
      if(index == 0)
      {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/allqueues', (Route<dynamic> route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Created Queues",),
              Tab(text: "Joined Queues",),
            ],
          ),
          title: Text('My Queues'),
        ),
        body: FutureBuilder<MyProfile>(
          future: p1.getJoinedLines("", ""),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.06, left: width * 0.01),
                    child:
                    ListView.builder(
                      shrinkWrap: true,
                                itemCount: snapshot.data!.createdqueues.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text("Queue Name:"+ snapshot.data!.createdqueues[index]['name']
                                                .toString(),style: textStyles.copyWith(fontSize: 20),),
                                            const SizedBox(width: 15,),
                                            IconButton(
                                              icon: const Icon(Icons.info,size: 20,), onPressed: () async{
                                                showModalBottomSheet(context: context, builder: (context){
                                                  return FutureBuilder<SingleQueue>(
                                                    future: g1.getSingleLineInfo(snapshot.data!.createdqueues[index]['id']),
                                                    builder: (context, snapshot) {
                                                      if(snapshot.hasData)
                                                        {
                                                          return Container(
                                                            height: 400,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: [
                                                                      Text(snapshot.data!.name.toString(),style: textStyles.copyWith(fontSize: 30,fontWeight: FontWeight.bold)),
                                                                      Icon(Icons.circle,color: snapshot.data!.isActive?Colors.green:Colors.red)
                                                                    ],
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  ),
                                                                  SizedBox(height:15),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          child: Center(child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(snapshot.data!.tag.toString(),style: textStyles.copyWith(color: Colors.white),),
                                                                          )),
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          color: Colors.black
                                                                        ),
                                                                      ),
                                                                      SizedBox(width:5),
                                                                      Text("#"+ snapshot.data!.id.toString(),style: textStyles.copyWith(fontSize: 20)),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height:15),
                                                                  Text("Estimated Finish Time: "+ snapshot.data!.totalTime.toString(),style: textStyles.copyWith(fontSize: 24)),
                                                                  SizedBox(height:15),
                                                                  ListView.builder(
                                                                      itemBuilder: (context,index){
                                                                    return ListTile(
                                                                        trailing: index*snapshot.data!.timePerUserM==0?Text("Leader",style: textStyles.copyWith(fontSize: 22,color: Color(0xffc1272d))):Text("${index*snapshot.data!.timePerUserM} min",style: textStyles.copyWith(fontSize: 22)),
                                                                        title: index*snapshot.data!.timePerUserM==0?Text( snapshot.data!.users[index].toString(),style: textStyles.copyWith(fontSize: 22,color: Color(0xffc1272d))):Text( snapshot.data!.users[index],style: textStyles.copyWith(fontSize: 22)));
                                                                  },
                                                                    itemCount: snapshot.data!.users.length,
                                                                    shrinkWrap: true,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      return const Center(child: CircularProgressIndicator());
                                                    }
                                                  );
                                                });
                                            },
                                            )
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            MaterialButton(
                                              elevation:5,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              onPressed: ()async {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Please Wait')),
                                                );
                                                bool x = await p1.deleteLine("", snapshot.data!.createdqueues[index]['id']);
                                                if(x){
                                                  Fluttertoast.showToast(msg: "Queue deleted succesfully");
                                                }
                                                setState(() {
                                                  p1.getJoinedLines("", "");
                                                });
                                              },
                                              color: Colors.black,

                                              child: Text("Delete Q",style: textStyles.copyWith(fontSize: 13,color: Colors.white),),
                                            ),
                                            const SizedBox(width: 15,),
                                            MaterialButton(
                                              elevation:5,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              onPressed: ()async {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Please Wait')),
                                                );
                                                    bool x=false;
                                                    if(snapshot.data!.createdqueues[index]['is_active'])
                                                      {
                                                        await p1.deactivateLine("", snapshot.data!.createdqueues[index]['id']);
                                                      }
                                                     else
                                                       {
                                                         await p1.activateLine("", snapshot.data!.createdqueues[index]['id']);
                                                       }
                                                setState(() {
                                                  p1.getJoinedLines("", "");
                                                });
                                                    if(x)
                                                      {
                                                        Fluttertoast.showToast(msg: "Queue deactivated succesfully");
                                                      }
                                              },
                                              color: Colors.black,

                                              child: Text(snapshot.data!.createdqueues[index]['is_active']?"Deactivate Q":"Activate Q",style: textStyles.copyWith(fontSize: 13,color: Colors.white),),
                                            ),
                                            const SizedBox(width: 15,),
                                            InkWell(
                                              onTap: ()async{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Please Wait')),
                                                );
                                                bool x = await p1.goNext("", snapshot.data!.createdqueues[index]['id']);
                                                if(x)
                                                  {
                                                    Fluttertoast.showToast(msg: "Current Person deleted successfully");
                                                  }
                                                else
                                                  {
                                                    Fluttertoast.showToast(msg: "The Queue is empty");
                                                  }
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Center(child:  Text("Next Please",style: textStyles.copyWith(fontSize: 13,color: Colors.white),)),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xffc1272d),
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height:10),
                                    ],
                                  );
                                }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.06, left: width * 0.01),
                    child:
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.activequeues.length,
                        itemBuilder: (context, index) {
                          if(snapshot.data!.nactivequeues>0){
                            if(snapshot.data!.activequeues[index]['position']==1)
                              {
                                print("MIL GAYAAA");
                                if(z==0) {
                                  t1.setAccount();
                                  t1.sendSms(z,
                                      snapshot.data!.activequeues[index]['id'],
                                      snapshot.data!
                                          .activequeues[index]['name']);
                                  z++;
                                }
                              }
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(snapshot.data!.activequeues[index]['name']
                                          .toString(),style: textStyles.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                                      SizedBox(width: 5,),
                                      Text('#'+snapshot.data!.activequeues[index]['id'].toString(),style: textStyles.copyWith(fontSize: 20,fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  trailing: MaterialButton(
                                    elevation:5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    onPressed: ()async{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Please Wait')),
                                      );
                                      await p1.leaveQ("", snapshot.data!.activequeues[index]['id']);
                                      setState(() {
                                        p1.getJoinedLines("", "");
                                      });
                                    },
                                    color: Colors.black,
                                    child: const Text("Leave Q",style: TextStyle(color: CupertinoColors.white),),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text("My Position: "+ snapshot.data!.activequeues[index]['position'].toString()
                                        .toString(),style: textStyles.copyWith(fontSize: 14)),
                                      SizedBox(width: 5,),
                                      Icon(Icons.timer,size: 20,),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.activequeues[index]['time'].toString()+' min',style: textStyles.copyWith(fontSize: 14))
                                    ],
                                  ),
                                ),
                                SizedBox(height:10),
                              ],
                            );
                            return Center(child: const Text("You are not joined in any Queue",style: TextStyle(color: Colors.black),),);
                          }
                          else if(snapshot.data?.nactivequeues==0){
                            return Center(child: const Text("You are not joined in any Queue",style: TextStyle(color: Colors.black),),);
                          }
                              return Center(child: CircularProgressIndicator(),);
                        }),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:idx,
          onTap: (val){
            idx =val;
            changePage(idx);
          },
          iconSize: 35,
          selectedItemColor: Color(0xffc1272d),
          unselectedItemColor: Colors.white,
          backgroundColor:Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:Icon(FontAwesomeIcons.users),
              label: 'All Queues',
            ),



            BottomNavigationBarItem(

              icon: Icon(FontAwesomeIcons.userCheck),
              label: 'My Queues',
            )
          ],

        ),
      ),
    );
  }
}
