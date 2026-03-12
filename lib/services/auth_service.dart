import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/app_config.dart';


class AuthService{

  //login
  login(String email,String password)async{
 final response=await http.post(Uri.parse('${AppConfig.authBaseUrl}/auth/login'),
   headers: {'Content-type':'application/json'},
   body: jsonEncode({
     'email':email,
     'password':password,
   })
  );
 return response;
  }


  //register
 register(String email,String name,String password,String avatar)async{
   final response=await http.post(Uri.parse('${AppConfig.authBaseUrl}/users/'),
     headers: {'Content-type':'application/json'},
       body: jsonEncode({
         'email':email,
         'name':name,
         'password':password,
         'avatar':avatar,
       })
   );
   return response;
 }








 //uploadBlog
  uploadBlog(String title,String description,String imageUrl)async{
  final response=await http.post(Uri.parse('${AppConfig.blogBaseUrl}/articles'),
    headers: {
      'Content-type': 'application/json',
      'api-key': AppConfig.blogBaseUrlApiKey,
    },
    body: jsonEncode({
      'article':{
        'title':title,
        'published':true,
        "body_markdown": description,
        "tags": ["flutter", "blogapp"],
        "main_image": imageUrl,
      }
    })
  );
  return response;
  }


 //fetch user post
  fetchPost() async {
    final response = await http.get(
      Uri.parse('${AppConfig.blogBaseUrl}/articles/me'),
      headers: {'Content-type': 'application/json',
        'api-key': AppConfig.blogBaseUrlApiKey,
      },
    );
    return response;
  }


//delete blog
  deleteBlog(int id) async {
    final uri = Uri.https('dev.to', '/api/articles/$id');

    print("Delete url: $uri");

    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'api-key': AppConfig.blogBaseUrlApiKey.trim(),
      },
    );
    return response;
  }


 //update blog
updateBlog(int id,String title,String description,String imageUrl)async{
    final response=await http.put(Uri.parse('${AppConfig.blogBaseUrl}/articles/$id'),
      headers: {
        'Content-Type': 'application/json',
        'api-key': AppConfig.blogBaseUrlApiKey,
      },
      body: jsonEncode({
        'article': {
          'title': title,
          'body_markdown': description,
          'main_image': imageUrl,
        }
      })
    );
    return response;
}





}