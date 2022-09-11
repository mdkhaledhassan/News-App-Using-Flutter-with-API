import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Data/news_class.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/search_page.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatelessWidget {
  static String routeName = "newsDetails";
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    var currentData =
        Provider.of<NewsProvider>(context).findByDate(date: publishedAt);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${currentData.urlToImage}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Text('${currentData.content}')
          ],
        ),
      ),
    );
  }
}
