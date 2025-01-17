import 'package:flutter/material.dart';

import '../../../../core/helpers/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        title: 'Ticket Support',
        actions: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {},
        ),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
