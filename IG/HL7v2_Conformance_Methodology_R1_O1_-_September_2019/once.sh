#!/bin/bash
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -jar framework/ant/ant-launcher.jar -d -v -buildfile framework/build.xml -DupdatePublisher=N