import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/dockview.dart';
import '../widgets/dock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color dockBackgroundColor = Colors.black.withOpacity(0.6);

    return Scaffold(
      appBar: null, // No AppBar
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1690743300187-51d68146adf7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 16, // Adjust the bottom margin
              left: 16, // Adjust the left margin
              right: 16, // Adjust the right margin
              child: Consumer<DockViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.items.isEmpty) {
                    viewModel.initializeItems(const [
                      Icons.person,
                      Icons.message,
                      Icons.call,
                      Icons.camera,
                      Icons.photo,
                    ]);
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color:
                          dockBackgroundColor, // Background color for the dock
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Dock(
                        items: viewModel.items,
                        builder: (e) {
                          return Container(
                            constraints: const BoxConstraints(minWidth: 60),
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: e.color,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child:
                                  Icon(e.icon, color: Colors.white, size: 28),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {
                          viewModel.reorderItems(oldIndex, newIndex);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
