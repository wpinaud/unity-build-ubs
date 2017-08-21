#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    /Applications/Unity/Unity.app/Contents/MacOS/Unity -logfile -quit -batchmode -nographics \
        -executeMethod UBS.UBSProcess.BuildFromCommandLine \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -projectPath $project_path \
        -collection=$build_collection
else
    xvfb-run -a -n 55 -s "-screen 0 800x600x24 -ac +extension GLX +render -noreset" \
        /opt/Unity/Editor/Unity -logfile -quit -batchmode -nographics -force-opengl \
            -executeMethod LiveLike.UnityCloudBuildPrepare.FoxCardboard \
            -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
            -projectPath $project_path \
            -collection=$build_collection
fi
