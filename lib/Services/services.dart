// import 'package:http/http.dart' as http;

// import '../Model/usermodel.dart';

// class Services {
//   static const String url = 'https://jsonplaceholder.typicode.com/users';

//   static Future<List<User>> getUsers() async {
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<User> users = userModelFromJson(response.body);
//         return users;
//       }
//       else{
//         return <User>[];
//       }
//     } catch (e) {
//       return <User>[];
//     }
//   }
// }
