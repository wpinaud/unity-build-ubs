#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    /Applications/Unity/Unity.app/Contents/MacOS/Unity -logfile -quit -batchmode -nographics \
        -executeMethod UBS.UBSProcess.BuildFromCommandLine \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -projectPath $project_path \
        -collection=$build_collection
else
    xvfb-run /opt/Unity/Editor/Unity -logfile -quit -batchmode -force-opengl \
        -executeMethod UBS.UBSProcess.BuildFromCommandLine \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -projectPath $project_path \
        -collection=$build_collection
fi