import 'package:ememoink/ui/tasks/view_model/tasks_view_model.dart';
import 'package:flutter/material.dart';

class SelectionBottomBar extends StatefulWidget {
  final TasksViewModel viewModel;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  final List<MenuItem> menuItems;

  const SelectionBottomBar({
    super.key,
    required this.viewModel,
    required this.menuItems,
    this.onDelete,
    this.onCancel,
  });

  @override
  State<SelectionBottomBar> createState() => _SelectionBottomBarState();
}

class _SelectionBottomBarState extends State<SelectionBottomBar> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.selectedCount == 0) {
      return SizedBox.shrink();
    }

    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: _menuController.isOpen
            ? BorderRadius.only(topLeft: Radius.circular(16.0))
            : BorderRadius.vertical(top: Radius.circular(16.0)),
        color: theme.colorScheme.surfaceContainer,
      ),
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.close), onPressed: widget.onCancel),
            SizedBox(width: 8),
            Text(
              '${widget.viewModel.selectedCount} item selected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete_outline),
              color: Colors.red[800],
              onPressed: widget.onDelete,
            ),
            _buildMenuAnchor(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuAnchor() {
    return MenuAnchor(
      controller: _menuController,
      onOpen: () => setState(() {}),
      onClose: () => setState(() {}),
      alignmentOffset: const Offset(0, 8),
      style: MenuStyle(
        // padding: WidgetStatePropertyAll(EdgeInsets.only(top: 8.0,bottom: 8.0)),
        elevation: WidgetStateProperty.all(0.0),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
      ),
      builder: (_, controller, child) {
        return IconButton(
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: widget.menuItems.map((item) {
        if (item.isSeparator) {
          return const Divider(height: 0, thickness: 0);
        }

        return MenuItemButton(
          leadingIcon: Icon(item.icon),
          onPressed: item.onPressed,
          child: Text(item.label ?? ''),
        );
      }).toList(),
    );
  }
}

class MenuItem {
  final IconData? icon;
  final String? label;
  final VoidCallback? onPressed;
  final bool isSeparator;

  const MenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : isSeparator = false;

  const MenuItem.separator()
    : icon = null,
      label = null,
      onPressed = null,
      isSeparator = true;
}
