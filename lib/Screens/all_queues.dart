import 'package:digiq/PostServices/post_services.dart';
import 'package:digiq/MyProfileModel/all_queues_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Constants/constants.dart';
import '../GetServices/get_services.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  GetServices g1= GetServices();
  PostServices p1 = PostServices();

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
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final Color kTextColor = Color(0xffd1c7c6);
  final Color kBaseColor = Color(0xff2b2b2b);

  Icon getIcon(String tag){
    if(tag == 'Shopping') {
      return Icon(FontAwesomeIcons.shoppingCart,color: Colors.white,);
    }
    if(tag =='Restaurant') {
      return Icon(FontAwesomeIcons.utensils,color: Colors.white,);
    }
    if(tag=='Office') {
      return Icon(FontAwesomeIcons.building,color: Colors.white,);
    }
    return Icon(FontAwesomeIcons.user,color: Colors.white,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("All Queues"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: InkWell(
              onTap: ()async{
                await deleteLocalKey('name');
                Fluttertoast.showToast(msg: "Logged Out Successfully");
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
                child: Icon(Icons.exit_to_app,color: Colors.white,)),
          )
        ],
        leading: Container(),
      ),
      floatingActionButton: SpeedDial(
        spaceBetweenChildren: 6,
        spacing: 6,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Color(0xffc1272d),
         icon: FontAwesomeIcons.plus,
        children: [
          SpeedDialChild(
            elevation: 20,
            label: 'Join Line',
            onTap: (){
              Navigator.pushNamed(context, '/joinlines');
            },
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SpeedDialChild(
            onTap: (){
              Navigator.pushNamed(context, '/createline');
            },
            elevation: 20,
              label: "Create Line",
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),
          ),
        ],
      ),
      body: SafeArea(
        child:FutureBuilder<List<AllLines>>(
          future: g1.getAllLines(),
          builder:(context,AsyncSnapshot snapshots){
            print(snapshots.data);
            if(snapshots.hasData) {
              //print('empty');
              return ListView.builder(
                itemCount: snapshots.data.length,
                itemBuilder: (context,index){
                  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
                  String tag=snapshots.data[index]!.tag;
                  //print(tag);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    child: ExpansionTileCard(
                      key: cardA,
                      baseColor: Colors.white,
                      expandedColor: Colors.white,

                      title: Text(snapshots.data[index].name,style: TextStyle(fontSize: 25,color: Colors.black),),
                      subtitle: Text('${snapshots.data[index].city}  #${snapshots.data[index].id}',style: TextStyle(color: Colors.black,fontSize: 16),),
                      trailing:Column(
                        children: [
                          Text(
                            '${snapshots.data[index].count.toString()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),

                          ),
                          Text('In Queue',
                            style: TextStyle(color: Colors.black),),
                        ],
                      ),
                      leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(5),)
                          ),

                          child: getIcon(tag)
                      ),
                      children: [
                        Divider(
                          thickness: 0,
                          height: 10,
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Waiting Time : ${snapshots.data[index].totalTime.toString()} mins',style: TextStyle(color: Colors.black),),
                                SizedBox(
                                  width: 40,
                                ),
                                MaterialButton(
                                  elevation:5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed: ()async{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please Wait')),
                                    );
                                      String x = await p1.ApiJoinLine("", snapshots.data[index].id.toString());
                                      Fluttertoast.showToast(msg: x);
                                      setState(() {
                                        g1.getAllLines();
                                      });
                                  },
                                  color: Colors.green,

                                  child: Text("JOIN LINE",style: TextStyle(color:Colors.white),),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ],

                    ),
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator(),);



              },
            ),

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
    );
  }
}
