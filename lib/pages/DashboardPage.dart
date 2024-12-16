import 'package:flutter/material.dart';
import 'BuyPage.dart';
import 'SellPage.dart';


class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( // Centrer l'ensemble du contenu
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
          crossAxisAlignment: CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            // Les textes en haut
            Column(
              children: [
                Text(
                  'Waste2Green',
                  style:  TextStyle(
                    color:  Color(0xFF6A994E),
                    fontSize: 50,  // Taille du texte agrandie
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),  // Espacement entre les textes
                Text(
                  '"Earth loves second chances"',
                  style:const TextStyle(
                    fontSize: 20,  // Taille du texte agrandie
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Espacement entre les textes et les boutons
            SizedBox(height: 80),
            // Le bouton "Buy"
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyPage()),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
              label: Text(
                'Buy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,  // Taille du texte du bouton agrandie
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFF6A994E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 60),  // Espacement entre les boutons
            // Le bouton "Sell"
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellPage()),
                );
              },
              icon: Icon(Icons.add, color: Colors.white,),
              label: Text(
                'Sell',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,  // Taille du texte du bouton agrandie
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6A994E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


