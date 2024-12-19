<?php
$dbc = @mysqli_connect('localhost', 'root', '', 'lojalivros')
    OR die('Erro ao conectar ao MySQL: ' . mysqli_connect_error());
?>
