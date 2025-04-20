import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../environment.dart';
import '../../data/source/wallet_datasource.dart';
import '../../navigation/wallet_routes.dart';
import '../../util/extension/build_context_extension.dart';
import '../../util/extension/string_extension.dart';
import '../../feature/common/widget/button/bottom_back_button.dart';
import '../../feature/common/widget/centered_loading_indicator.dart';
import '../../feature/common/widget/wallet_app_bar.dart';

import 'package:http/http.dart' as http;

final _scannerKey = Environment.isTest ? ValueKey(DateTime.now()) : GlobalKey();

class OrganizationQrScreen extends StatefulWidget {
  final String organizationId;
  const OrganizationQrScreen({Key? key, required this.organizationId})
      : super(key: key);

  @override
  State<OrganizationQrScreen> createState() => _OrganizationQrScreenState();
}

class _OrganizationQrScreenState extends State<OrganizationQrScreen> with WidgetsBindingObserver {
  late MobileScannerController cameraController;
  bool isTorchOn = false;
  bool isProcessingQR = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  void _initializeCamera() {
    cameraController = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  void _toggleTorch() {
    setState(() {
      isTorchOn = !isTorchOn;
      cameraController.toggleTorch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(context),
      body: Column(
        children: [
          Expanded(child: _buildBody(context)),
          const SafeArea(top: false, child: BottomBackButton()),
        ],
      ),
    );
  }

  PreferredSize _buildTransparentAppBar(BuildContext context) {
    final appBar = WalletAppBar();
    return PreferredSize(
      preferredSize: appBar.preferredSize,
      child: Opacity(opacity: 0.9, child: appBar),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          key: _scannerKey,
          controller: cameraController,
          onDetect: (capture) async {
            if (isProcessingQR) return; // Prevent multiple scans
            isProcessingQR = true;
            
            try {
              final barcode = capture.barcodes.first;

              final source = context.read<WalletDataSource>();
              final cards = await source.readAll();

              final attributes = cards.first.attributes;
              if (barcode.rawValue != null) {
                // Stop the camera before navigating
                await cameraController.stop();
                
                await Navigator.pushNamed(
                  context,
                  WalletRoutes.verifyChooseWalletRoute,
                  arguments: barcode.rawValue!, // Pass the QR code URL as an argument
                );
                
                // Restart camera after returning from the choose wallet screen
                if (mounted) {
                  _initializeCamera();
                }
              }
            } catch (e) {
              print('Error scanning QR code: $e');
              // Optionally show an error message to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error scanning QR code: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            } finally {
              isProcessingQR = false;
            }
          },
          errorBuilder: (context, error, child) {
            return Center(
              child: Text(
                'Error: ${error.toString()}',
                style: context.textTheme.bodyLarge,
              ),
            );
          },
        ),
        _buildOverlay(context),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: context.mediaQuery.padding.top + 56,
              right: 8,
            ),
            child: IconButton(
              icon: Icon(
                isTorchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
              ),
              onPressed: _toggleTorch,
            ),
          ),
        ),
      ],
    );
  }
}
