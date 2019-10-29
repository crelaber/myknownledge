雨燕部署脚本

#!/bin/bash -ile
domain_name='xxx.abc.com'
app_dir=/data/web

if [ "$status" == "deploy" ]; then
  #rm -Rf vendor
  #composer install
  for i in $(echo $hostlist | sed 's/,/ /g'); do
    x=$(echo $i | awk -F\: '{print $2}')
    echo $x
    ssh work@$x "mkdir -p ${app_dir}/${domain_name}/releases/${GIT_BRANCH}/sspapi"
    rsync -az ../${JOB_NAME#*/}/ --exclude .git --exclude .gitignore work@$x:${app_dir}/${domain_name}/releases/${GIT_BRANCH}/sspapi
    ssh work@$x "rm -rf ${app_dir}/${domain_name}/current/sspapi"
    ssh work@$x "ln -s ${app_dir}/${domain_name}/releases/${GIT_BRANCH}/sspapi ${app_dir}/${domain_name}/current/sspapi"
    sleep 10
    ssh work@$x "sudo kill -USR2 \`cat /var/run/php-fpm/php-fpm.pid\`"
    #ssh work@$x "cd ${app_dir}/${domain_name}/releases && find . -maxdepth 1 -mtime +7 |sort -rn|xargs ls -t|sed -n '6,\$p'|xargs rm -rf"
  done
elif [ "$status" == "rollback" ]; then
  for i in $(echo $hostlist | sed 's/,/ /g'); do
    x=$(echo $i | awk -F\: '{print $2}')
    echo $x
    num=$(ssh work@$x "ls ${app_dir}/${domain_name}/releases| grep "${GIT_BRANCH}"|wc -l")
    if [ ${num} == "1" ]; then
      ssh work@$x "rm -rf ${app_dir}/${domain_name}/current/sspapi"
      ssh work@$x "ln -s ${app_dir}/${domain_name}/releases/${GIT_BRANCH}/sspapi ${app_dir}/${domain_name}/current/sspapi"
      sleep 10
      ssh work@$x "sudo kill -USR2 \`cat /var/run/php-fpm/php-fpm.pid\`"
    else
      echo "no ${GIT_BRANCH} on server!"
      exit 1
    fi
  done
fi


