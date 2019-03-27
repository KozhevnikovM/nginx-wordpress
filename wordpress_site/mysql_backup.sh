read_var() {
    VAR=$(grep $1 $2 | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}
CONTAINER=$(read_var MYSQL_CONTAINER_NAME .env)
DATABASE=$(read_var MYSQL_DATABASE .env)
PASSWORD=$(read_var MYSQL_ROOT_PASSWORD .env)
docker exec $CONTAINER /usr/bin/mysqldump -u root --password=$PASSWORD $DATABASE > backup.sql
