import 'package:flutter/material.dart';

class BloodBankDashboardScreen extends StatelessWidget {
  const BloodBankDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Blood Bank Dashboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.bloodtype_outlined, color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Stat Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Donors", "450", Icons.people, Colors.teal),
                _buildStatCard("Requests", "120", Icons.request_page, Colors.deepOrange),
                _buildStatCard("Units Available", "98", Icons.water_drop, Colors.redAccent),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "Blood Group Availability",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildBloodGroupTile("A+", 20),
                _buildBloodGroupTile("A-", 10),
                _buildBloodGroupTile("B+", 15),
                _buildBloodGroupTile("B-", 8),
                _buildBloodGroupTile("O+", 25),
                _buildBloodGroupTile("O-", 6),
                _buildBloodGroupTile("AB+", 9),
                _buildBloodGroupTile("AB-", 5),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "Recent Requests",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildRequestTile("Suman Sharma", "O+", "Urgent", "Bir Hospital"),
            _buildRequestTile("Aayusha Karki", "B-", "Normal", "Teaching Hospital"),
            _buildRequestTile("Nirajan Bista", "A+", "Urgent", "Nepal Mediciti"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodGroupTile(String group, int count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(group,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              )),
          const SizedBox(height: 6),
          Text("$count Units",
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRequestTile(String name, String bloodGroup, String priority, String hospital) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Text(
              bloodGroup,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(hospital, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            priority,
            style: TextStyle(
              color: priority == "Urgent" ? Colors.red : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
