import 'package:flutter/material.dart';
import 'package:introducing_animations/core/viewmodel/home_viewmodel.dart';
import 'package:introducing_animations/ui/screens/detail.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(this),
      child: Consumer<HomeViewModel>(
        builder: (context, HomeViewModel viewModel, child) =>
            Scaffold(
              appBar: AppBar(
                title: const Text("Animations Demo"),
                actions: [
                  IconButton(
                      onPressed: () async {
                        viewModel.showDurationPopup(context);
                      },
                      tooltip: "Durée",
                      icon: const Icon(Icons.timer)),
                  IconButton(
                      onPressed: () async {
                        viewModel.showCurvesPopup(context);
                      },
                      tooltip: "Courbe",
                      icon: const Icon(Icons.timeline))
                ],
              ),
              body: Stack(
                children: [
                  ListView(
                    children: const [
                      ImplicitAnimationsList(),
                      SizedBox(
                        height: 8,
                      ),
                      ExplicitAnimationController()
                    ],
                  ),
                  const ExplicitAnimation()
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Detail()));
                },
                child: const Icon(Icons.forward),
              ),
            ),
      ),
    );
  }
}

class ImplicitAnimationsList extends StatelessWidget {
  const ImplicitAnimationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, HomeViewModel viewModel, child) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                alignment: Alignment.center,
                child: const Text(
                  "Animations implicites",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedRotation(
                  turns: viewModel.animatedTurns,
                  duration: viewModel.duration,
                  curve: viewModel.curve,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.animateTurns();
                    },
                    child: const Text("AnimatedRotation"),
                  ),
                ),
              ),
              AnimatedPadding(
                duration: viewModel.duration,
                curve: viewModel.curve,
                padding:
                EdgeInsets.symmetric(horizontal: viewModel.animatedPadding),
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.animatePadding();
                  },
                  child: const Text("AnimatedPadding"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedOpacity(
                  opacity: viewModel.animatedOpacity,
                  duration: viewModel.duration,
                  curve: viewModel.curve,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.animateOpacity();
                    },
                    child: const Text("AnimatedOpacity"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedDefaultTextStyle(
                    child: InkWell(
                      onTap: () {
                        viewModel.animateTextStyle();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text("AnimatedDefaultTextStyle")),
                      ),
                    ),
                    style: viewModel.animatedTextStyle,
                    curve: viewModel.curve,
                    duration: viewModel.duration),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedSlide(
                  offset: Offset(viewModel.animatedSlideX, 0),
                  duration: viewModel.duration,
                  curve: viewModel.curve,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.animateSlide();
                    },
                    child: const Text("AnimatedSlide"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    viewModel.animateContainer();
                  },
                  child: AnimatedContainer(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    curve: viewModel.curve,
                    decoration: BoxDecoration(
                        color: viewModel.animatedContainerColor,
                        borderRadius: BorderRadius.circular(
                            viewModel.animatedContainerRadius),
                        border: Border.all(
                            color: viewModel.animatedContainerBorderColor,
                            width: viewModel.animatedContainerBorderWidth)),
                    duration: viewModel.duration,
                    alignment: viewModel.animatedContainerAlignment,
                    child: const Text(
                      "AnimatedContainer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    viewModel.animatePosition();
                  },
                  child: Container(
                    height: 100,
                    color: Colors.grey.withOpacity(0.2),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                            child: const Text("AnimatedPositioned"),
                            top: viewModel.animatedPositionTop,
                            left: viewModel.animatedPositionLeft,
                            curve: viewModel.curve,
                            duration: viewModel.duration)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedSwitcher(
                  duration: viewModel.duration,
                  switchInCurve: viewModel.curve,
                  switchOutCurve: viewModel.curve,
                  child: viewModel.isDefaultAnimatedSwitcher
                      ? ElevatedButton(
                    onPressed: () {
                      viewModel.animateSwitcher();
                    },
                    child: const Text("AnimatedSwitcher - ElevatedButton"),
                  )
                      : TextButton(
                    onPressed: () {
                      viewModel.animateSwitcher();
                    },
                    child: const Text("AnimatedSwitcher - TextButton"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedScale(
                  duration: viewModel.duration,
                  scale: viewModel.animatedScale,
                  curve: viewModel.curve,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.animateScale();
                    },
                    child: const Text("AnimatedScale"),
                  ),
                ),
              )
            ],
          ),
    );
  }
}

class ExplicitAnimation extends StatelessWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, HomeViewModel viewModel, child) =>
          SafeArea(
            child: IgnorePointer(
              child: RotationTransition(
                turns: viewModel.rotationAnimation,
                child: AlignTransition(
                  alignment: viewModel.alignmentAnimation,
                  child: FadeTransition(
                      opacity: viewModel.opacityAnimation,
                      child: Hero(
                        tag: "flutter-logo",
                        child: FlutterLogo(
                          style: FlutterLogoStyle.stacked,
                          size: viewModel.sizeAnimation.value,
                          textColor: viewModel.colorAnimation.value ??
                              Colors.blue,
                        ),
                      )),
                ),
              ),
            ),
          ),
    );
  }
}

class ExplicitAnimationController extends StatelessWidget {
  const ExplicitAnimationController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, HomeViewModel viewModel, child) =>
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                alignment: Alignment.center,
                child: const Text(
                  "Animation explicite",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      viewModel.startExplicitAnimation();
                    },
                    icon: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.pauseExplicitAnimation();
                    },
                    icon: const Icon(Icons.pause),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.revertExplicitAnimation();
                    },
                    icon: const Icon(Icons.replay_sharp),
                  ),
                ],
              )
            ],
          ),
    );
  }
}
