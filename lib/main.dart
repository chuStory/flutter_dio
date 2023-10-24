import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dio Example',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SafeArea(
        child: MyHomePage(),
      ),
    );
  }
}

// 기본 코드 작성 - 1
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// sub class
class _MyHomePageState extends State<MyHomePage> {
  Dio _dio = Dio();
  List<dynamic> _todos = [];
  // 통신 하기 위해 서버 필요

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  // 비동기 통신 -> Future (GET 요청)
  Future<void> _fetchTodos() async {
    Response response =
    await _dio.get('https://jsonplaceholder.typicode.com/todos');
    print(response.statusCode); // 100, 200, 300, 400, 500 정리 해두기
    print('response.data : ${response.data}');
    print('response.data type check  : ${response.data.runtimeType}');
    _todos = response.data;
  }

  // POST 함수 만들기
  Future<void> _fetchTodoPost() async {}

  // PUT 요청 함수 만들기
  Future<void> _fetchTodoPut() async {}

  // Delete 요청 함수 만들기
  Future<void> _fetchTodoDelete() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text('title : ${_todos[index]['title']}'),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // API 값 확인
                      final postData = {
                        'title': 'A1',
                        "body": 'B1',
                        "userId": index
                      };
                      final url = 'https://jsonplaceholder.typicode.com/posts';
                      // 콜백 메서드르 활용한 예시 코드
                      _dio
                          .post(url,
                          data: postData,
                          options: Options(headers: {
                            'Content-type':
                            'application/json; charset=UTF-8',
                          }))
                          .then((response) {
                        print('res data : ${response.data}');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: Text('post')),
                ElevatedButton(onPressed: () {}, child: Text('put')),
                ElevatedButton(onPressed: () {}, child: Text('delete')),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                print("상세 보기 화면 이동");
              },
              icon: Icon(Icons.add),
            ),
          );
        },
        itemCount: _todos.length,
      ),
    );
  }
}