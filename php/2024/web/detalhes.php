<?php
    $titulo = "Loja de Miniaturas - Detalhes";

    require_once('include/conexao.php');
    include_once('includes/cabecalho_site.php');

    $produto = $_GET['produto'];

    //Selecione as ofertas em destaque e ordena
    $q = "SELECT m.*, c.descricao
            FROM miniaturas m INNER JOIN categoria c
            ON m.id_categoria = c.id
            WHERE m.codigo = '" . $produto . "'";

    $r = @mysqli_query($dbc, $q);
    $reg = mysqli_fetch_array($r);

    $codigo = $reg["codigo"];
    $nome = $reg["nome"];
    $ano = $reg["ano"];
    $nome_cat = $reg["descricao"];
    $cat_sub = $reg["subcateg"];
    $preco = $reg["preco"];
    $desconto = $reg["desconto"];
    $desconto_boleto = $reg["desconto_boleto"];
    $max_parcelas = $reg["max_parcelas"];
    $escala = $reg["escala"];
    $peso = $reg["peso"];
    $comprimento = $reg["comprimento"];
    $largura = $reg["largura"];
    $altura = $reg["altura"];
    $cor = $reg["cor"];
    $estoque = $reg["estoque"];
    $min_estoque = $reg["min_estoque"];
    $credito = $reg["credito"];
    $valor_desconto = $preco - ($preco * $desconto) / 100;
    $valor_boleto = $valor_desconto - 
        ($valor_desconto * $desconto_boleto) / 100;
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

<!-- Título da Página -->
<h4>Detalhes - <?= $nome_cat; ?> - <?= $nome; ?></h4>

<div class="row">
    <div class="col-md-3">
        <a href="#"><img src="produtos/<?= $codigo; ?>G.jpg" 
            class="img-fluid"
            onclick="ampliar_imagem('ampliar.php?codigo=<?= $codigo; ?>&nome=<?= $nome; ?>', '',
            'width=530,height=350,top=50,left=50')" /><br />
            <img src="img/btn_ampliar1.gif" />
    </a>
        <h5>Dados técnicos</h5>
        Código: <b><?= $codigo; ?></b><br />
        Categoria: <b><?= $nome_cat; ?></b><br />
        Tipo: <b><?= $cat_sub; ?></b><br />
        Ano: <b><?= $ano; ?></b><br />
        Escala: <b><?= $escala; ?></b><br />
        Peso: <b><?= $peso; ?></b><br />
        Cor: <b><?= $cor; ?></b><br />
        Dimensões: <b>(C x L x A):</b><br />
        <?php echo number_format($comprimento, 1, ',', '.'); ?>
        x 
        <?php echo number_format($largura, 1, ',', '.'); ?>
        x
        <?php echo number_format($altura, 1, ',', '.'); ?>
        <h6>Credito da Imagem</h6>
        <?= $credito; ?>
    </div>
    <div class="col-md-9 jumbotron">
        <div class="row">
            <div class="col-md-10">
                <h3><b><?= $nome; ?></b></h3>
                <s>de R$ <?php echo number_format($preco,
                2, ',', '.'); ?></s><br />
                <h4>Por: <b>R$ <?php echo number_format(
                    $valor_desconto,2, ',', '.'); ?></b>
                </h4>
            </div>
            <div class="col-md-2">
                <?php if ($estoque > $min_estoque) { ?>
                    <a href="cesta.php?produto=<?= $codigo;
                     ?>&inserir=S" class="btn btn-success">
                     Comprar</a>
                <?php } else { ?>
                    <img src="img/btn_detalhes_nd.gif" />
                <?php } ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <b>
                    Parcelamento no cartão de crédito
                </b>
            </div>
        </div>

        <?php 
            $col_esq = '';
            $col_dir = '';
            for ($contador = 1; 
                    $contador <= $max_parcelas; 
                    $contador++) {
                        if ($contador % 2 == 1)
                        $col_esq .= $contador . ' x de R$ ' .
                        number_format($valor_desconto/$contador,
                        2, ',', '.') . ' sem juros.<br />';
                        else
                        $col_dir .= $contador . ' x de R$ ' .
                        number_format($valor_desconto/$contador,
                        2, ',', '.') . ' sem juros.<br />';
                    }
        ?>

        <div class="row">
            <div class="col-md-6">
                <?= $col_esq; ?>
            </div>
            <div class="col-md-6">
                <?= $col_dir; ?>
            </div>
        </div>
        
        <br />
        <div class="row">
            <div class="col-md-12">
                *Pague com Boleto Bancário e ganhe 
                +<?php echo number_format("$desconto_boleto",
                2, ',', '.'); ?>% de desconto: 
                <b>R$ <?php echo number_format("$valor_boleto",
                2, ',', '.'); ?>.</b><br />
                *Este produto pode ser pago com cartão de 
                crédito em até <b><?= $max_parcelas; ?></b>
                 parcelas.<br /><br />

                 <b>Formas de pagamento </b>
                 <img src="img/banner_formapag.jpg" />
                 <br /><br />

                 <b>Formas de entrega</b><br />
                 2 dias úteis para o estado de São Paulo.<br />
                 5 dias úteis para os demais estados.<br />
                <br />
                <b>Observações</b><br />
                As mercadorias adquirdas serão despachadas, via 
                Sedex, no primeiro dia útil após a comprovação 
                de pagamento, estado a entrega condiciona à 
                disponibilidade de estoque.

            </div>
        </div>

    </div>
</div>

<?php  
 include_once('includes/rodape.php');
 ?>