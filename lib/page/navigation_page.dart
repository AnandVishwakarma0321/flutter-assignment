import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  final String url;
  final String title;
  final String content;
  final String releaseDate;
  const NavigationPage(
      {Key? key,
      required this.url,
      required this.title,
      required this.content,
      required this.releaseDate})
      : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  String query = '';
  String? url;
  String? title;
  String? content;
  String? releaseDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      url = widget.url;
      title = widget.title;
      content = widget.content;
      releaseDate = widget.releaseDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(widget.url, fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.7,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey[800],
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          releaseDate.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         '22 %',
                    //         style: TextStyle(fontSize: 15, color: Colors.white),
                    //       ),
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.2,
                    //       ),
                    //       Text(
                    //         '3 hr, 2 min',
                    //         style: TextStyle(fontSize: 15, color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          content.toString(),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
      // bottomSheet: DraggableScrollableSheet(
      //   builder: (BuildContext context, ScrollController scrollController) {
      //     return Container(
      //       color: Colors.blue[100],
      //       child: ListView.builder(
      //         controller: scrollController,
      //         itemCount: 25,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(title: Text('Item $index'));
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
