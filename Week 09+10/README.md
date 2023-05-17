
# State Management

State management refers to the technique of managing and updating the data and user interface of an application. 




![App Screenshot](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/state-management-explainer.gif)

# Declarative Approch

Establishing the intended state and leaving the framework in charge of updating and rendering the user interface in accordance with that state. Instead of controlling the UI directly using imperative commands, you specify how it should appear based on the state of the application, and Flutter takes care of dynamically updating the UI as the state changes.

Declarative programming is the core of the entire UI of Flutter. Each widget in a widget tree that defines the UI represents a component of the user interface. You update the state variables as the state changes, and Flutter compares the new state with the old state to decide which UI elements need to be changed. It then effectively rebuilds only the UI elements that have changed, creating a rendering process that is both highly performant and effective.

# Ephemeral state vs App state
## Ephemeral state

Ephemeral state (sometimes called UI state or local state) is the state you can neatly contain in a single widget.

some of the few examples are:

- current page in a PageView
- current progress of a complex animation
- current selected tab in a BottomNavigationBar

```bash
class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: (newIndex) {
        setState(() {
          _index = newIndex;
        });
      },
      // ... items ...
    );
  }
}

```
## App state

State that is not ephemeral, that you want to share across many parts of your app, and that you want to keep between user sessions, is what we call application state (sometimes also called shared state).
Examples of application state:

- User preferences
- Login info
- Notifications in a social networking app
- The shopping cart in an e-commerce app
- Read/unread state of articles in a news app

## There is no clear-cut rule

There is no clear-cut, universal rule to distinguish whether a particular variable is ephemeral or app state. Sometimes, you’ll have to refactor one into another. For example, you’ll start with some clearly ephemeral state, but as your application grows in features, it might need to be moved to app state.

# Simple app state management

## Lifting state up
Why? In declarative frameworks like Flutter, if you want to change the UI, you have to rebuild it. There is no easy way to have MyCart.updateWith(somethingNew). In other words, it’s hard to imperatively change a widget from outside, by calling a method on it. And even if you could make this work, you would be fighting the framework instead of letting it help you.

```bash
// BAD: DO NOT DO THIS
void myTapHandler() {
  var cartWidget = somehowGetMyCartWidget();
  cartWidget.updateWith(item);
}

```
```bash
// BAD: DO NOT DO THIS
Widget build(BuildContext context) {
  return SomeWidget(
    // The initial state of the cart.
  );
}

void updateWith(Item item) {
  // Somehow you need to change the UI from here.
}
```

In Flutter, you construct a new widget every time its contents change. Instead of MyCart.updateWith(somethingNew) (a method call) you use MyCart(contents) (a constructor). Because you can only construct new widgets in the build methods of their parents, if you want to change contents, it needs to live in MyCart’s parent or above.

```bash
// GOOD
void myTapHandler(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context);
  cartModel.add(item);
}
```

```bash
// GOOD
Widget build(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context);
  return SomeWidget(
    // Just construct the UI once, using the current state of the cart.
    // ···
  );
}
```
This is what we mean when we say that widgets are immutable. They don’t change—they get replaced.

## Accessing the state
When a user clicks on one of the items in the catalog, it’s added to the cart. But since the cart lives above MyListItem, how do we do that?

A simple option is to provide a callback that MyListItem can call when it is clicked. Dart’s functions are first class objects, so you can pass them around any way you want. So, inside MyCatalog you can define the following:

```bash
@override
Widget build(BuildContext context) {
  return SomeWidget(
    // Construct the widget, passing it a reference to the method above.
    MyListItem(myTapCallback),
  );
}

void myTapCallback(Item item) {
  print('user tapped on $item');
}
```
This works okay, but for an app state that you need to modify from many different places, you’d have to pass around a lot of callbacks—which gets old pretty quickly.

## ChangeNotifier
ChangeNotifier is a simple class included in the Flutter SDK which provides change notification to its listeners.

In provider, ChangeNotifier is one way to encapsulate your application state. For very simple apps, you get by with a single ChangeNotifier. In complex ones, you’ll have several models, and therefore several ChangeNotifiers. (You don’t need to use ChangeNotifier with provider at all, but it’s an easy class to work with.)

