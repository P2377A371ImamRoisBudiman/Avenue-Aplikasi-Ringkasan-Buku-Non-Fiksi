import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avenue/controller/con_avenue.dart';
import 'package:avenue/model/model_avenue.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<ModelAvenue>>? getSlider;
  List<ModelAvenue> listSlider = [];

  Future<List<ModelAvenue>>? getPostTerbaru;
  List<ModelAvenue> listPostTerbaru = [];

  @override
  void initState() {
    super.initState();
    getSlider = fetchAvenue(listSlider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: getSlider,
          builder: (BuildContext context,
              AsyncSnapshot<List<ModelAvenue>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  //SLIDER
                  Container(
                    child: FutureBuilder(
                      future: getSlider,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ModelAvenue>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            height: 100,
                            child: Swiper(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        child: Image.network(
                                          listSlider[index].photo,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  //ITEM TERBARU
                  //COMING SOON
                  //CATEGORY
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            }
          },
        )),
      ),
    );
  }
}
