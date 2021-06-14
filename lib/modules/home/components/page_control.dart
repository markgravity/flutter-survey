part of '../home_module.dart';

class PageControl extends StatelessWidget {
  const PageControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;
    return Bone(
      width: 50,
      height: 18,
      borderRadius: BorderRadius.circular(16),
      child: StreamsSelector0<List<SurveyInfo>>.value(
        stream: state._surveys,
        builder: (_, surveys, __) => Row(
          mainAxisSize: MainAxisSize.min,
          children: surveys.asMap().entries.map((entry) {
            return StreamsSelector0<int>.value(
              stream: state._currentPage,
              builder: (_, currentPage, __) => Container(
                key: HomeView.dotPageControlKey,
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.fromLTRB(entry.key == 0 ? 0 : 10, 0, 0, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == entry.key
                      ? HomeView.dotPageControlHighlightColor
                      : HomeView.dotPageControlNormalColor,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
