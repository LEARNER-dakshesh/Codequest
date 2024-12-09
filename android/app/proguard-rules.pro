# Flutter rules
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep public class * extends android.app.Activity
-keepattributes *Annotation*

# Firebase rules
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keepclassmembers class * {
    @com.google.firebase.** *;
}

# Gson rules (if using Firebase Firestore or other JSON parsing)
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Kotlin rules
-keepclassmembers class kotlin.** { *; }
-dontwarn kotlin.**

# Android support library rules
-dontwarn android.support.v4.**
-dontwarn android.support.v7.**
-keep class android.support.** { *; }

# Suppress warnings for generated code (optional)
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
