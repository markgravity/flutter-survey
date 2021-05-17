part of '../survey_completed_module.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_SurveyCompletedViewImplState>()!;

    return Screen(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                Assets.animations.surveyCompleted,
                key: SurveyCompletedView.lottieKey,
                repeat: false,
                controller: state._animationController,
                onLoaded: (composition) {
                  state._animationController.duration = composition.duration;
                  state.delegate?.animationDidLoad.add(null);
                },
              ),
              StreamsSelector0<SurveyQuestionInfo>.value(
                stream: state._outro,
                builder: (_, outro, __) => Text(
                  outro.content!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
