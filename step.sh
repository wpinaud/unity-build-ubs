#!/bin/bash

if [ "$clean" = "true" ]; then
    rm -rf $project_path/Library $project_path/Temp $project_path/obj
    echo "Cleaned build data"
fi

if [ "$(uname)" == "Darwin" ]; then
    /Applications/Unity/Unity.app/Contents/MacOS/Unity -logfile -quit -batchmode -nographics \
        -executeMethod UBS.UBSProcess.BuildFromCommandLine \
        -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
        -jdk-path=$JAVA_HOME \
        -projectPath $project_path \
        -collection=$build_collection
else
    xvfb-run -a -n 55 -s "-screen 0 800x600x24 -ac +extension GLX +render -noreset" \
        /opt/Unity/Editor/Unity -logfile -quit -batchmode -nographics -force-opengl \
            -executeMethod UBS.UBSProcess.BuildFromCommandLine \
            -android-ndk=$android_ndk_home -android-sdk=$ANDROID_HOME \
            -jdk-path=$JAVA_HOME \
            -projectPath $project_path \
            -collection=$build_collection
fi
