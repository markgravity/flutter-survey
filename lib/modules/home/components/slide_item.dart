part of '../home_module.dart';

class SlideItem extends StatelessWidget {
  final SurveyInfo survey;
  final bool _isEmptied;

  const SlideItem({
    Key? key,
    required this.survey,
  })   : _isEmptied = false,
        super(key: key);

  const SlideItem._({
    Key? key,
    required this.survey,
    bool isEmptied = false,
  })  : _isEmptied = isEmptied,
        super(key: key);

  factory SlideItem.empty({
    Key? key,
  }) {
    final survey = SurveyInfo();
    survey.title = "";
    survey.description = "";
    survey.coverImageUrl = "";
    return SlideItem._(
      key: key,
      survey: survey,
      isEmptied: true,
    );
  }

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
                  image: NetworkImage(survey.coverImageUrl!),
                  fit: BoxFit.fill,
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
                              survey.title!,
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
                              survey.description!,
                              key: HomeView.descriptionTextSlideItemKey,
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
                                  .add(survey);
                            },
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
