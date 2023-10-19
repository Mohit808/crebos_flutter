import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'Model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  RxList<Model> list= <Model>[].obs;
  RxBool a=false.obs;
  TextEditingController textEditingControllerTitle=TextEditingController();
  TextEditingController textEditingControllerDesc=TextEditingController();

  String dropdownvalue = '1';
  var items = [
    '1', '2', '3', '4', '5','6','7','8','9','10'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Task"),
      ),
      body:Obx(() => a.value==true?addTaskPage():
      ListView.builder(itemCount: list.length,itemBuilder: (itemBuilder,index){
        return ListTile(title: Text(list[index].title!),
          subtitle: Text(list[index].description!),
          trailing: Text(list[index].priority!.toString()),
        );
      }),),
      floatingActionButton:Obx(() => a.value==true?SizedBox(): FloatingActionButton(onPressed: (){
        a.value=true;
      },child: Icon(Icons.add),)),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  addTaskPage(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(children: [
            Container(padding: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: Colors.grey.withOpacity(.1),borderRadius: BorderRadius.circular(10)),child: TextField(controller: textEditingControllerTitle,decoration: InputDecoration(hintText: "Title...",border: InputBorder.none),)),
            SizedBox(height: 16,),
            Container(padding: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: Colors.grey.withOpacity(.1),borderRadius: BorderRadius.circular(10)),child: TextField(controller: textEditingControllerDesc,minLines: 8,maxLines: 8,decoration: InputDecoration(hintText: "Description...",border: InputBorder.none),)),

            SizedBox(height: 16,),
            Container(padding: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: Colors.grey.withOpacity(.1),borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text("Priority"),
                  SizedBox(width: 16,),
                  DropdownButton(padding: EdgeInsets.all(8),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,),

            Row(
              children: [
                Expanded(child: InkWell(onTap: (){
                  if(textEditingControllerTitle.text.isEmpty || textEditingControllerDesc.text.isEmpty){
                    Fluttertoast.showToast(msg: "Fill All details");
                    return;
                  }
                  a.value=false;
                  Model model=Model(title: textEditingControllerTitle.text,description: textEditingControllerDesc.text,priority: int.parse(dropdownvalue));
                  list.add(model);
                  list.sort((a,b)=>a.priority!.compareTo(b.priority!));
                  list = RxList<Model>(list.toList().reversed.toList());
                },child: Container(padding: EdgeInsets.symmetric(vertical: 12),decoration: BoxDecoration(color: Colors.red.withOpacity(.1),borderRadius: BorderRadius.circular(10)),child: Center(child: Text("Add",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),))))),
              ],
            )
          ],),
        ),
      ),
    );
  }
}
