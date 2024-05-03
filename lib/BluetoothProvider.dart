import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider extends ChangeNotifier {
  final FlutterBlue flutterBlue; 

  BluetoothProvider(this.flutterBlue);
  BluetoothDevice? _scannedDevice;
  BluetoothDevice? _connectedDevice;
  bool _isConnecting = false;

  BluetoothDevice? get scannedDevice => _scannedDevice;
  BluetoothDevice? get connectedDevice => _connectedDevice;
  bool get isConnecting => _isConnecting;

  BluetoothCharacteristic? get txCharacteristic => null;

  set scannedDevice(BluetoothDevice? device) {
    _scannedDevice = device;
    notifyListeners();
  }

  Future<void> connectToDevice() async {
    if (_scannedDevice != null && !_isConnecting) {
      _isConnecting = true;
      notifyListeners();
      try {
        await _scannedDevice!.connect();
        _connectedDevice = _scannedDevice;
      } catch (e) {
        print('Error connecting to device: $e');
      } finally {
        _isConnecting = false;
        notifyListeners();
      }
    }
  }

  // Method to send a message to the connected Bluetooth device
  Future<void> sendMessage(String message) async {
    // Check if a device is connected
    if (connectedDevice != null) {
      // Get the characteristics of the connected device
      List<BluetoothService> services = await connectedDevice!.discoverServices();
      services.forEach((service) {
        service.characteristics.forEach((characteristic) async {
          // Check if the characteristic supports writing
          if (characteristic.properties.write) {
            // Write the message to the characteristic
            await characteristic.write(utf8.encode(message));
          }
        });
      });
    }
  }

  // Method to listen for incoming messages from the connected Bluetooth device
void listenForMessages() async {
  // Continuously listen for incoming messages
  while (true) {
    // Check if a device is connected
    if (connectedDevice != null) {
      // Get the characteristics of the connected device
      List<BluetoothService> services = await connectedDevice!.discoverServices();
      for (BluetoothService service in services) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          // Check if the characteristic supports reading
          if (characteristic.properties.read) {
            try {
              // Read the value of the characteristic
              List<int> value = await characteristic.read();
              String receivedMessage = utf8.decode(value);
              print("Received message: $receivedMessage");
              // Check if the received message is "Hi Noqta"
              if (receivedMessage == "Hi Noqta") {
                // Handle the received message as needed
              }
            } catch (e) {
              print("Error reading characteristic: $e");
            }
          }
        }
      }
    }
    // Delay before checking for messages again
    await Future.delayed(Duration(seconds: 1));
  }
}

  Future<void> disconnectFromDevice() async {
    if (_connectedDevice != null) {
      try {
        await _connectedDevice!.disconnect();
        flutterBlue.stopScan();
        _connectedDevice = null;
      } catch (e) {
        print('Error disconnecting from device: $e');
      }
    }
  }
}
