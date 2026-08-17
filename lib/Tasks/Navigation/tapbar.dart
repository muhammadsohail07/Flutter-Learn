import 'package:flutter/material.dart';



class tapbarScreen extends StatelessWidget {
  const tapbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Courier Tracking'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: 'In Transit'),
                Tab(icon: Icon(Icons.check), text: 'Delivered'),
                Tab(icon: Icon(Icons.access_time), text: 'Pending'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildParcelList(['Parcel 21', 'Parcel 22'], Icons.directions_car, Colors.blue),
              _buildParcelList(['Parcel 23', 'Parcel 24'], Icons.check_circle, Colors.green),
              _buildParcelList(['Parcel 26', 'Parcel 27'], Icons.access_time, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParcelList(List<String> parcels, IconData icon, Color color) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: parcels.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            title: Text(
              parcels[index],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}