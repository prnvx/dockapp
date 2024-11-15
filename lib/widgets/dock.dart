import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/dockitem.dart';

class Dock extends StatelessWidget {
  const Dock({
    super.key,
    required this.items,
    required this.builder,
    required this.onReorder,
  });

  final List<DockItem> items;
  final Widget Function(DockItem) builder;
  final Function(int, int) onReorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final itemWidget = builder(item);
          return Draggable<int>(
            data: index,
            feedback: Material(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: itemWidget,
              ),
            ),
            childWhenDragging: const SizedBox(),
            onDragUpdate: (details) {
              final box = context.findRenderObject() as RenderBox?;
              if (box != null) {
                final localPosition = box.globalToLocal(details.globalPosition);
                final newIndex = _getItemIndexFromPosition(localPosition);
                if (newIndex != index) {
                  onReorder(index, newIndex);
                }
              }
            },
            onDragEnd: (_) {
              // Reordering completed
            },
            child: DragTarget<int>(
              builder: (context, candidateData, rejectedData) {
                return itemWidget;
              },
              onAccept: (draggedIndex) {
                onReorder(draggedIndex, index);
              },
            ),
          );
        }),
      ),
    );
  }

  int _getItemIndexFromPosition(Offset position) {
    double totalWidth = 0.0;
    for (int i = 0; i < items.length; i++) {
      totalWidth += 56; // width of each item
      if (position.dx < totalWidth) {
        return i;
      }
    }
    return items.length - 1;
  }
}
