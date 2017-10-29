#!/bin/bash

# Build up array of extra arguments
args=()
[[ "$is_ios" == "true" ]] && args+=('-isIos')
[[ "$vr_enabled" == "true" ]] && args+=('-vrEnabled')

if [ "$(uname)" == "Darwin" ]; then
    /Applications/Unity/Unity.app/Contents/MacOS/Unity -logfile -quit -batchmode -nographics \
        -buildTarget $build_target \
        -executeMethod LiveLike.UnityCloudBuildPrepare.BuildFromCommandLine \
        -projectPath "$project_path" \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -jdk-path=$JAVA_HOME \
        -configurationAssetPath="$configuration_asset_path" \
        "${args[@]}"

else
    sudo xvfb-run -a -n 55 -s "-screen 0 800x600x24 -ac +extension GLX +render -noreset" \
        /opt/Unity/Editor/Unity -logfile -quit -batchmode -nographics -force-opengl \
            -buildTarget $build_target \
            -executeMethod LiveLike.UnityCloudBuildPrepare.BuildFromCommandLine \
            -projectPath "$project_path" \
            -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
            -jdk-path=$JAVA_HOME \
            -configurationAssetPath="$configuration_asset_path" \
            "${args[@]}"
fi
