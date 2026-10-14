import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrganiserQrPage extends StatefulWidget{
    final String eventId;
    final String eventTitle;
    
    const OrganiserQrPage({
        super.key,
        required this.eventId,
        required this.eventTitle,
    });

    @override
    State<OrganiserQrPage> createState() => _DynamicHostQrScreenState();
}

class _DynamicHostQrScreenState extends State<OrganiserQrPage> {
  static const int _refreshIntervalSeconds = 15;
  int _secondsLeft = _refreshIntervalSeconds;
  String _currentSecretToken = '';
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _generateAndSyncToken();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        setState(() => _secondsLeft--);
      } else {
        _generateAndSyncToken();
      }
    });
  }

  Future<void> _generateAndSyncToken() async {
    final String newToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

    setState(() {
      _currentSecretToken = newToken;
      _secondsLeft = _refreshIntervalSeconds;
    });

    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.eventId)
          .update({
        'currentQrToken': newToken,
        'tokenExpiresAt': DateTime.now().add(
          const Duration(seconds: _refreshIntervalSeconds + 3),
        ),
      });
    } catch (e) {
      debugPrint('Error syncing QR token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String qrPayload = '${widget.eventId}:::$_currentSecretToken';

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(widget.eventTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Force Refresh Token',
            icon: const Icon(Icons.refresh),
            onPressed: _generateAndSyncToken,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Live Attendance Check-In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Scan using your campus app. Code refreshes every 15 seconds.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 36),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withValues(alpha: 0.25),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: _currentSecretToken.isEmpty
                    ? const SizedBox(
                        width: 280,
                        height: 280,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : QrImageView(
                        data: qrPayload,
                        version: QrVersions.auto,
                        size: 280,
                        backgroundColor: Colors.white,
                      ),
              ),
              const SizedBox(height: 36),

              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: CircularProgressIndicator(
                      value: _secondsLeft / _refreshIntervalSeconds,
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _secondsLeft <= 5 ? Colors.redAccent : Colors.tealAccent,
                      ),
                      backgroundColor: Colors.white12,
                    ),
                  ),
                  Text(
                    '$_secondsLeft',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Refreshing in $_secondsLeft seconds...',
                style: const TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}