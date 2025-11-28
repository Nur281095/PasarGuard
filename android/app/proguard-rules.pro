# ========================================
# 🔥 Firebase Crashlytics ProGuard Rules
# ========================================
# Keep file names and line numbers for better crash reports
-keepattributes SourceFile,LineNumberTable

# Keep custom exceptions for readable crash reports
-keep public class * extends java.lang.Exception

# Keep Crashlytics annotations
-keepattributes *Annotation*

# 🔥 CRITICAL: Prevent obfuscation of stack trace class names
# This ensures crash reports show real class names, not obfuscated ones
-keepnames class ** { *; }

# ========================================
# Flutter Specific Rules
# ========================================
# Keep Flutter engine classes
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# Keep Flutter plugins
-keep class io.flutter.plugins.** { *; }

# ========================================
# Firebase Rules
# ========================================
# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep Firebase Analytics
-keep class com.google.firebase.analytics.** { *; }

# Keep Firebase Crashlytics (essential for crash reporting)
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Keep Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# ========================================
# Kotlin Rules
# ========================================
# Keep Kotlin metadata for better debugging
-keep class kotlin.Metadata { *; }
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}

# ========================================
# Android Warnings (Suppress)
# ========================================
-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
-dontwarn com.google.errorprone.annotations.CheckReturnValue
-dontwarn com.google.errorprone.annotations.Immutable
-dontwarn com.google.errorprone.annotations.RestrictedApi
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
-dontwarn org.bouncycastle.jce.provider.BouncyCastleProvider
-dontwarn org.bouncycastle.pqc.jcajce.provider.BouncyCastlePQCProvider

# Keep XML parser
-keep class org.xmlpull.v1.** { *; }

# ========================================
# Optimization Settings
# ========================================
# Standard optimizations (safe for most apps)
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-optimizationpasses 5
-allowaccessmodification
-dontpreverify

# Remove logging in release builds (optional - uncomment if desired)
# -assumenosideeffects class android.util.Log {
#     public static *** d(...);
#     public static *** v(...);
#     public static *** i(...);
# }





