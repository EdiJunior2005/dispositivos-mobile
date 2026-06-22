import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home_page.dart';
import '../features/detail/detail_page.dart';
import '../features/cart/cart_page.dart';
import '../features/settings/settings_page.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/cart', builder: (_, __) => const CartPage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
        GoRoute(
          path: '/detail/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return DetailPage(id: id);
          },
        ),
      ],
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: location.startsWith('/detail')
          ? null
          : NavigationBar(
              selectedIndex: switch (location) {
                '/cart' => 1,
                '/settings' => 2,
                _ => 0,
              },
              onDestinationSelected: (i) => switch (i) {
                1 => context.go('/cart'),
                2 => context.go('/settings'),
                _ => context.go('/'),
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.storefront_outlined),
                  selectedIcon: Icon(Icons.storefront),
                  label: 'Loja',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: 'Carrinho',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Config',
                ),
              ],
            ),
    );
  }
}
