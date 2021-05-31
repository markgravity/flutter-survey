part of '../home_module.dart';

class SlideItem extends StatelessWidget {
  final SurveyInfo survey;
  const SlideItem({
    Key? key,
    required this.survey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Bone.hidden(
          child: Image(
            image: NetworkImage(survey.coverImageUrl!),
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
                            variants: const [1, 0.5],
                            child: Text(
                              survey.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                            variants: const [1, 0.5],
                            child: Text(
                              survey.description!,
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
