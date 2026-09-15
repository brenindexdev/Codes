<?php
    $titulo = $_GET['nome'];
    $codigo = $_GET['codigo'];
?>

<div class="row">
    <div class="col-md-12">
        <?= $titulo; ?>
</div>

<div class="row">
    <div class="col-md-12">
        <img src="produtos/<?= $codigo; ?>G.jpg"
            class="img-fluid" />
</div>





