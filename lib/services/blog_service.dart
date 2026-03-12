import 'package:http/http.dart' as http;
import '../configs/app_config.dart';


class BlogService{

  //request in the server via http
  getBlog()async{
  final response=await http.get(Uri.parse('${AppConfig.blogBaseUrl}/articles'),
  headers: {'content-type':'application/json'}
  );
  return response;
  }

}