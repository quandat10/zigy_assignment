import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zigy_assignment/services/models/user.model.dart';

import 'services/apis/user.api.dart';
import 'services/service_locator.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  bool loading = false;

  void createUser() async {
    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> data = {
        "name": _nameController.text,
        "job": _jobController.text
      };

      UserCreateModel user = await getIt<UserApi>().newUserApi(data);

      FlushbarHelper.createSuccess(
          message:
              "A new user was created with id : ${user.id} , name: ${user.name}, job: ${user.job} and created time is ${user.createdAt}",
          duration: const Duration(seconds: 3),
          title: "Create success")
        ..show(context);

      setState(() {
        loading = false;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      setState(() {
        loading = false;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Create new user"),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            createUser();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: loading
                  ? const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Create User",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleText("User name"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.black54,
                cursorWidth: 1,
                cursorHeight: 24,
                obscureText: false,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFF5F5F5),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _titleText("Job title"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _jobController,
                cursorColor: Colors.black54,
                cursorWidth: 1,
                cursorHeight: 24,
                obscureText: false,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFF5F5F5),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  hintText: "Enter your job title",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
    );
  }
}
