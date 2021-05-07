part of '../home_module.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeViewImplState>()!;
    return Screen(
      body: Container(
        color: Colors.black,
        child: StreamsSelector0<bool>.value(
          stream: state._isLoading,
          builder: (_, isLoading, child) => Skeleton(
            isShown: isLoading,
            baseColor: Colors.white.withOpacity(0.12),
            highlightColor: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            height: 18,
            child: child!,
          ),
          child: Stack(
            children: [
              StreamsSelector0<List<SurveyInfo>>.value(
                stream: state._surveys,
                builder: (_, surveys, __) => CarouselSlider.builder(
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
                ),
              ),
              const Positioned(
                left: 20,
                bottom: 152,
                child: SafeArea(child: PageControl()),
              ),
              const TopBar()
            ],
          ),
        ),
      ),
    );
  }
}
