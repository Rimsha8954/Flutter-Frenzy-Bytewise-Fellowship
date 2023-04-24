
# Navigation

This project shows how to use Flutter's navigational features, such as data passing and routing between screens.

## Navigation Methods

### Named Routes

By providing a distinctive string identification for each screen, named routes make switching between screens simple. For larger apps with more complicated navigation, this approach is advised.

To define a named route, add it to the routes map in the MaterialApp widget:




```bash
  MaterialApp(
  routes: {
    '/': (context) => HomePage(),
    '/details': (context) => DetailsPage(),
  },
);
```

To navigate to a named route, use the Navigator.pushNamed() method:

```bash
Navigator.pushNamed(context, '/details');
```

### MaterialPageRoute

The MaterialPageRoute class generates a new screen and switches to it with an animation similar to material design. This approach is suggested for simple apps with a limited number of screens.

To navigate to a new screen, create a new MaterialPageRoute object and pass it to the Navigator.push() method:

```bash
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailsPage()),
);
```

### Passing Data

To pass data between screens, simply add it as an argument to the Navigator.push() or Navigator.pushNamed() method:

```bash
Navigator.pushNamed(
  context,
  '/details',
  arguments: 'Hello, world!',
);
```
To retrieve the data on the other screen, use the ModalRoute.of(context).settings.arguments property:

```bash
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
```

