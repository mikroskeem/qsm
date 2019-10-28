jvm=/usr/lib/jvm/java-8-openjdk/bin/java
jvm_args="-Xms6G -Xmx6G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -Dfml.readTimeout=180"

server_dir=/home/mark/mcserver
server_jar=server.jar
server_args="nogui"

#stop_command="stop"

# vim: ft=sh: et: sw=4: sts=4
