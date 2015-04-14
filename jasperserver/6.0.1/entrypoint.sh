#!/bin/bash
set -e

setup_jasperserver() {
    DB_TYPE=${DB_TYPE:-mysql}
    DB_USER=${DB_USER:-root}
    DB_PASSWORD=${DB_PASSWORD:-mysql}

    pushd /usr/src/jasperreports-server/buildomatic
    cp sample_conf/${DB_TYPE}_master.properties default_master.properties
    sed -i -e "s|^appServerDir.*$|appServerDir = $CATALINA_HOME|g; s|^dbHost.*$|dbHost=$MYSQL_PORT_3306_TCP_ADDR|g; s|^dbUsername.*$|dbUsername=$DB_USER|g; s|^dbPassword.*$|dbPassword=$DB_PASSWORD|g" default_master.properties

    for i in $@; do
        ./js-ant $i
    done

    popd
}

run_jasperserver() {
    if [ ! -d "$CATALINA_HOME/webapps/jasperserver" ]; then
        setup_jasperserver deploy-webapp-ce
    fi

    catalina.sh run
}

seed_database() {
    setup_jasperserver create-js-db init-js-db-ce import-minimal-ce
}

seed_and_run() {
    if [ ! -d "$CATALINA_HOME/webapps/jasperserver" ]; then
        setup_jasperserver create-js-db init-js-db-ce import-minimal-ce deploy-webapp-ce
    fi

    catalina.sh run
}

case "$1" in
    run)
        shift 1
        run_jasperserver "$@"
        ;;
    seed)
        seed_database
        ;;
    seedAndRun)
        seed_and_run
        ;;        
    *)
        exec "$@"
esac
