import 'package:birthday_magic_square/neumorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      );
}

final a = StateProvider<int>((ref) => 0);
final b = StateProvider<int>((ref) => 0);
final c = StateProvider<int>((ref) => 0);
final d = StateProvider<int>((ref) => 0);
final sumProvider = StateProvider<String>((ref) {
  final dd = ref.watch(a);
  final mm = ref.watch(b);
  final yy = ref.watch(c);
  final yY = ref.watch(d);
  return (dd + mm + yy + yY).toString();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Magic Birthday Square'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 100 * 365)),
                        lastDate: DateTime.now());

                    if (picked != null) {
                      ref.read(a.notifier).state = picked.month;
                      ref.read(b.notifier).state = picked.day;
                      ref.read(c.notifier).state =
                          int.parse(picked.year.toString().substring(0, 2));
                      ref.read(d.notifier).state =
                          int.parse(picked.year.toString().substring(2));
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const NeumorphicContainer(text: 'Pick Birthday'))),
              if (ref.watch(sumProvider) != "0") ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 1.0,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: <String>[
                        ///
                        ref.watch(a).toString(),
                        ref.watch(b).toString(),
                        ref.watch(c).toString(),
                        ref.watch(d).toString(),

                        ///
                        (ref.watch(d) + 3).toString(),
                        (ref.watch(c) - 3).toString(),
                        (ref.watch(b) - 1).toString(),
                        (ref.watch(a) + 1).toString(),

                        ///
                        (ref.watch(b) - 2).toString(),
                        (ref.watch(a) + 2).toString(),
                        (ref.watch(d) + 2).toString(),
                        (ref.watch(c) - 2).toString(),

                        ///
                        (ref.watch(c) - 1).toString(),
                        (ref.watch(d) + 1).toString(),
                        (ref.watch(a) - 1).toString(),
                        (ref.watch(b) + 1).toString(),

                        ///
                      ].map((String value) {
                        return GridTile(
                            child: NeumorphicContainer(
                          text: value,
                        ));
                      }).toList()),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Sum of Square : ${ref.watch(sumProvider)}",
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ],
          ),
        ),
      );
}
