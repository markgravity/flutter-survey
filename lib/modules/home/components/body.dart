part of '../home_module.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;
    return StreamsSelector0<bool>.value(
      stream: state._isRefreshing,
      builder: (_, isRefresh, child) => Stack(
        children: [
          child!,
          SlideTransition(
            position: state._refreshIndicatorAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const RefreshIndicator(),
                ),
              ),
            ),
          )
        ],
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
                child: child!,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  StreamsSelector0<List<SurveyInfo>>.value(
                    stream: state._surveys,
                    builder: (_, surveys, __) => surveys.isNotEmpty
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
                              onPageChanged: (index, _) => state._currentPage.add(index),
                            ),
                          )
                        : SlideItem.empty(),
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
    );
  }
}
