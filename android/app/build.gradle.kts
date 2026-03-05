plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.hubschool.hubschool_pro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.hubschool.hubschool_pro"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            storeFile     = file("../hubschool_keystore.jks")
            storePassword = "hubschool2026"
            keyAlias      = "hubschool"
            keyPassword   = "hubschool2026"
        }
    }

    buildTypes {
        getByName("debug") {
            applicationIdSuffix = ".debug"
            isDebuggable = true
        }
        getByName("release") {
            signingConfig    = signingConfigs.getByName("release")
            isMinifyEnabled  = false
            isShrinkResources = false
        }
    }

    packaging {
        resources {
            pickFirsts.add("androidsupportmultidexversion.txt")
        }
    }
}

flutter {
    source = "../.."
}
