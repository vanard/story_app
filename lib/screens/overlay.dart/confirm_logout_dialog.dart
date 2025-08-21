import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/overlay_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';

class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.logoutButton,
        style: TextStyle().copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      content: Text(
        AppLocalizations.of(context)!.areYouSure,
        style: TextStyle().copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<OverlayProvider>().clearOverlay();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () async {
            context.read<AuthProvider>().logout();
            context.read<OverlayProvider>().clearOverlay();
            context.clearAndPushTo(LoginPageConfiguration());
          },
          child: Text(AppLocalizations.of(context)!.logoutButton),
        ),
      ],
    );
  }
}
