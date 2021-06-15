part of '../home_module.dart';

class RefreshIndicator extends StatelessWidget {
  const RefreshIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? indicator;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        indicator = PlatformCircularProgressIndicator();
        break;
      default:
        indicator = Theme(
          data: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark)),
          child: const CupertinoActivityIndicator(
            radius: 16,
          ),
        );
    }

    return Container(
      width: 56,
      height: 56,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: indicator,
        ),
      ),
    );
  }
}
