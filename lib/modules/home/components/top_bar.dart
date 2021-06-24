part of '../home_module.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;

    return SafeArea(
      child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone(
                    height: 18,
                    width: 117,
                    child: StreamsSelector0<String>.value(
                      stream: state._dateTimeText,
                      builder: (_, text, __) => Text(
                        text,
                        key: HomeView.currentDateTextKey,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Bone(
                    height: 18,
                    width: 100,
                    borderRadius: BorderRadius.circular(16),
                    child: Text(
                      AppLocalizations.of(context)!.homeScreenTodayText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                      ),
                    ),
                  )
                ],
              ),
              PlatformButton(
                onPressed: () => state.delegate?.userAvatarDidTap.add(null),
                materialFlat: (_, __) => MaterialFlatButtonData(
                  color: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey,
                  ),
                  width: 36,
                  height: 36,
                  child: Bone(
                    width: 36,
                    height: 36,
                    borderRadius: BorderRadius.circular(18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: StreamsSelector0<UserInfo>.value(
                        stream: state._user,
                        builder: (_, user, __) => Image(
                          key: HomeView.userAvatarImageKey,
                          image: NetworkImage(user.avatarUrl!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
