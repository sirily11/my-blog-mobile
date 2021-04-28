import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_blog_app/models/MemoryProvider.dart';
import 'package:my_blog_app/pages/memory/components/MemoryCell.dart';
import 'package:provider/provider.dart';

class MemoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MemoryProvider provider = Provider.of(context);

    return Scrollbar(
      child: EasyRefresh(
        firstRefresh: true,
        firstRefreshWidget: Container(),
        onRefresh: () async {
          await provider.refresh();
        },
        onLoad: provider.nextURL != null
            ? () async {
                await provider.fetchMore();
              }
            : null,
        child: ListView.separated(
            separatorBuilder: (c, i) => Divider(),
            itemCount: provider.memories.length,
            itemBuilder: (context, index) {
              var memory = provider.memories[index];
              return MemoryCell(memory: memory);
            }),
      ),
    );
  }
}
