import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zigy_assignment/createUser.view.dart';
import 'package:zigy_assignment/services/apis/user.api.dart';
import 'package:zigy_assignment/services/models/user.model.dart';
import 'package:zigy_assignment/services/service_locator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ListUserModel _listUserModel = ListUserModel();
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
  }

  void getUserList() async {
    setState(() {
      loading = true;
    });
    try {
      ListUserModel data = await getIt<UserApi>().getListUser();
      setState(() {
        _listUserModel = data;
        loading = false;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      setState(() {
        loading = false;
      });
      FlushbarHelper.createError(
          message: "Something when wrong",
          duration: const Duration(seconds: 3),
          title: "Error")
        ..show(context);

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Zigy"),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => getUserList()),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Visibility(
                  visible: !loading,
                  child: _listUserModel.total == null
                      ? Container()
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _listUserModel.data!.length,
                          itemBuilder: (context, index) =>
                              userWidget(_listUserModel.data![index]))),
              Visibility(
                  visible: loading,
                  child: const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateUserView())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget userWidget(UserModel user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 8,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CachedNetworkImage(
              imageUrl: user.avatar!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12)),
              ),
              placeholder: (context, url) => const SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.firstName!} ${user.lastName!}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(user.email!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 18))
            ],
          ),
        ],
      ),
    );
  }
}
