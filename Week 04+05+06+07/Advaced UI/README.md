
# Advanced UI

## Actions & Shortchuts

An action can be an easy callback (like the CallbackAction) or something more intricate that works with full undo/redo systems. Shortcuts are key bindings that are activated by pressing a single key or a string of keys. The key combinations are stored in a table with their assigned purposes. When the Shortcuts widget calls one of them, it passes the appropriate intent to the actions subsystem for execution. The user intents in Flutter are represented by an instance of the Intent class. A general purpose intention can be achieved by a variety of activities in a variety of situations. 

#### Why separate Actions from Intents?
Key mapping definitions and action definitions in an app can be separated into several categories by using intentions. They enable automatic adaptation of a single key combination to whatever action satisfies the specified operation for the targeted circumstance. Without Intents, activities would have to be defined at a higher level so that shortcuts could see them, which would give shortcuts access to more information than is necessary. An action can be configured to have different purposes depending on the intents that were set. To avoid the Intent having to know too much, state that applies to every instance of an action should be supplied to the activity's constructor rather than the Intent.

#### Why not use callbacks?

The main purpose is because by implementing isEnabled, operations may determine if they are enabled. Additionally, it frequently helps if the implementation of the key bindings is in a different location than the key bindings themselves.

### Shortcuts

By using shortcuts, you can link particular application activities to keyboard shortcuts. When compared to utilising a mouse or touch screen, shortcuts allow users to engage with a programme using keyboard input, which is frequently more effective. The Flutter framework offers a Shortcuts widget that can be used to provide a list of keyboard shortcuts and the activities they should launch. These shortcuts can be tailored to the needs of the application and its users by focusing on particular areas of the application, such as a specific widget or screen.

#### ShortcutManager
The shortcut manager, a more durable object than the Shortcuts widget, passes important events as soon as they occur. It keeps a map of key combinations to intents and contains the logic for choosing how to handle the keys as well as the logic for moving up the tree to identify more shortcut mappings.

Although the ShortcutManager's default behaviour is typically preferable, the Shortcuts widget accepts a ShortcutManager that you can subclass to alter its functionality.

```bash 
class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}
```
### Actions

By using an Intent to call them, Actions allow for the defining of the operations that the application can carry out. Actions can be enabled or disabled, and they are given the instance of the intent that called them as an argument to allow the intent to configure them.

#### Defining Actions

```bash
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final Model model;

  @override
  void invoke(covariant SelectAllIntent intent) => model.selectAll();
}
```
```bash
CallbackAction(onInvoke: (intent) => model.selectAll());
```

```bash
@override
Widget build(BuildContext context) {
  return Actions(
    actions: <Type, Action<Intent>>{
      SelectAllIntent: SelectAllAction(model),
    },
    child: child,
  );
}
```

#### Invoking Actions
There are numerous ways to call actions in the actions system. There are other ways to query the actions subsystem and execute an action, but using a Shortcuts widget, which was covered in the last section, is by far the most popular. Actions that are not key-bound can be called up.
```bash
Action<SelectAllIntent>? selectAll =
    Actions.maybeFind<SelectAllIntent>(context);
```
```bash
Object? result;
if (selectAll != null) {
  result = Actions.of(context).invokeAction(selectAll, SelectAllIntent());
}
```
```bash
Object? result =
    Actions.maybeInvoke<SelectAllIntent>(context, SelectAllIntent());
```
```bash
@override
Widget build(BuildContext context) {
  return Actions(
    actions: <Type, Action<Intent>>{
      SelectAllIntent: SelectAllAction(model),
    },
    child: Builder(
      builder: (context) => TextButton(
        child: const Text('SELECT ALL'),
        onPressed: Actions.handler<SelectAllIntent>(
          context,
          SelectAllIntent(controller: controller),
        ),
      ),
    ),
  );
}
```

