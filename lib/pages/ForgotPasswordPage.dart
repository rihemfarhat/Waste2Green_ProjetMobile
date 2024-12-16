import 'package:flutter/material.dart';
class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ajout de l'image
              Center(
                child: Image.asset(
                  'assets/image_1.png', // Remplacez cette URL par celle de votre image
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Texte d'instruction
              Text(
                'Enter your email to reset your password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Champ de saisie pour l'email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bouton d'envoi
              SizedBox(
                width: double.infinity, // Prend toute la largeur disponible
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Logique de réinitialisation du mot de passe ici
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password reset email sent')),
                      );
                      Navigator.pop(context); // Retour à la page précédente
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF6A994E),
                    padding: const EdgeInsets.symmetric(vertical: 15), // Ajuste uniquement la hauteur
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


