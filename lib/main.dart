import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer_util.dart';
import 'package:get_it/get_it.dart';

import 'blocs/article_bloc.dart';
import 'screens/articles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: BlocProvider(
                create: (context) => ArticleBloc(),
                child: Articles(
                  title: "News Lounge",
                ),
              ),
            );
          },
        );
      },
    );
  }
}
