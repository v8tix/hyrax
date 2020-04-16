FROM v8tix/cronov:0.0.7.v20200416.657046f
LABEL MAINTAINER="V8TIX"
LABEL MAIL="info@v8tix.com"
ADD packages /home/v8tix/packages
RUN ["/bin/bash", "-c", "chmod +x -R /home/v8tix/packages"]
RUN ["/bin/bash", "-c", "/home/v8tix/packages/packages.sh"]
RUN ["/bin/bash", "-c", "/home/v8tix/libraries/zemni/execution/microservice/go/go.sh"]
RUN ["/bin/bash", "-c", "/home/v8tix/libraries/zemni/system/sec/remove_all_perm.sh"]
RUN ["/bin/bash", "-c", "/home/v8tix/libraries/zemni/system/cleanup/cleanup.sh"]
USER v8tix:v8tix
ADD --chown=v8tix:v8tix entrypoint /home/v8tix/entrypoint/
ENTRYPOINT ["/home/v8tix/entrypoint/entrypoint.sh"]