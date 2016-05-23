## README

## DEPLOYMENT
* Log in to server
```
ssh root@45.55.54.139
password: khalsa1234
```

* Moves to app folder project:
```  cd /var/apps/khasa-erp/ ```

* Update code from origin/master:
```
  git pull deloyed master
  ```

* Update database: (if we make changes on DB)
```
  RAILS_ENV=production rake db:migrate
  ```

* Precompile Assets (when we have new css or js file)
```
  RAILS_ENV=production rake assets:precompile
  ```

* Stop port 80:
```
  bundle exec passenger stop -p80
```

* Start point 80:
```
  bundle exec passenger start -p80 -d -e production
```
