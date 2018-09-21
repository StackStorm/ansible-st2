FROM stackstorm/packagingtest:centos6-sshd

RUN mkdir -p /var/run/sshd
RUN useradd -d /home/<%= @username %> -m -s /bin/bash <%= @username %>
RUN echo <%= "#{@username}:#{@password}" %> | chpasswd
RUN echo '<%= @username %> ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /home/<%= @username %>/.ssh
RUN chown -R <%= @username %> /home/<%= @username %>/.ssh
RUN chmod 0700 /home/<%= @username %>/.ssh
RUN touch /home/<%= @username %>/.ssh/authorized_keys
RUN chown <%= @username %> /home/<%= @username %>/.ssh/authorized_keys
RUN chmod 0600 /home/<%= @username %>/.ssh/authorized_keys
RUN echo '<%= IO.read(@public_key).strip %>' >> /home/<%= @username %>/.ssh/authorized_keys

# yum output is too verbose (and includes expensive download progress bars)
# which tripped the travis log length limit for centos-6
RUN /bin/sed -i "s/^[#]*debuglevel=.*/debuglevel=1/" /etc/yum.conf
