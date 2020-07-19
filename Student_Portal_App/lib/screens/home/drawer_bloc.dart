import 'package:bloc/bloc.dart';
import 'package:flutter_app/screens/home/registeredcourses.dart';
import 'package:flutter_app/screens/home/timetable.dart';
import 'package:flutter_app/screens/home/userprofile.dart';
import 'package:flutter_app/screens/home/notifications.dart';

import 'chat.dart';
import 'findpeople.dart';
import 'friendlist.dart';

enum DrawerEvents {
  ProfileEvent , NotificationEvent , RegisteredCourses , TimeTable , Chat,
  FindPeople , FriendList , 
}

abstract class DrawerStates{}

class DrawerBloc extends Bloc<DrawerEvents,DrawerStates>{

  DrawerStates get initialState => UserProfileScreen() ;
  
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async*{
    switch(event) {
      case DrawerEvents.ProfileEvent:
        yield UserProfileScreen();
        break;
      case DrawerEvents.Chat:
        yield ChatScreen();
        break;
      case DrawerEvents.FindPeople:
        yield FindPeopleScreen();
        break;
      case DrawerEvents.FriendList:
        yield FriendListScreen();
        break;
      case DrawerEvents.NotificationEvent:
        yield NotificationsScreen();
        break;
      case DrawerEvents.RegisteredCourses:
        yield RegisteredCoursesScreen();
        break;
      case DrawerEvents.TimeTable:
        yield TimeTableScreen();
        break;

    }

  }
}