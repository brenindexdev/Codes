<?php
    $cat = isset($_GET['cat_nome']) ? $_GET['cat_nome'] : 'Home';
?>
<div class="container">
    <div class="col-12">
        <ul class="nav nav-tabs justify-content-center">
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Home') 
                    echo "active"; ?>" href="index.php">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Ficção Científica') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=2&cat_nome=Ficção Científica&order=preco ASC">Ficção Científica</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Infantil') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=6&cat_nome=Infantil&order=preco ASC">Infantil</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Terror') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=4&cat_nome=Terror&order=preco ASC">Terror</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Fantasia') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=3&cat_nome=Fantasia&order=preco ASC">Fantasia</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Autobiografia') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=7&cat_nome=Autobiografia&order=preco ASC">Autobiografia</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Suspense') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=5&cat_nome=Suspense&order=preco ASC">Suspense</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($cat == 'Romance') 
                    echo "active"; ?>" 
                    href="categorias.php?cat_id=1&cat_nome=Romance&order=preco ASC">Romance</a>
                </li>
            </ul>
    </div>
</div>