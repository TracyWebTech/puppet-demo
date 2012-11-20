node default  {
  include pythonbrasil
}

node "agent1.tracy.com.br" inherits default { # MySQL
  include pythonbrasil::bd
}

node "agent2.tracy.com.br", "agent3.tracy.com.br" inherits default {
  include pythonbrasil::site
}

node "agent4.tracy.com.br" inherits default {
  include pythonbrasil::proxy
}