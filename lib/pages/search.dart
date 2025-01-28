import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(S.of(context).searchTitle));
  }
}
