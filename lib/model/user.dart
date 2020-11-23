import 'dart:convert';

class User{
   int userId;
   String title;
   String body;

   User({this.userId, this.title, this.body});

   factory User.fromJson(Map<String, dynamic> js) {
     return User(userId: js['userId'], title: js['title'], body: js['body']);
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = Map();
     data['userId'] = this.userId;
     data['title'] = this.title;
     data['body'] = this.body;
     return data;
   }

   List<User> parseUser(String res){
     var parse = json.decode(res).cast<Map<String, dynamic>>();
     return parse.map<User>((json) => User.fromJson(json)).toList();
   }
}