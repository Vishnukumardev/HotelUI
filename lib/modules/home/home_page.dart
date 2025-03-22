import '../../utils/path_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Home  ${controller.value}")),
                ElevatedButton(onPressed: controller.add, child: Text("add"))
              ],
            )));
  }
}
