import 'package:flutter/material.dart';

class my_list extends StatelessWidget {
  final String name, email, url;
  final Function ontap;

  const my_list({
    Key key,
    this.name,
    this.email,
    this.url,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("name : $name"),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url),
        backgroundColor: Colors.orangeAccent,
      ),
      onTap: ontap,
      subtitle: Text("email : $email"),
    );
  }
}
