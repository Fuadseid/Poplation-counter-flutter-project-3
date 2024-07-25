import 'package:flutter/material.dart';
import 'package:practice/New_pop.dart';
import 'package:practice/modele/chart/bar_graph.dart';
import 'package:practice/modele/pop_model.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() {
    return _DisplayState();
  }
}

class _DisplayState extends State<Display> {
  final List<PopModel> _registeredPop = [ ];

void newPop(PopModel popModel, PriceCategory category) {
  setState(() {
    _registeredPop.add(popModel);
    
    // Update the corresponding bucket
    final bucket = buckets.firstWhere((bucket) => bucket.category == category);
    bucket.number++; // Increment the count
  });
}


void _clear(PopModel popModel) {
  setState(() {
  
    final indexToDelete = _registeredPop.indexOf(popModel);
    
    if (indexToDelete != -1) {
  
      final lastIndex = _registeredPop.length - 1;
      if (indexToDelete != lastIndex) {
 
        final temp = _registeredPop[indexToDelete];
        _registeredPop[indexToDelete] = _registeredPop[lastIndex];
        _registeredPop[lastIndex] = temp;
      }
      
      
      final deletedPopModel = _registeredPop.removeLast();


      final category = PriceCategoryExtension.fromDescription(deletedPopModel.salary);
      final bucket = buckets.firstWhere((bucket) => bucket.category == category);
      bucket.number--; 
    }
  });
}



  void addPop() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewPop(inputform: newPop),
    );
  }
  




 List<PopBucket> buckets = [
  PopBucket(category: PriceCategory.below50),
  PopBucket(category: PriceCategory.between50And100),
  PopBucket(category: PriceCategory.between100And250),
  PopBucket(category: PriceCategory.above250),
  // Add other categories as needed
];

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text(
        'No Population is Just Added',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'asset/image/pie-chart.jpg',
              width: 300,
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.bar_chart, color: Colors.white),
                  SizedBox(width: 2),
                  Text(' Chart Bar', style: TextStyle(color: Colors.white)),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.pie_chart, color: Colors.white),
                  SizedBox(width: 2),
                  Text(' Pie Bar', style: TextStyle(color: Colors.white)),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Summary Population'),
        actions: [
          IconButton(onPressed: addPop, icon: const Icon(Icons.add)),
        ],
      ),
      body: _registeredPop.isEmpty
          ? maincontent // Show maincontent if the list is empty
          : Column(
              children: [
                // Graph section
                Expanded(
                  flex: 2, // Adjust flex to give the graph more space
                  child: MyBarGraph(
                    buckets: buckets,
                  ), // Pass the buckets here
                ),
                Expanded(
                  flex: 3, // Adjust flex for the list view
                  child: ListView.builder(
                    itemCount: _registeredPop.length,
                    itemBuilder: (context, index) {
                      final popModel = _registeredPop[index];

                      return Dismissible(
                        key: ValueKey(popModel.name),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _clear(popModel);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${popModel.name}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      'Salary: ${popModel.salary}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Gender: ${popModel.gender}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
