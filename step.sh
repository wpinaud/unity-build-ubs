#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    /Applications/Unity/Unity.app/Contents/MacOS/Unity -logfile -quit -batchmode -nographics \
        -buildTarget android \
        -executeMethod LiveLike.UnityCloudBuildPrepare.BuildFromCommandLine \
        -projectPath "$project_path" \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -jdk-path=$JAVA_HOME \
        -configurationAssetPath="Assets/AllConfigurationFiles/FOXSportsVR/rsn_test_QA_Cardboard.asset" \

else
    xvfb-run -a -n 55 -s "-screen 0 800x600x24 -ac +extension GLX +render -noreset" \
        /opt/Unity/Editor/Unity -logfile -quit -batchmode -nographics -force-opengl \
            -buildTarget android \
            -executeMethod LiveLike.UnityCloudBuildPrepare.BuildFromCommandLine \
            -projectPath "$project_path" \
            -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
            -jdk-path=$JAVA_HOME \
            -configurationAssetPath="Assets/AllConfigurationFiles/FOXSportsVR/rsn_test_QA_Cardboard.asset" \

fi
