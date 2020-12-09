# HTTPS server
server {
	listen 443;
 
	server_name api.icecondor.com;

        root /home/devops/web/build;
	index index.html index.htm;

	ssl on;
	ssl_session_timeout 5m;
        ssl_certificate /root/lego/certificates/api.icecondor.com.crt;
        ssl_certificate_key /root/lego/certificates/api.icecondor.com.key;

        # https://cipherli.st/

        location /v2 {
          proxy_pass http://localhost:2040;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_read_timeout 90s;
        }

        location /v2s {
          proxy_pass http://localhost:2041;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_read_timeout 90s;
        }

        location /rest/activity/add {
          proxy_pass http://localhost:9370;
        }
}
