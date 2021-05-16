part of '../survey_questions_module.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        context.findRootAncestorStateOfType<_SurveyQuestionsViewImplState>()!;

    return StreamsSelector0<bool>.value(
      stream: state.isProgressHUDShown,
      builder: (_, isShown, child) => ProgressHUD(
        isShow: isShown,
        child: child!,
      ),
      child: Screen(
        body: Stack(
          children: [
            StreamsSelector0<List<SurveyQuestionInfo>>.value(
              stream: state._questions,
              builder: (_, questions, __) => CarouselSlider.builder(
                itemCount: questions.length,
                itemBuilder: (_, i, __) =>
                    Slide(questions: questions, index: i),
                carouselController: state._carouselController,
                options: CarouselOptions(
                  height: double.infinity,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
              ),
            ),
            SafeArea(
              child: NavigationBar(
                key: state._navigationBarKey,
                isBackButtonHidden: true,
                leftChildren: [
                  PlatformButton(
                    onPressed: () =>
                        state.delegate?.closeButtonDidTap.add(null),
                    child: Assets.images.navCloseButton.svg(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
