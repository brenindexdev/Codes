<?php
    define('DB_SERVIDOR','localhost');
    define('DB_USUARIO','root');
    define('DB_SENHA','');
    define('DB_BANCO','loja_miniaturas');

    $dbc = @mysqli_connect(DB_SERVIDOR,
        DB_USUARIO, DB_SENHA, DB_BANCO) or die
        ('Não foi possível conectar ao MySQL: ' .
        mysqli_connect_error());
    ?>