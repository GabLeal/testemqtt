package com.example.prevent

import be.tramckrijte.workmanager.WorkmanagerPlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.view.FlutterMain

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        WorkmanagerPlugin.setPluginRegistrantCallback(this)
        FlutterMain.startInitialization(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (!registry!!.hasPlugin("be.tramckrijte.workmanager")) {
            WorkmanagerPlugin.registerWith(registry!!.registrarFor("com.example.prevent"));

        }

    }
}