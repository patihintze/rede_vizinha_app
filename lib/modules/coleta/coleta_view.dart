import 'package:flutter/material.dart';
import 'package:rede_vizinha_app/theme/colors.dart';
import 'package:rede_vizinha_app/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ColetaView extends StatelessWidget {
  const ColetaView({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Horários de Lixo 🗑️",
          style: AppTextStyles.headline1.copyWith(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Lixo Comum"),
              subtitle: Text("Qualquer dia e horário*"),
              textColor: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.recycling, color: Colors.green),
              title: Text("Lixo Reciclável"),
              subtitle: Text("Segundas-Feiras - até 19h"),
              textColor: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: const Text("EcoPonto Pinheiros"),
              subtitle: const Text("Clique ao lado para ver o endereço"),
              textColor: Colors.black,

              trailing: IconButton(
                icon: const Icon(Icons.open_in_new, color: Colors.blue),
                onPressed: () {
                  _launchUrl(
                    "https://prefeitura.sp.gov.br/web/pinheiros/w/noticias/101551",
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "*Mantenha o lixo sempre bem embalado e colocado próximo ao horário de coleta para evitar sujeira nas ruas.",
            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
