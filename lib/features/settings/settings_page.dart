import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../product/presentation/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider).when(
          data: (value) => value,
          loading: () => false,
          error: (_, __) => false,
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Aparência'),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Modo escuro'),
            value: isDark,
            onChanged: (v) =>
                ref.read(darkModeProvider.notifier).setDarkMode(v),
          ),
          const Divider(),
          const ListTile(
            title: Text('Sobre'),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Ecommerce'),
            subtitle: Text('Versão 1.0.0 · Projeto Flutter'),
          ),
        ],
      ),
    );
  }
}
