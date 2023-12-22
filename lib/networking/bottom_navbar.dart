import 'package:flutter/material.dart';
import 'package:flutter_final/networking/profile.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: currentIndex == 0 ? Colors.blue : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: currentIndex == 1 ? Colors.blue : Colors.grey),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.party_mode,
              color: currentIndex == 2 ? Colors.blue : Colors.grey),
          label: 'Party',
        ),
      ],
      onTap: (index) {
        print('smth tapped');
        ref.read(currentIndexProvider.notifier).state = index;
        print('Index tapped: $index');
        // ref.read(currentIndexProvider.notifier).setIndex(index);

        // if (index == 1) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ProfileScreen()),
        //   );
        // }
      },
    );
  }
}
