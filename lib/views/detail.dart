import 'package:flutter/material.dart';
import 'package:modul_7/presenters/anime_detail_presenter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.endpoint});
  final int id;
  final String endpoint;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    implements AnimeDetailView {
  late AnimeDetailPresenter _presenter;
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() { //untuk menjalankan saat pertama kali dibuka
    super.initState();
    _presenter = AnimeDetailPresenter(this);
    _presenter.loadDetailData(widget.endpoint, widget.id);
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showDetailData(Map<String, dynamic> detailData) {
    setState(() {
      _detailData = detailData;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Soft blue background
      appBar: AppBar(
        title: const Text("Detail"),
        backgroundColor: const Color(0xFF64B5F6), // Soft blue for app bar
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFBBDEFB)), // Soft blue spinner
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Text(
                    "Error: $_errorMessage",
                    style: const TextStyle(color: Color(0xFF1565C0)), // Soft blue text color for error
                  ),
                )
              : _detailData != null
                  ? Column(
                      children: [
                        Image.network(
                          _detailData!['images'][0] ?? 'https://placehold.co/600x400',
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Name : ${_detailData!['name']}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1976D2), // Darker blue for title
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Kekkei Genkai : ${_detailData!['personal']['kekkeiGenkai'] ?? 'Empty'}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF42A5F5), // Lighter blue for content
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Title : ${_detailData!['personal']['titles']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF42A5F5), // Lighter blue for content
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        "Tidak ada data!",
                        style: TextStyle(color: Color(0xFF1976D2)), // Darker blue for no data
                      ),
                    ),
    );
  }
}
