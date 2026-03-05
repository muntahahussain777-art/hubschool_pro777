# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Supabase / Ktor / OkHttp
-keep class io.github.jan.supabase.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# SQLite / Drift
-keep class com.tekartik.** { *; }
-keep class org.sqlite.** { *; }

# Google Fonts
-keep class com.google.** { *; }

# WorkManager
-keep class androidx.work.** { *; }

# local_auth (biometric)
-keep class androidx.biometric.** { *; }

# Kotlin serialization
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt

# PDF
-keep class com.tom_roush.pdfbox.** { *; }

# General
-keepattributes Signature
-keepattributes SourceFile, LineNumberTable