#### Action Dispatchers
Action dispatcher is a mechanism for managing state in an app's architecture. It provides a centralized location for managing state changes and making updates to the user interface. Action dispatchers can help simplify app architecture and make it easier to manage state changes across the app.

```bash
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);

    return null;
  }
}
```
```bash
@override
Widget build(BuildContext context) {
  return Actions(
    dispatcher: LoggingActionDispatcher(),
    actions: <Type, Action<Intent>>{
      SelectAllIntent: SelectAllAction(model),
    },
    child: Builder(
      builder: (context) => TextButton(
        child: const Text('SELECT ALL'),
        onPressed: Actions.handler<SelectAllIntent>(
          context,
          SelectAllIntent(),
        ),
      ),
    ),
  );
}
```
## Fonts & Typography
#### Typography
For your app, the typography class offers a selection of pre-made text themes. These default font families, sizes, and styles come in these themes and are made to go well together.

You can create a TextTheme object and depend it to the ThemeData constructor to utilize a text theme:

```bash
ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
```
#### Variable fonts
OpenType fonts, often known as variable fonts, let you modify predefined elements of text design. Specific axes, like width, weight, and slant (to mention a few), are supported by variable fonts. When choosing the type, the user may choose any value along the continuous axis.

#### Static fonts
Static fonts can be used to display text in your app without having to load any custom fonts or connect to any external APIs. Static fonts are pre-installed fonts that come with the operating system and can be used without any additional configuration.

## Keyboard focus system
With the help of Flutter's focus system feature, users may direct keyboard input to a particular area of the application. To accomplish this, users must click or tap on the desired UI element to concentrate the input. As a result, unless the attention is switched to another area of the application, that area will get any text entered using the keyboard. Pressing the Tab key, which is frequently used for Tab navigation, will also move the focus.

#### FocusNode and FocusScopeNode
The FocusNode and FocusScopeNode objects in Flutter are used to implement the focus system, which manages user focus on different widgets in the app. They hold the focus state and attributes persistently, forming a focus tree data structure. 

#### Unfocusing

The FocusNode.unfocus() API is used to remove focus from a node, but it always passes the focus to another node. The node that receives the focus depends on the disposition argument passed to unfocus(). The two available modes are UnfocusDisposition.scope, which gives focus to the nearest parent focus scope, and UnfocusDisposition.previouslyFocusedChild, which gives focus to the previously focused child in the scope.

#### Focus widget
The Focus widget is the main workhorse of the focus system in Flutter. It manages a focus node, attaches and detaches it from the focus tree, and controls its attributes and callbacks. By wrapping a widget subtree with a Focus widget, the subtree can obtain focus during focus traversal or by calling requestFocus() on the associated FocusNode. If a FocusNode is not provided, the Focus widget creates one. Creating a custom FocusNode allows for more control over the focus system, but most of the functionality can be managed through the attributes of the Focus widget itself.

#### Controlling focus
To control what can receive focus and how in the focus system, the Focus widget has attributes such as canRequestFocus, skipTraversal, and descendantsAreFocusable. If skipTraversal is set to true, the node is skipped during focus traversal. If canRequestFocus is set to false, the node cannot be used to request focus and is skipped during focus traversal. 

#### Autofocus
The autofocus property can be set to a boolean value, and is available on a number of widgets, including TextFormField, TextField, DropdownButton, and more. When set to true, the widget will automatically receive focus when it is displayed.

#### Change notifications
To receive notifications when the attention state for a specific node has changed, use the attention.onFocusChanged callback. It sends notifications if the node is added to or removed from the focus chain, so even if it isn't the main focus, it still receives notifications. Check if hasPrimaryFocus on the focus node is true if you only want to know if you have the primary focus.

### FocusScope widget
The FocusScope widget manages a FocusScopeNode in the focus tree, which groups the focus nodes in a subtree and keeps track of current focus and focus history within its scope. Focus traversal stays within a focus scope, and the scope can return focus to itself if no descendants have focus. If a focus scope is focused, it first attempts to focus the most recently focused node in its subtree or the node that requested autofocus, and if there is none, it receives focus itself.

