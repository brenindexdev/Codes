<?php
    $cat = isset($_GET['cat_nome']) ? $_GET['cat_nome'] : 'Home';
?>

<ul class="nav nav-tabs">
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Home') 
            echo "active"; ?>" href="index.php">Home</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Automóveis') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=2&cat_nome=Automóveis&order=preco ASC">Automóveis</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Aviões') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=6&cat_nome=Aviões&order=preco ASC">Aviões</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Caminhões') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=4&cat_nome=Caminhões&order=preco ASC">Caminhões</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Máquinas Pesadas') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=3&cat_nome=Máquinas Pesadas&order=preco ASC">Máquinas Pesadas</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Militares') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=7&cat_nome=Militares&order=preco ASC">Militares</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Motocicletas') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=5&cat_nome=Motocicletas&order=preco ASC">Motocicletas</a>
    </li>
    <li class="nav-item">
        <a class="nav-link <?php if ($cat == 'Ônibus') 
            echo "active"; ?>" 
            href="categorias.php?cat_id=1&cat_nome=Ônibus&order=preco ASC">Ônibus</a>
    </li>
</ul>