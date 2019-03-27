read_var() {
    VAR=$(grep $1 $2 | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}
CONTAINER=$(read_var MYSQL_CONTAINER_NAME .env)
DATABASE=$(read_var MYSQL_DATABASE .env)
PASSWORD=$(read_var MYSQL_ROOT_PASSWORD .env)

cat backup.sql | docker exec -i $CONTAINER /usr/bin/mysql -u root --password=$PASSWORD $DATABASE
