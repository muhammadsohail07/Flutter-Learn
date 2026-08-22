import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/listview.dart';
import 'Tasks/CounterApp/counterApp.dart';
import 'Tasks/Stack/stack.dart';
import 'Tasks/ProfileUI/ProfileUi.dart';
import 'Tasks/Gallery/gallery.dart';
import 'Tasks/Gallery/PremiumGrid.dart';
import 'Tasks/widgets page.dart';
import 'Tasks/localImage.dart';
import 'Tasks/NetworkImage.dart';
import 'Tasks/cachednetworkImage.dart';
import 'Tasks/LocalFont.dart';
import 'Tasks/JSON/localjson.dart';
import 'Tasks/JSON/onlinejson.dart';
import 'Tasks/Quote App/quoteapp.dart';
import 'Tasks/AudioApp/audioapp.dart';
import 'Tasks/Widgets/drawer.dart';
import 'Tasks/Widgets/bottomnavbar.dart';
import 'Tasks/Widgets/alert .dart';
import 'Tasks/Widgets/contact/contactapp.dart';
import 'Tasks/Widgets/contact/contactform.dart';
import 'Tasks/Widgets/buttons.dart';
import 'Tasks/Widgets/form.dart';
import 'Tasks/Navigation/simplenavigation.dart';
import 'Tasks/Navigation/passingdata.dart';
import 'Tasks/Navigation/product.dart';
import 'Tasks/Navigation/returndata.dart';
import 'Tasks/Navigation/tapbar.dart';
import 'Tasks/ProfileUI/ProfileDetails.dart';
import 'Tasks/Widgets/interestScreen.dart';
import 'package:flutter_series/Tasks/ToDo App/todohome.dart';
import 'package:flutter_series/Tasks/tictactoe/hometictactoe.dart';
import 'package:flutter_series/Tasks/Dark and Light/darkandlight.dart';
import 'package:flutter_series/Tasks/Widgets/simpletextfield.dart';
import 'package:flutter_series/Tasks/Widgets/loginpage.dart';
class TaskItem {
  final String title;
  final Widget page;

  TaskItem({required this.title, required this.page});
}

final List<TaskItem> tasks = [
  TaskItem(title: 'Counter App', page: const CounterApp()),
  TaskItem(title: 'Stack', page: const StackDetails()),
  TaskItem(title: "Profile UI", page: Profileui()),
  TaskItem(title: "Gallery", page: GalleryUI()),
  TaskItem(title: "PremiumGrid", page: PremiumGrid()),
  TaskItem(title: "listview Examples", page: listviewexample()),
  TaskItem(title: "PremiumHomePage", page: PremiumHomePage()),
  TaskItem(title: "Local Image", page: Localimages()),
  TaskItem(title: "Network Image", page: Networkimages()),
  TaskItem(title: " Cached Network Image", page: CachedNetworkimages()),
  TaskItem(title: "Local font", page: Localfont()),
  TaskItem(title: "Local JSON", page: Localjson()),
  TaskItem(title: "Online JSON", page: onlinejson()),
  TaskItem(title: "Quote App", page: Quoteapp()),
  TaskItem(title: "Audio App", page: AudioApp()),
  TaskItem(title: "Drawer", page: MyDrawer()),
  TaskItem(title: "BottomNavBar", page: Bottomnavbar()),
  TaskItem(title: "Alert", page: Alert()),
  TaskItem(title: "Contact App", page: ContactList()),
  TaskItem(title: "Contact Form ", page: ContactFormScreen()),
  TaskItem(title: "Material Button", page: materialButton()),
  TaskItem(title: "Form", page: FormScreen()),
  TaskItem(title: "Navigation", page: MainScreen()),
  TaskItem(title: "Passing Data", page: EnterNameScreen()),
  TaskItem(title: "Product Details", page: HomeProductScreen()),
  TaskItem(title: "Return data", page: PizzaHomeScreen()),
  TaskItem(title: "Tap Bar", page: tapbarScreen()),
  TaskItem(title: "Profile Data", page: ProfileDetailsScreen()),
  TaskItem(title: "interest App", page: InterestScreen()),
  TaskItem(title: "Todo App", page: TodoHomePage()),
  TaskItem(title: "tic tac toe", page: TicTacToeScreen()),
  TaskItem(title: "Dark and Light", page: DarkandLight()),
  TaskItem(title: "signup", page: SignUpForm()),
  TaskItem(title: "Login page", page: SplashDecider())
];