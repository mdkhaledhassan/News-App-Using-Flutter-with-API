import 'package:flutter/material.dart';
import 'package:news_app/Data/news_class.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/Service/enum_service.dart';
import 'package:news_app/Service/news_api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/news_details.dart';
import 'package:news_app/search_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  Articles? articles;
  HomePage({this.articles});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Articles> newslist = [];

  dynamic current_index = 1;

  String sortBy = NewsEnum.publishedAt.name;

  // @override
  // void didChangeDependencies() async {
  //   newslist = await NewsApiService().fetchnewsdata();
  //   setState(() {});
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<NewsProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xfffafafa),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'News App',
            style: GoogleFonts.lobster(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current_index > 1) {
                                      current_index--;
                                    } else if (current_index < 1) {
                                      current_index--;
                                    } else {}
                                  });
                                },
                                child: Text('Prev')),
                            SizedBox(
                              width: 10,
                            ),
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      current_index = index + 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 25,
                                      color: current_index == index + 1
                                          ? Color(0xff2196f3)
                                          : Colors.white,
                                      child: Text('${index + 1}'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (current_index < 5) {
                                  current_index++;
                                } else {}
                              });
                            },
                            child: Text('Next'))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: 130,
                        color: Colors.white,
                        child: DropdownButton<String>(
                            value: sortBy,
                            items: [
                              DropdownMenuItem(
                                child: Text(NewsEnum.popularity.name),
                                value: NewsEnum.popularity.name,
                              ),
                              DropdownMenuItem(
                                child: Text(NewsEnum.publishedAt.name),
                                value: NewsEnum.publishedAt.name,
                              ),
                              DropdownMenuItem(
                                child: Text(NewsEnum.relevancy.name),
                                value: NewsEnum.relevancy.name,
                              ),
                            ],
                            onChanged: ((value) {
                              setState(() {
                                sortBy = value!;
                              });
                            })),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: FutureBuilder<List<Articles>>(
                  future: providerData.getNewsData(
                      page: current_index, sortBy: sortBy),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text('Something Wrong'),
                      );
                    }

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, NewsDetails.routeName,
                                arguments: snapshot.data![index].publishedAt);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, right: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${snapshot.data![index].urlToImage}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${snapshot.data![index].title}',
                                                  style: GoogleFonts.nunito(
                                                      color: Color(0xff343434)),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: 10,
                                    width: 70,
                                    color: Color(0xff2196f3),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 10,
                                    width: 70,
                                    color: Color(0xff2196f3),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: 70,
                                    width: 10,
                                    color: Color(0xff2196f3),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 70,
                                    width: 10,
                                    color: Color(0xff2196f3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
