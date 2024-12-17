import 'package:flutter/material.dart';
import 'BuyPage.dart';
import 'my_cart.dart';
import 'profile_page.dart';
import 'rewards_page.dart';
import 'SellPage.dart';


class OrderTracking extends StatefulWidget {
  final Map<String, dynamic> orderDetails;

  const OrderTracking({
    Key? key,
    required this.orderDetails,
  }) : super(key: key);

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  bool showTracking = true;

  @override
  Widget build(BuildContext context) {
    print('Order Details received: ${widget.orderDetails}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              print('Notification Icon Pressed');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green[50],
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:Colors.green[50] ,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Color(0xFF6A994E),
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Color(0xFF6A994E)),
                title: Text('Home', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BuyPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Color(0xFF6A994E)),
                title: Text('Cart', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCart()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF6A994E)),
                title: Text('Profile', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // En-tête avec les détails de la commande
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFF6A994E),
            child: Column(
              children: [
                Text(
                  'Thank you for your order!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Amount: ${widget.orderDetails['total'].toStringAsFixed(2)} dt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Delivery to: ${widget.orderDetails['name']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Tabs
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showTracking = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showTracking ? Colors.red : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                    ),
                    side: showTracking ? null : BorderSide(color: Colors.grey),
                  ),
                  child: Text(
                    'Tracking',
                    style: TextStyle(
                      color: showTracking ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showTracking = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !showTracking ? Colors.red : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                    ),
                    side: !showTracking ? null : BorderSide(color: Colors.grey),
                  ),
                  child: Text(
                    'Order Details',
                    style: TextStyle(
                      color: !showTracking ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Contenu conditionnel basé sur showTracking
          Expanded(
            child: showTracking ? _buildTrackingView() : _buildOrderDetailsView(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:Color(0xFF6A994E),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BuyPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.star, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RewardsPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCart()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingView() {
    return Column(
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order number',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF6A994E),
                      radius: 25,
                      child: Text(
                        widget.orderDetails['orderNumber']?.substring(widget.orderDetails['orderNumber'].length - 2) ?? '75',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Pick-up time: 8:30 AM'),
                Text('Pick-up date: ${widget.orderDetails['orderDate'] ?? 'Thursday 29.11.2024'}'),
              ],
            ),
          ),
        ),
        // Order Tracking
        const Text(
          'Order Tracking',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: [
              // Custom progress indicator
              Row(
                children: [
                  Container(
                    width: 40,
                    child: Column(
                      children: [
                        _buildStepIndicator(true),
                        _buildVerticalLine(true),
                        _buildStepIndicator(false),
                        _buildVerticalLine(false),
                        _buildStepIndicator(false),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Order placed'),
                          trailing: Icon(Icons.check_circle, color:Color(0xFF6A994E)),
                        ),
                        ListTile(
                          title: Text('Preparing'),
                          trailing: Icon(Icons.radio_button_unchecked, color: Colors.grey),
                        ),
                        ListTile(
                          title: Text('Order is ready'),
                          trailing: Icon(Icons.radio_button_unchecked, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A994E),
                    ),
                  ),
                  Divider(),
                  _buildDetailRow('Order Number:', widget.orderDetails['orderNumber'] ?? 'N/A'),
                  _buildDetailRow('Order Date:', widget.orderDetails['orderDate'] ?? 'N/A'),
                  _buildDetailRow('Total Amount:', '${widget.orderDetails['total'].toStringAsFixed(2)} dt'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A994E),
                    ),
                  ),
                  Divider(),
                  _buildDetailRow('Name:', widget.orderDetails['name']),
                  _buildDetailRow('Address:', widget.orderDetails['address']),
                  _buildDetailRow('Phone:', widget.orderDetails['phone']),
                  _buildDetailRow('Email:', widget.orderDetails['email']),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Schedule',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A994E),
                    ),
                  ),
                  Divider(),
                  _buildDetailRow('Pick-up Time:', '8:30 AM'),
                  _buildDetailRow('Expected Delivery:', 'Thursday 29.11.2024'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(bool isActive) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ?Color(0xFF6A994E) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildVerticalLine(bool isActive) {
    return Container(
      width: 2,
      height: 40,
      color: isActive ? Color(0xFF6A994E) : Colors.grey[300],
    );
  }
}


