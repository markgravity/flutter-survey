part of '../side_menu_module.dart';

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_SideMenuViewImplState>()!;

    return PlatformButton(
      key: SideMenuView.logoutButtonKey,
      onPressed: () => state.delegate?.logoutButtonDidTap.add(null),
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        AppLocalizations.of(context)!.sideMenuLogoutButtonTitle,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
