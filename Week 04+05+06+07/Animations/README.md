
# Animations

Flutter provides a powerful and flexible framework for creating animations in your app.

Types of Animation

## Tween Animation 
Tween animations allow you to create smooth transitions between two values over a specified duration. For example, you can use a tween animation to animate the opacity of a widget.

## Hero Animation
Hero animations allow you to create smooth transitions between two widgets as they move from one screen to another. For example, you can use a hero animation to animate the transition between a thumbnail image and a larger image on a details page.

## Physics-based animation
Physics-based animation can be achieved using the physics simulation engine provided by the flutter/scheduler.dart library. This engine uses the laws of physics to simulate the movement of objects and create more realistic and natural motion. To use the physics simulation engine, you need to create a TickerProvider and a Simulation object. The TickerProvider is used to generate a continuous stream of time updates that drive the animation, while the Simulation object defines the behavior of the animation.

## Implicit animations
Implicit animations occur when a widget's property changes, and the framework automatically manages them. The framework instantly simulates smooth motion when a widget's property changes by animating the change over time.
When only one property needs to be changed, implicit animations are advantageous. They don't require any coding and are simple to use. 

- AnimatedFoo widget
- Tween animated builder

## Built-in Explicit animations
Flutter has both implicit and built-in explicit animations, enabling you to make more complicated and personalized animations. Explicit animations are more difficult to set up but provide you greater control over the animation's appearance.

- Foo transition widget
- Animated widget
- Animated builder

### Animated Widget
An AnimatedWidget is a widget that can automatically rebuild when the animation changes. This allows you to create custom widgets that animate automatically when the underlying animation changes.

```bash
class MyAnimatedWidget extends AnimatedWidget {
  MyAnimatedWidget({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      width: animation.value,
      height: animation.value,
      color: Colors.blue,
    );
  }
}
```
### Animated builder
The AnimatedBuilder widget offers a builder function that defines the animation, allowing users to construct their own own animations. Every time the animation changes, the builder function is called, giving you the opportunity to adjust the widget appropriately.

```bash
AnimatedBuilder(
  animation: _animation,
  builder: (BuildContext context, Widget child) {
    return Container(
      width: _animation.value,
      height: _animation.value,
      color: Colors.blue,
    );
  },
);
```

## Animation Deep Dive
Flutter offers a variety of tools for creating and managing animations, which are a crucial component of developing dynamic and engaging user interfaces.

### Animation Controller
An AnimationController is used to control the animation and specify its duration, direction, and other parameters. 

```bash
final AnimationController _controller = AnimationController(
  duration: const Duration(seconds: 1),
  vsync: this,
);

```
## Staggered animations
A simple idea behind a staggered animation is that visual changes take place over time rather than all at once. One change might appear after another in a strictly sequential animation, or there might be some overlap or even total overlap. Additionally, there could be gaps where nothing changes.
