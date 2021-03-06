FROM jboss/keycloak:3.0.0.Final

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main
ADD dependencies/postgresql-9.3-1102-jdbc3.jar /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main/

ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main/

ADD standalone.xml /opt/jboss/keycloak/standalone/configuration/

ADD dependencies/cedar-keycloak-event-listener-jar-with-dependencies.jar /opt/jboss/keycloak/providers/

ADD themes/cedar /opt/jboss/keycloak/themes/

RUN mkdir -p /opt/jboss/realm-import
ADD cedar.realm.json /opt/jboss/realm-import/

ADD docker-entrypoint.sh /opt/jboss/

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0", "-Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.file=/opt/jboss/realm-import/cedar.realm.json -Dkeycloak.migration.realmName=CEDAR -Dkeycloak.migration.strategy=IGNORE_EXISTING"]