## ChangeNotifierProvider
ChangeNotifierProvider is the widget that provides an instance of a ChangeNotifier to its descendants. It comes from the provider package.

```bash
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}
```

If you want to provide more than one class, you can use MultiProvider:

```bash
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MyApp(),
    ),
  );
}
```
## Consumer
We can now use CartModel since it has been made available to widgets in our app via the ChangeNotifierProvider declaration at the top.

Through the Consumer widget, this is accomplished.

```bash
return Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text('Total price: ${cart.totalPrice}');
  },
);
```
```bash
return Consumer<CartModel>(
  builder: (context, cart, child) => Stack(
    children: [
      // Use SomeExpensiveWidget here, without rebuilding every time.
      if (child != null) child,
      Text('Total price: ${cart.totalPrice}'),
    ],
  ),
  // Build the expensive widget here.
  child: const SomeExpensiveWidget(),
);
```
The recommended practice is to place your Consumer widgets as far down the tree as you can. Large sections of the UI shouldn't be rebuilt only because one small feature changed elsewhere.

## Provider.of
Sometimes you still need to access the model's data even when you don't actually need it to change the UI. For instance, a ClearCart button wants to let the customer empty their cart completely. It only has to call the clear() method; it is not necessary to display the items in the cart.

ConsumerCartModel> could be used for this, but that would be wasteful. By doing so, we would be asking the framework to recreate a widget that is already functional.

We can use Provider.of in this scenario, with the listen argument set to false.
```bash
Provider.of<CartModel>(context, listen: false).removeAll();
```
# List of state management approaches
Here's a list of some commonly used state management approaches in Flutter:

### Provider: 
A state management framework called Provider provides a straightforward and adaptable method for managing state in Flutter applications. To effectively transmit state changes down the widget tree, it uses the InheritedWidget pattern. Using the Provider.of() or Consumer widgets, you can define providers for various components of your application and keep track of changes in those providers.

### setState: 
setState, a built-in method offered by Flutter, is appropriate for maintaining state in compact and straightforward apps. It is based on a StatefulWidget's mutable state idea. Calling setState causes a rebuild of the widget and updates the UI when the state changes.

### BLoC (Business Logic Component): 
BLoC is an architectural design pattern used in Flutter apps to manage state. It employs streams to manage state and isolates the business logic from the user interface elements. In BLoC, state is managed by a distinct class called a BLoC that exposes streams of state updates. The UI can then be updated by widgets after they listen to these streams.

### Redux: 
The JavaScript environment gave birth to Redux, a predictable state container library, which has since been modified for Flutter. It controls the application state in a centralised store and adheres to a unidirectional data flow paradigm. Widgets can access the state by subscribing to the store, and Redux updates the state via actions and reducers.

### Fish-Redux:
Based on the Redux design, Fish-Redux is a state management framework for Flutter applications. By giving users a predictable and scalable method to handle state, it promises to improve and streamline the creation of Flutter apps. Flutter's Redux implementation is built upon by Fish-Redux, which also adds a number of new ideas and functionality.

### MobX: 
Another state management tool that may be used into Flutter applications is MobX. It makes use of observables to monitor state changes and promptly update reliant widgets. Your classes and properties can be annotated in MobX to make them observable, and widgets can then watch for and respond to changes in these observables.

### Riverpod: 
Riverpod is a Flutter state management library that offers a more readable syntax and better performance compared to Provider. It is built on top of the Provider package and provides a simpler and more intuitive API. Riverpod uses a concept called "Scoped Readers" to provide dependencies to widgets, making it easier to manage state in a scalable manner.

### GetX: 
GetX is a minimal state management library for Flutter with the goal of streamlining and improving state management. Numerous functionalities are offered, such as reactive state management, dependency injection, navigation management, and others. GetX offers a clear API for obtaining and modifying the state as well as the ability to construct controllers for managing state.

### Hive: 
A lightweight and quick NoSQL database for Flutter applications is called Hive. It can be used as a straightforward state management solution in addition to being primarily utilised for local persistence. Hive is suitable for handling modest amounts of local state since it offers an easy-to-use API for data storage and retrieval.





