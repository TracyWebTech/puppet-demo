Demonstração de uso do Puppet
===========

Máquinas utilizadas:
puppetmaster.tracy.com.br

default: User[pythonbrasil]
puppet1.tracy.com.br: MySQL Server
puppet2.tracy.com.br: Django + gunicorn + nginx
puppet3.tracy.com.br: Django + gunicorn + nginx
puppet4.tracy.com.br: NGINX FrontEND (Proxy)