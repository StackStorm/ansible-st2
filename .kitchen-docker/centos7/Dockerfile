FROM stackstorm/packagingtest:centos7

RUN echo '<%= IO.read(@public_key).strip %>' >> /root/.ssh/authorized_keys
