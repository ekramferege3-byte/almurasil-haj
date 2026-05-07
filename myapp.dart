import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const AlMurasilGlobal());
}

class AlMurasilGlobal extends StatefulWidget {
  const AlMurasilGlobal({super.key});

  @override
  State<AlMurasilGlobal> createState() => _AlMurasilGlobalState();
}

class _AlMurasilGlobalState extends State<AlMurasilGlobal> {
  // መጀመሪያ በእንግሊዝኛ እንዲከፈት (Global ስለሆነ)
  String _selectedLang = 'English';

  final Map<String, Map<String, String>> _loc = {
    'English': {
      'title': 'Al-Murasil Global 🕋',
      'sub': 'Universal Hajj Platform',
      'prayer': 'Prayer Times',
      'dua': 'Daily Duas',
      'map': 'Navigation',
      'sos': 'Emergency',
      'sites': 'Holy Sites',
      'health': 'Health',
    },
    'አማርኛ': {
      'title': 'አል-ሙራሲል ሐጅ 🕋',
      'sub': 'ዓለም አቀፍ የሐጅ መመሪያ',
      'prayer': 'የሶላት ሰዓት',
      'dua': 'ዕለታዊ ዱዓዎች',
      'map': 'አሰሳ',
      'sos': 'አደጋ ጊዜ',
      'sites': 'ቅዱስ ቦታዎች',
      'health': 'ጤና',
    },
    'Arabic': {
      'title': 'المراسل العالمي 🕋',
      'sub': 'منصة الحج العالمية',
      'prayer': 'أوقات الصلاة',
      'dua': 'الأدعية اليومية',
      'map': 'الملاحة',
      'sos': 'طوارئ',
      'sites': 'الأماكن المقدسة',
      'health': 'صحة',
    },
    'Turkish': {
      'title': 'Al-Murasil Hac 🕋',
      'sub': 'Evrensel Hac Platformu',
      'prayer': 'Namaz Vakitleri',
      'dua': 'Sesli Dualar',
      'map': 'Navigasyon',
      'sos': 'Acil Durum',
      'sites': 'Kutsal Yerler',
      'health': 'Sağlık',
    },
    'Indonesian': {
      'title': 'Al-Murasil Haji 🕋',
      'sub': 'Platform Haji Universal',
      'prayer': 'Waktu Sholat',
      'dua': 'Doa Harian',
      'map': 'Navigasi',
      'sos': 'Darurat',
      'sites': 'Situs Suci',
      'health': 'Kesehatan',
    },
    'French': {
      'title': 'Al-Murasil Mondial 🕋',
      'sub': 'Plateforme Universelle',
      'prayer': 'Heures Prière',
      'dua': 'Douas Quotidiens',
      'map': 'Navigation',
      'sos': 'Urgence',
      'sites': 'Lieux Saints',
      'health': 'Santé',
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green.shade900,
      ),
      home: Dashboard(
        lang: _selectedLang,
        text: _loc[_selectedLang]!,
        onLangChange: (val) => setState(() => _selectedLang = val!),
        languages: _loc.keys.toList(),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final String lang;
  final Map<String, String> text;
  final Function(String?) onLangChange;
  final List<String> languages;

  const Dashboard({
    super.key,
    required this.lang,
    required this.text,
    required this.onLangChange,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        elevation: 0,
        title: Text(text['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          DropdownButton<String>(
            value: lang,
            dropdownColor: Colors.green.shade800,
            icon: const Icon(Icons.language, color: Colors.white),
            underline: const SizedBox(),
            onChanged: onLangChange,
            items: languages.map((l) => DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(color: Colors.white)))).toList(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            ),
            child: Column(
              children: [
                const Icon(Icons.mosque, size: 60, color: Colors.amber),
                const SizedBox(height: 15),
                Text(text['sub']!, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 5),
                Text("${text['prayer']}: $time", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _card(text['dua']!, Icons.auto_stories, Colors.deepPurple, () => _showContent(context, text['dua']!)),
                _card(text['sites']!, Icons.fort, Colors.orange, () => _showContent(context, text['sites']!)),
                _card(text['map']!, Icons.explore_outlined, Colors.teal, () {}),
                _card(text['sos']!, Icons.emergency_share, Colors.red, () {}),
                _card(text['health']!, Icons.monitor_heart_outlined, Colors.blue, () {}),
                _card("Zakat", Icons.volunteer_activism, Colors.brown, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContent(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Divider(),
            const Text("Feature Details for Pilgrims..."),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, size: 35, color: color),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

