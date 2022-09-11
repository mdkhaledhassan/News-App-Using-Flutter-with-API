import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/home_page.dart';
import 'package:news_app/news_details.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchKeyword = [];
  @override
  Widget build(BuildContext context) {
    final Searchprovider = Provider.of<NewsProvider>(context, listen: false);
    final searchlist = Provider.of<NewsProvider>(context).searchList;
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  onEditingComplete: () {},
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await Searchprovider.getSearchData(
                        query: _searchController.text);
                    searchKeyword.add(_searchController.text);
                    if (searchKeyword.length > 4) {
                      searchKeyword.removeAt(0);
                    }
                  },
                  child: const Text("Search"),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: searchKeyword.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        InkWell(
                            onTap: () async {
                              _searchController.text = searchKeyword[index];
                              await Searchprovider.getSearchData(
                                  query: searchKeyword[index]);
                            },
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(child: Text(searchKeyword[index])),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NewsDetails.routeName,
                            arguments: searchlist[index].publishedAt);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 10),
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
                                                '${searchlist[index].urlToImage}',
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
                                              '${searchlist[index].title}',
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
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
