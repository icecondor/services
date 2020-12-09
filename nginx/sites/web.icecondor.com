# HTTPS server
server {
        #listen [::]:443;
        listen 443 ssl;
	server_name icecondor.com ipv6.icecondor.com www.icecondor.com;
        #rewrite_log on;
        #error_log /etc/wtf info;

	root /home/devops/web/build;
	index index.html index.htm;

	ssl_session_timeout 5m;
        ssl_certificate /root/lego/certificates/icecondor.com.crt;
        ssl_certificate_key /root/lego/certificates/icecondor.com.key;


	location / {
                rewrite ^/$ /dashboard.html;
                rewrite ^/auth/([^/]*)$ /auth.html;
                rewrite ^/(\w[\w-]+)$ /map.html;
                rewrite ^/(\w[\w-]+)/(\w+)$ /$2.html;
                rewrite ^/(\w[\w-]+)/(\w+)/([-\w]+)$ /$2.html;

                rewrite ^/p/([A-Za-z-]+)$ /p/$1.html;
 
		try_files $uri $uri/ =404;
	}

        location /sockjs {
          proxy_pass http://localhost:9360;
        }

        location ~* /sockjs/.*/websocket {
          proxy_pass http://localhost:9360;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~* ^/(\w[\w-]+).json$ {
          default_type 'application/json';
          add_header "Access-Control-Allow-Origin"  *;
          content_by_lua_file /etc/nginx/lua/icws.lua;
        }
}
