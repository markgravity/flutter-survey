part of '../home_module.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;

    return StreamsSelector0<bool>.value(
      stream: state.isProgressHUDShown,
      builder: (_, isProgressHUDShown, child) => ProgressHUD(
        isShow: isProgressHUDShown,
        child: child!,
      ),
      child: SliderMenuContainer(
        key: state._sliderMenuContainerKey,
        hasAppBar: false,
        drawerIcon: const SizedBox.shrink(),
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
        sliderMenu: SideMenuModule(),
        sliderMain: StreamsSelector0<bool>.value(
          stream: state._isUserInteractionEnabled,
          builder: (_, isUserInteractionEnabled, child) => IgnorePointer(
            key: HomeView.mainIgnorePointer,
            ignoring: !isUserInteractionEnabled,
            child: child,
          ),
          child: Screen(
            body: SimpleGestureDetector(
              onVerticalSwipe: (direction) {
                if (direction != SwipeDirection.down) return;
                state.delegate?.didSwipeDown.add(null);
              },
              child: Container(
                color: Colors.black,
                child: StreamsSelector0<bool>.value(
                  stream: state._isLoading,
                  builder: (_, isLoading, child) => Skeleton(
                    key: HomeView.skeletonKey,
                    isShown: isLoading,
                    baseColor: Colors.white.withOpacity(0.12),
                    highlightColor: Colors.white.withOpacity(0.5),
                    transition: BoneTransition.none,
                    child: child!,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      StreamsSelector0<List<SurveyInfo>>.value(
                        stream: state._surveys,
                        builder: (_, surveys, __) {
                          return surveys.isNotEmpty
                              ? CarouselSlider.builder(
                                  carouselController: state._pageController,
                                  itemCount: surveys.length,
                                  itemBuilder: (_, index, ___) => SlideItem(
                                    survey: surveys[index],
                                  ),
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      initialPage: state._currentPage.value,
                                      height: double.infinity,
                                      onPageChanged: (index, _) => state
                                          .delegate?.currentPageDidChange
                                          .add(index)),
                                )
                              : SlideItem.empty();
                        },
                      ),
                      const Positioned(
                        left: 20,
                        bottom: 152,
                        child: SafeArea(child: PageControl()),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: TopBar(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
