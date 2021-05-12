part of '../side_menu_module.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Container(
        color: const Color(0xFF1E1E1E).withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const User(),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                height: 1,
              ),
              const SizedBox(
                height: 35,
              ),
              const Actions(),
            ],
          ),
        ),
      ),
    );
  }
}
