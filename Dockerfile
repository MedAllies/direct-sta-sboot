FROM openjdk:8u282-jre

# When build images, name with this tag
LABEL tag=sta

# Build arguments
ARG BUILD_VERSION=6.0.1

# Create and use local user and group
RUN addgroup direct && adduser direct --ingroup direct

# Set application location
RUN mkdir -p /opt/app
RUN chown direct:direct /opt/app
ENV PROJECT_HOME /opt/app

# Set microservice
ENV SERVICE_PORT=8083
ENV SERVICE_USERNAME=admin
ENV SERVICE_PASSWORD=direct

# Set config-service access
ENV CONFIG_SERVICE_HOST=config-service
ENV CONFIG_SERVICE_PORT=8082

# Set msg-monitor access
ENV MSG_MONITOR_HOST=msg-monitor
ENV MSG_MONITOR_PORT=8081

# Set XD access
ENV XD_HOST=xd
ENV XD_PORT=8087

# Set RabbitMQ env variables
ENV RABBIT_MQ_HOST=rabbitmq
ENV RABBIT_MQ_PORT=5672
ENV RABBIT_MQ_USERNAME=guest
ENV RABBIT_MQ_PASSWORD=guest

# Use local user and group
USER direct:direct

# Copy application artifact
COPY application.properties $PROJECT_HOME/application.properties
COPY target/direct-sta-sboot-$BUILD_VERSION.jar $PROJECT_HOME/sta.jar

# Switching to the application location
WORKDIR $PROJECT_HOME

# Run application
CMD ["java","-jar","./sta.jar"]
