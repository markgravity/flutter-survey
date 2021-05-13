part of '../survey_detail_module.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: Assets.images.mainBackgroundDimmed,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Column(
              children: [
                NavigationBar(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        const Text(
                          "Working from home Check-In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Text(
                          "We would like to know how you feel about our work from home (WFH) experience.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 17,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 140,
                                ),
                                child: Button(
                                  title: AppLocalizations.of(context)!
                                      .surveyDetailScreenStartSurveyButtonTitle,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
