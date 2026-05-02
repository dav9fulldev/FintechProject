import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        title: const Text('Aide & FAQ', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildFAQItem(
            'Comment ajouter une dépense ?',
            'Cliquez sur le bouton "+" au centre du menu en bas, ou utilisez l\'assistant vocal Sika en disant "Sika".',
          ),
          _buildFAQItem(
            'Qu\'est-ce que Sika ?',
            'Sika est votre assistant vocal intelligent. Elle peut enregistrer vos dépenses simplement en vous écoutant parler.',
          ),
          _buildFAQItem(
            'Comment modifier mes objectifs ?',
            'Allez dans l\'onglet "Objectifs" en bas, cliquez sur l\'objectif que vous souhaitez modifier pour voir les détails.',
          ),
          _buildFAQItem(
            'Mes données sont-elles sécurisées ?',
            'Oui, toutes vos données financières sont cryptées et stockées en toute sécurité sur nos serveurs.',
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Vous avez encore besoin d\'aide ?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Contactez-nous à support@gertonargent.ci',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF1E40AF),
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedAlignment: Alignment.topLeft,
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
