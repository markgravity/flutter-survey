part of '../survey_detail_module.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_SurveyDetailViewImplState>()!;

    return StreamsSelector0<bool>.value(
      stream: state.isProgressHUDShown,
      builder: (_, isShown, child) => ProgressHUD(
        isShow: isShown,
        child: child!,
      ),
      child: Screen(
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamsSelector0<SurveyInfo>.value(
              stream: state._survey,
              builder: (_, survey, __) => Image(
                key: SurveyDetailView.backgroundImageKey,
                image: NetworkImage(survey.coverImageUrl!),
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  NavigationBar(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamsSelector0<SurveyInfo>.value(
                            stream: state._survey,
                            builder: (_, survey, __) => Text(
                              survey.title!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          StreamsSelector0<SurveyInfo>.value(
                            stream: state._survey,
                            builder: (_, survey, __) => Text(
                              survey.description!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 0,
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 140,
                  ),
                  child: Button(
                    key: SurveyDetailView.startSurveyButtonKey,
                    onPressed: () =>
                        state.delegate?.startSurveyButtonDidTap.add(null),
                    title: AppLocalizations.of(context)!
                        .surveyDetailScreenStartSurveyButtonTitle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
