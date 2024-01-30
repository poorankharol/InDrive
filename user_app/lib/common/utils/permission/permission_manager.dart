import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../extensions/build_context_extensions.dart';
import '../../navigation/navigation_service.dart';

/// Class for managing permissions.
sealed class PermissionManager {
  ///Requesting a Permission.
  static Future<bool> requestPermission(
      Permission permission, String permissionRequiredDescription) async {
    try {
      ///Step 1:- Check the current permission status.
      var isPermissionGranted = await checkPermissionStatus(permission);

      ///Step 2:- If not granted,request the permission.
      if (!isPermissionGranted) {
        var result = await permission.request();

        ///Step 3:- Return true if permission is granted.
        if (result == PermissionStatus.granted) {
          return true;
        } else if (result == PermissionStatus.denied) {
          ///Step 4:- Check if explanation is required for requesting the permission.
          final showRationale = await shouldShowRationale(permission);

          ///Step 5:- Show Dialog if required.
          if (showRationale) {
            final isAllowed = await _showExplanationDialog(
                permission, permissionRequiredDescription);
            if (isAllowed) {
              requestPermission(permission, permissionRequiredDescription);
            } else {
              return false;
            }
          }
        } else if (result == PermissionStatus.permanentlyDenied) {
          ///Step 6:- Open Settings for requesting permission.
          final didOpenSettings =
              await _showPermanentlyDeniedDialog(permissionRequiredDescription);
          if (didOpenSettings) {
            await openAppSettings();
          } else {
            return false;
          }
          //final didOpenSettings = await openAppSettings();
          //return didOpenSettings;
        }
      } else {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Retrieves the current status of a specified permission.
  static Future<bool> checkPermissionStatus(Permission permission) async {
    return await permission.status.isGranted;
  }

  /// Determines if the system recommends displaying an explanation for requesting the permission(It will always return false for iOS).
  static Future<bool> shouldShowRationale(Permission permission) async {
    return await permission.shouldShowRequestRationale;
  }

  /// Presents an alert dialog to explain why the permission is needed.
  static Future<bool> _showExplanationDialog(
      Permission permission, String permissionRequiredDescription) async {
    var context = NavigationService.navigatorKey.currentContext;

    if (context != null) {
      final explanationDialog = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.appLocale.permissionRequired),
          content: Text(permissionRequiredDescription),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.appLocale.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(context.appLocale.allow),
            ),
          ],
        ),
      );
      return explanationDialog;
    } else {
      return false;
    }
  }

  /// Shows a dialog explaining a permanently denied permission and offers to go to settings.
  static Future<bool> _showPermanentlyDeniedDialog(
      String permissionRequiredDescription) async {
    var context = NavigationService.navigatorKey.currentContext;

    if (context != null) {
      final explanationDialog = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.appLocale.permissionRequired),
          content: Text(
              "$permissionRequiredDescription\n${context.appLocale.permissionDenied}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.appLocale.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(context.appLocale.goToSettings),
            ),
          ],
        ),
      );
      return explanationDialog;
    } else {
      return false;
    }
  }
}
