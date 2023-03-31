import 'package:flutter/material.dart';

class AdminRecycleListPage extends StatefulWidget {
  const AdminRecycleListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminRecycleListPage> createState() => _AdminRecycleListPageState();
}

class _AdminRecycleListPageState extends State<AdminRecycleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              child: Center(child: Text('Favorite plans: 3')),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => const PlanRow(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 3,
              )),
        ],
      ),
    );
  }
}

class PlanRow extends StatefulWidget {
  const PlanRow({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanRow> createState() => _PlanRowState();
}

class _PlanRowState extends State<PlanRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Recent Purchases'),
      trailing: IconButton(
        onPressed: () {
          setState(() {});
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
