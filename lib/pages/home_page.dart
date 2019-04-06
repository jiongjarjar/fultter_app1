import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://ws3.sinaimg.cn/large/005BYqpggy1g1s6ivwscnj30dw06y0tc.jpg',
    'https://ws3.sinaimg.cn/large/005BYqpggy1g1s6ivxtvzj30dw06yjru.jpg',
    'https://ws3.sinaimg.cn/large/005BYqpgly1g1s6ivz3cuj30dw06ydgg.jpg',
    'https://ws3.sinaimg.cn/large/005BYqpgly1g1s6iw00exj30dw06y3z3.jpg',
    'https://ws3.sinaimg.cn/large/005BYqpggy1g1s6iw393dj30dw06yjse.jpg',
  ];
  double _appBarAlpha = 0;
  _onScroll(offset){
    double alpha = offset / 100;
    if(alpha < 0) {
      alpha = 0;
    } else if(alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print(_appBarAlpha);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                    onNotification: (scrollNotification){
                      //只判断滚动，和ListView的时候，才触发滚动监听
                      if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 160.0,
                          child: Swiper(
                            pagination: SwiperPagination(),
                            itemCount: _imageUrls.length,
                            autoplay: true,
                            itemBuilder: (BuildContext content, int index){
                              return Image.network(
                                _imageUrls[index],
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 800,
                          child: Text("洗洗"),
                        )
                      ],
                    )
                )
            ),
            Opacity(
              opacity: _appBarAlpha,
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text('首页'),
                  ),
                ),
              ),
            )
          ],

        )


    );
  }
}
