<?php
$titulo = "Loja de Livros";

require_once("include/conexao.php");
include_once('includes/cabecalho_site.php');

//Ordena os destaques por preço
$ordenar = isset($_GET['ordenar']);
if ($ordenar == "") {
    $ordenar = "preco DESC";
} else {
    $ordenar = $_GET['ordenar'];
}

//Selecione as ofertas em destaque e ordena
$q = "SELECT * FROM livros
            WHERE destaque = 'S' 
            ORDER BY " . $ordenar;
$r = @mysqli_query($dbc, $q);
$total_registros = mysqli_num_rows($r);

?>

<script type="text/javascript">
    function ampliar_imagem(url, nome_janela, parametros) {
        window.open(url, nome_janela, parametros);
    }
</script>

<!-- Menu de Categorias -->
<div class="row">
    <?php include_once('includes/menu_categoria.php'); ?>
</div>

<!-- Decoração da Home Page -->
<div class="row">
    <div class="col-md-12">
        <img src="img/deco_home.jpg" class="img-fluid" width="1200px" />
    </div>
</div>

<!-- Quantidade de registros e ordenação -->
<div class="row">
    <div class="col-md-8">
        Destaques [Total de itens em destaque <?= $total_registros; ?> ]
    </div>
    <div class="col-md-4">
        Ordenar por:
        <?php if ($ordenar == "preco ASC") { ?>
            <span class="badge badge-primary">Menor preço</span>
            <a href="index.php?ordenar=preco DESC">Maior preço</a>
        <?php } else { ?>
            <a href="index.php?ordenar=preco ASC">Menor preço</a>
            <span class="badge badge-primary">Maior preço</span>
        <?php } ?>
    </div>

    <!-- Exibir itens -->

    <div class="row">
        <?php
        for ($contador = 0; $contador < $total_registros; $contador++) {
            $reg = @mysqli_fetch_array($r, MYSQLI_ASSOC);
            $codigo = $reg['codigo'];
            $nome = $reg['nome'];
            $estoque = $reg['estoque'];
            $min_estoque = $reg['min_estoque'];
            $preco = $reg['preco'];
            $desconto = $reg['desconto'];
            //$foto = $reg['foto'];
            $valor_desconto = $preco - ($preco * $desconto / 100);
        ?>
            <div class="col-md-6">
                <div class="row mt-3">
                    <div class="col-md-4">

                        <a href="#"
                            onclick="ampliar_imagem('ampliar.php?codigo=<?= $codigo; ?>&nome=<?= $nome; ?>', '', 'width=530,height=350,top=50,left=50')">
                            <img src="produtos/<?= $codigo; ?>.jpg"
                                class="img-fluid" width="100px" />
                            <br />
                            <img src="img/btn_ampliar1.gif" />
                        </a>
                    </div>
                    <div class="col-md-8">
                        <b><?= $nome; ?></b>
                        <?php if ($estoque < $min_estoque) { ?>
                            <img src="img/btn_detalhes_nd.gif"
                                class="float-right" />
                        <?php } ?>
                        <br />
                        <s>de R$ <?php echo
                                    number_format($preco, 2, ',', '.'); ?></s>
                        <br />
                        Por: <?php echo
                                number_format($valor_desconto, 2, ',', '.'); ?></s>
                        <br />
                        <a href="detalhes.php?produto=<?= $codigo; ?>" class="btn btn-sm btn-success">
                            Mais detalhes </a>
                    </div>
                </div>
            </div>

        <?php
        }
        include_once('includes/rodape.php');
        ?>