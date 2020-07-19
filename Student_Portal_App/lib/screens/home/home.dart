import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enum/user_state.dart';
import 'package:flutter_app/resources/firebase_repo.dart';
import 'package:flutter_app/screens/home/chat.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter_app/screens/home/drawer_item.dart';
import 'package:flutter_app/screens/home/findpeople.dart';
import 'package:flutter_app/screens/home/notifications.dart';
import 'package:flutter_app/screens/home/provider/user_provider.dart';
import 'package:flutter_app/screens/home/registeredcourses.dart';
import 'package:flutter_app/screens/home/timetable.dart';
import 'package:flutter_app/screens/home/userprofile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import 'customappbar.dart';
import 'friendlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
String currentUserid = 'hello';
class _HomeState extends State<Home> with WidgetsBindingObserver {
final FirebaseRepository _repository = FirebaseRepository();
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    final AuthMethods _authMethods = AuthMethods();
  dynamic data;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  UserProvider userProvider;
  Future<dynamic> getData() async {
        final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    final DocumentReference document =   Firestore.instance.collection('users').document(currentUserid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data =snapshot.data;
     });
    });
 }
  
  @override
  void initState(){
    super.initState();
    getData();
     WidgetsBinding.instance.addObserver(this);
    _repository.getCurrentUser().then((user){
      setState(() {
        currentUserid = user.uid;
      });
    });
SchedulerBinding.instance.addPostFrameCallback((_) async {
       SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: currentUserid,
        userState: UserState.Online, 
      );
    });
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online, 
      );
    });
  }
     @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
 

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserid != null
            ? _authMethods.setUserState(
                userId: currentUserid, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserid != null
            ? _authMethods.setUserState(
                userId: currentUserid, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserid != null
            ? _authMethods.setUserState(
                userId: currentUserid, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserid != null
            ? _authMethods.setUserState(
                userId: currentUserid, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }


  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      key: _scaffoldkey ,
      body: Column(
        children: <Widget>[
          BlocBuilder<DrawerBloc,DrawerStates>(
            builder: (context, DrawerStates state) {
              return CustomAppBar(
                childHeight: 0,
                isBig: state is UserProfileScreen ,
                height: (state is UserProfileScreen) ? 190: 120 ,
                title: findSelectedTitle(state),
                trailing: IconButton(
                   icon: Container(
                    child: Center(child: Icon(Icons.menu)),
                    ) , 
                   onPressed: () {
                     _scaffoldkey.currentState.openEndDrawer();
                   
            },
            ),
                
                child: state is UserProfileScreen ? ClipOval(
                 
                ) : null,

                
        
      );
          },


          
          ),
          Expanded(
                child: BlocBuilder<DrawerBloc,DrawerStates>(
              builder: (context, DrawerStates state) {
                return state as Widget;
                
                
            },
            ),
          ),
        ],
      ),
     

 endDrawer: ClipPath(
        clipper: _DrawerClipper(),
        child: Drawer(
          child: SingleChildScrollView(
            child:Container(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  
                  
                  color: Colors.grey[200],
                       child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          data['name'],
                          style: TextStyle(color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          data['id'],
                          style: TextStyle(
                            color: Colors.lightBlue[900],
                            fontSize: 14,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 36,
                        ),
                      ),]
                       ),
                ),
               Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.grey.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.person,
     color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Profile",
                      onPressed: (){
                         Navigator.of(context).pop();
                         BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.ProfileEvent);
                      }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.chat,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:"Chat",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.Chat);
                      }
                      ,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.find_in_page,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Find People",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.FindPeople);
                      }
                      
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.face,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Friend List",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.FriendList);
                      }
                      
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.notifications,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Notifications",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.NotificationEvent);
                      
                      }
                      
                    ),
                  ],
                ),
                Row(
                 children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left:10),
                      
                      child: Icon(
                       
      Icons.note_add,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Registered Courses",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.RegisteredCourses);
                      }
                      
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.table_chart,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Time Table",
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.TimeTable);
                      }
                      
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Icon(
      Icons.power_settings_new,
      color:Color(0XFF6f7e96),
      size: 30.0,
    ),
                    ),DrawerItem(
                      text:" Logout",
                      onPressed: () async {
                        await _auth.signOut();
              
                      }
                      
                    ),
                  ],
                ),
              
            ],),
          ) ,)
        ),
      ),
    );
  }

  String findSelectedTitle(DrawerStates state) {
    if (state is UserProfileScreen){
      return "User Profile";
    }else if (state is ChatScreen){
      return "Chat Box";
    }else if (state is FindPeopleScreen){
      return "Find People";
    }else if (state is FriendListScreen){
      return "Friend List";
    }else if (state is NotificationsScreen){
      return "Notifications";
    }else if (state is RegisteredCoursesScreen){
      return "Registered Courses";
    }else if (state is TimeTableScreen){
      return "Time Table";
    }
    return null;
}

}

  


class _DrawerClipper extends CustomClipper<Path>{
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(0, size.height/2, 0,size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}