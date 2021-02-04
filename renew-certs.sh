
#!/bin/bash
certpath="/etc/letsencrypt/archive/elastic-stack-dev.devopslearning.xyz"
elkcertpath="/devops/docker-compose/elk_stack"

for server in `cat hosts.txt` # file with hostnames of remote servers to renew the certificates
do
    log="/tmp/$server.log"
    echo "Cert renew in progress please wait..."
    ssh ctbadmin@$server -p $password "
                newpath=""
                sudo certbot renew;
                if [ $newpath == "-dev" ]
                    docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/privkey1.pem master-es-c2:/etc/$process/ssl/c1/
                    docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/fullchain1.pem master-es-c2:/etc/$process/ssl/c1/
                    echo "Remote cluster communication cert renew successfull!"
                else
                    echo "Remote cluster communication cert renew failed!"
                fi
                for process in elasticsearch kibana
                do
                    cp $certpath/cert2.pem $elkcertpath/$process/ssl/elastic-stack$newpath.devopslearning.xyz/cert1.pem
                    cp $certpath/chain2.pem $elkcertpath/$process/ssl/elastic-stack$newpath.devopslearning.xyz/chain1.pem
                    cp $certpath/fullchain2.pem $elkcertpath/$process/ssl/elastic-stack$newpath.devopslearning.xyz/fullchain1.pem
                    cp $certpath/privkey2.pem $elkcertpath/$process/ssl/elastic-stack$newpath.devopslearning.xyz/privkey1.pem
                    for container in master-es-c2 node-1-es-c2 node-2-es-c2 kibana-c2
                    do
                        if [ $process == "elasticsearch" ]
                        then
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/privkey1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/chain1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/fullchain1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/cert1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker exec -ti $container "chown -R $process:$process /etc/$process && service $process restart"
                        elif [ $process == "kibana" ]
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/privkey1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/chain1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/fullchain1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker cp $elkcertpath/elasticsearch/ssl/elastic-stack$newpath.devopslearning.xyz/cert1.pem $container:/etc/$process/ssl/elastic-stack$newpath.devopslearning.xyz/
                            docker exec -ti $container "chown -R $process:$process /etc/$process && service $process restart"
                        else
                            echo "Something went wrong with copying certificates to the containers"
                        fi
                    done
                done
                newpath="-dev";" >> $log
done
echo "Check logs at /tmp."
