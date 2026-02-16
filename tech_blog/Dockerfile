FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# وابستگی‌ها
RUN apt-get update && apt-get install -y \
    curl unzip git wget zip xz-utils \
    libglu1-mesa \
    openjdk-17-jdk \
    && apt-get clean

# Flutter
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$PATH"

# Android SDK
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

RUN mkdir -p $ANDROID_HOME/cmdline-tools && \
    cd $ANDROID_HOME/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip commandlinetools-linux-*.zip && \
    mv cmdline-tools latest && \
    rm commandlinetools-linux-*.zip

# نصب پکیج‌های Android
RUN yes | sdkmanager --licenses && \
    sdkmanager \
      "platform-tools" \
      "platforms;android-34" \
      "build-tools;34.0.0"

# بررسی نهایی
RUN flutter doctor -v
