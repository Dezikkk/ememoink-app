import 'package:flutter/material.dart';

Widget buildListContainer({
  required ThemeData theme,
  required int itemCount,
  required Widget Function(int index) itemBuilder,
}) {
  return Container(
    decoration: BoxDecoration(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAlias,
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const Divider(
        height: 0.0,
        thickness: 0.0,
        indent: 20.0,
        endIndent: 20.0,
      ),
      itemBuilder: (_, index) => itemBuilder(index),
    ),
  );
}
