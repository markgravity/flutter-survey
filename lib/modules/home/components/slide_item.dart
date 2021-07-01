part of '../home_module.dart';

class SlideItem extends StatelessWidget {
  final SurveyInfo? survey;
  bool get _isEmptied => survey == null;

  factory SlideItem({
    Key? key,
    required SurveyInfo survey,
  }) {
    return SlideItem._(
      key: key,
      survey: survey,
    );
  }

  factory SlideItem.empty({
    Key? key,
  }) {
    return SlideItem._(
      key: key,
      survey: null,
    );
  }

  const SlideItem._({
    Key? key,
    required this.survey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;
    return Stack(
      fit: StackFit.expand,
      children: [
        Bone.hidden(
          child: _isEmptied
              ? const SizedBox.shrink()
              : Image(
                  key: HomeView.backgroundImageSlideItemKey,
                  image: NetworkImage(survey!.coverImageUrl!),
                  fit: BoxFit.cover,
                ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
                height: 126,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Bone.multiple(
                            number: 2,
                            height: 18,
                            borderRadius: BorderRadius.circular(16),
                            variants: const [1, 0.5],
                            child: Text(
                              survey?.title ?? "",
                              key: HomeView.titleTextSlideItemKey,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Bone.multiple(
                            number: 2,
                            height: 18,
                            borderRadius: BorderRadius.circular(16),
                            variants: const [1, 0.5],
                            child: Text(
                              survey?.description ?? "",
                              key: HomeView.descriptionTextSlideItemKey,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PlatformButton(
                      key: HomeView.showDetailButtonKey,
                      onPressed: _isEmptied
                          ? null
                          : () {
                              state.delegate?.showDetailButtonDidTap
                                  .add(survey!);
                            },
                      materialFlat: (_, __) => MaterialFlatButtonData(
                        color: Colors.transparent,
                      ),
                      child: Bone(
                        width: 56,
                        height: 56,
                        borderRadius: BorderRadius.circular(28),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white,
                          ),
                          width: 56,
                          height: 56,
                          child: Assets.images.arrowRightIcon
                              .svg(fit: BoxFit.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
