import 'package:flutter/material.dart';

import 'package:opena_front/components/custom_stepper/custom_base_stepper.dart';

class CustomIconStepper extends StatelessWidget {
  /// Each icon defines a step. Hence, total number of icons determines the total number of steps.
  final List<Icon> icons;

  /// Whether to enable or disable the next and previous buttons.
  final bool enableNextPreviousButtons;

  /// Whether to allow tapping a step to move to that step or not.
  final bool enableStepTapping;

  /// Icon to be used for the previous button.
  final Icon previousButtonIcon;

  /// Icon to be used for the next button.
  final Icon nextButtonIcon;

  /// Determines what should happen when a step is reached. This callback provides the __index__ of the step that was reached.
  final OnStepReached onStepReached;

  /// Whether to show the steps horizontally or vertically. __Note: Ensure horizontal stepper goes inside a column and vertical goes inside a row.__
  final Axis direction;

  /// The color of the step when it is not reached.
  final Color stepColor;

  /// The amount of padding inside a step.
  final double stepPadding;

  /// The color of a step when it is reached.
  final Color activeStepColor;

  /// The border color of a step when it is reached.
  final Color activeStepBorderColor;

  /// The border width of the active step.
  final double activeStepBorderWidth;

  /// Determines how far away the border should be drawn from the step when it is reached.
  final double activeStepBorderPadding;

  /// The color of the line that separates the steps.
  final Color lineColor;

  /// The length of the line that separates the steps.
  final double lineLength;

  /// The radius of individual dot within the line that separates the steps.
  final double lineDotRadius;

  /// The radius of a step.
  final double stepRadius;

  /// Whether the stepping is enabled or disabled.
  final bool steppingEnabled;

  /// Whether to go to the next step or not.
  final bool goNext;

  /// Whether to go the next step or not.
  final bool goPrevious;

  /// Whether the scrolling is disabled or not.
  final bool scrollingDisabled;

  //커스텀
  final int selectedIndex;

  CustomIconStepper({
    this.icons,
    this.direction = Axis.horizontal,
    this.stepColor,
    this.stepPadding = 1.0,
    this.activeStepColor,
    this.activeStepBorderColor,
    this.activeStepBorderWidth = 0.5,
    this.activeStepBorderPadding = 5.0,
    this.lineColor,
    this.lineLength = 50.0,
    this.lineDotRadius = 1.0,
    this.stepRadius = 24.0,
    this.steppingEnabled = true,
    this.goNext = false,
    this.goPrevious = false,
    this.scrollingDisabled = false,
    this.selectedIndex = 0,
  })  : this.enableNextPreviousButtons = false,
        this.enableStepTapping = false,
        this.previousButtonIcon = null,
        this.nextButtonIcon = null,
        this.onStepReached = null;

  @override
  Widget build(BuildContext context) {
    return BaseStepper(
      children: _iconsWithSizeOverridden(),
      direction: direction,
      stepColor: stepColor,
      activeStepColor: activeStepColor,
      activeStepBorderColor: activeStepBorderColor,
      activeStepBorderWidth: activeStepBorderWidth,
      lineColor: lineColor,
      lineLength: lineLength,
      lineDotRadius: lineDotRadius,
      stepRadius: stepRadius,
      steppingEnabled: steppingEnabled,
      margin: activeStepBorderPadding,
      padding: stepPadding,
      goNext: goNext,
      goPrevious: goPrevious,
      scrollingDisabled: scrollingDisabled,
      selectedIndex: selectedIndex,
    );
  }

  // Overrides the size of the icons to almost fit the step.
  List<Icon> _iconsWithSizeOverridden() {
    return List.generate(icons.length, (index) {
      return Icon(
        icons[index].icon,
        color: icons[index].color,
        size: stepRadius * 1.2,
      );
    });
  }
}
