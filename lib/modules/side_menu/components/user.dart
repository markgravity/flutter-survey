part of '../side_menu_module.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_SideMenuViewImplState>()!;

    return StreamsSelector0<UserInfo>.value(
        stream: state._user,
        builder: (_, user, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  user.email!,
                  maxLines: 10,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 8),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey,
                ),
                width: 36,
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image(
                    key: SideMenuView.userAvatarImageKey,
                    image: NetworkImage(user.avatarUrl!),
                  ),
                ),
              )
            ],
          );
        });
  }
}
