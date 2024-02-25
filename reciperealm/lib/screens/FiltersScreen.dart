import 'package:flutter/material.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

Map<Filter, bool> initialMapState = {
  Filter.glutenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarian : false,
  Filter.vegan : false,
};

class FiltersScreen extends StatefulWidget {
  Map<Filter, bool> filterApplied;

  FiltersScreen({super.key, required this.filterApplied});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeState = false;
  bool _lactoseFreeState = false;
  bool _vegetarianState = false;
  bool _veganState = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeState = widget.filterApplied[Filter.glutenFree]!;
    _lactoseFreeState = widget.filterApplied[Filter.lactoseFree]!;
    _vegetarianState = widget.filterApplied[Filter.vegetarian]!;
    _veganState = widget.filterApplied[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree : _glutenFreeState,
            Filter.lactoseFree : _lactoseFreeState,
            Filter.vegetarian : _vegetarianState,
            Filter.vegan : _veganState,
          });
          print(_glutenFreeState);
          print(_lactoseFreeState);
          print(_vegetarianState);
          print(_veganState);
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeState,
              onChanged: (val) {
                setState(() {
                  _glutenFreeState = val;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:  Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeState,
              onChanged: (val) {
                setState(() {
                  _lactoseFreeState = val;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:  Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianState,
              onChanged: (val) {
                setState(() {
                  _vegetarianState = val;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:  Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganState,
              onChanged: (val) {
                setState(() {
                  _veganState = val;
                });
              },
              title: Text(
                'Vegan Food',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:  Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
