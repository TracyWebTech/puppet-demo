node default  {
}

node "puppet1.tracy.com.br" inherits default { # MySQL
  include pythonbrasil::bd
}

node "puppet2.tracy.com.br", "puppet3.tracy.com.br" inherits default {
  include pythonbrasil::site
}

node "puppet4.tracy.com.br" inherits default {
  include pythonbrasil::proxy
}
