import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/auth_form.dart';
import 'package:shopapp/models/auth.dart';
import 'package:shopapp/pages/auth_page.dart';
import 'package:shopapp/pages/products_overview_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}
