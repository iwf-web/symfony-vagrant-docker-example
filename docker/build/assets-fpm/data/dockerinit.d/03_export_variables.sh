# export variable to reuse in any cron....
ENVFILE=/usr/local/bin/iwfsfconsole.env

# add variables to .env file as needed (use tee -a to append, when needed)
echo "DATABASE_URL=\"${DATABASE_URL}\"" | sudo tee $ENVFILE >/dev/null
echo "APP_ENV=\"${APP_ENV}\"" | sudo tee -a $ENVFILE >/dev/null
