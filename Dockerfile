# Use the official Tomcat image as the base
FROM tomcat:9.0

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the generated WAR file to the Tomcat webapps directory
COPY target/comp367-maven-webapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