### FocusableActionDetector widget
A detector that defines actions and key bindings and offers callbacks for managing focus and hover highlights is created by the FocusableActionDetector widget, which combines the capabilities of Actions, Shortcuts, MouseRegion, and a Focus widget.

### Controlling focus traversal
Controlling focus traversal involves managing the order in which widgets receive focus as users navigate through the app using a keyboard or other input device. The order of focus traversal is determined by the order in which widgets are added to the widget tree.

1. FocusTraversalGroup widget
2. FocusTraversalPolicy

### The Focus Manager
The FocusManager keeps the system's current primary focus intact. Users of the focus system can only make use of a small number of its API components. One is the FocusManager.instance.primaryFocus property, which is likewise reachable via the global primaryFocus field and holds the focus node that is presently focused.

### Pointers
A Pointer is an object representing a single point of contact with a screen. Pointers are used to track user input events such as taps, drags, and scrolls.
When a user interacts with a screen, a pointer event is generated and sent to the widgets under the pointer. Widgets can then respond to the event in different ways, depending on the type of the event and the widget's implementation.

### Gestures
Gestures are recognized from several individual pointer events, sometimes even multiple individual pointers, and indicate semantic actions (such as tap, drag, and scale). Multiple events that correlate to the gesture's lifecycle, such as drag start, drag update, and drag finish, can be dispatched by gestures.

   #### Gestures detector
    The GestureDetector widget decides which gestures to attempt to recognize based on which of its callbacks are non-null.
## Shaders
You may design unique visual effects, textures, and animations for your Flutter apps by using the potent tool known as shaders. The GPU is used to execute shaders, which makes them incredibly quick and effective. Shaders are written in a language called GLSL (OpenGL Shading Language).

An example of a custom shader that creates a noise effect:

```bash
class NoiseShader extends Shader {
  @override
  Float32List get _flutterMatrix => Matrix4.identity().storage;

  @override
  bool get isComplex => false;

  @override
  Shader? release() => null;

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  void dispose() {}

  @override
  Shader createShader(Rect rect) {
    final noiseShader = '''
      uniform float time;
      uniform vec2 resolution;

      float rand(vec2 co) {
        return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
      }

      void main() {
        vec2 p = gl_FragCoord.xy / resolution.xy;
        float n = 0.0;
        n += rand(p * 10.0 + vec2(time * 0.5));
        n += rand(p * 50.0 + vec2(time * 0.5));
        n += rand(p * 100.0 + vec2(time * 0.5));
        n /= 3.0;
        gl_FragColor = vec4(vec3(n), 1.0);
      }
    ''';

    return FlutterShader.compileGLSL(
      noiseShader,
      <String, dynamic>{
        'time': DateTime.now().millisecondsSinceEpoch / 1000.0,
        'resolution': rect.size,
      },
    );
  }
}
```
## Silvers

The term "silvers" describes the classes and widgets that are used to build scrollable regions with a flexible layout, such as lists, grids, and other scrolling views.

With the ordinary ListView widget, it would be challenging to generate and maintain scrolling layouts with a high number of items. Instead, the Silver design pattern is employed. A Silver widget creates a small number of items that are currently visible on the screen and adds more items as the user scrolls down, as opposed to rendering all the objects at once.

There are several classes and widgets in Flutter that are part of the Silvers framework, including:

1. SliverAppBar: A flexible app bar that can expand and collapse as the user scrolls.

2. SliverList: A scrollable list that creates a small number of items at a time as the user scrolls.

3. SliverGrid: A scrollable grid that creates a small number of items at a    time as the user scrolls.

4. SliverToBoxAdapter: A widget that can be used to insert non-scrollable content between scrollable widgets.

5. SliverFillRemaining: A widget that fills the remaining space on the screen after all other Silver widgets have been displayed.