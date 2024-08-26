<?php
    $titulo = "Loja de Miniaturas - Cesta de Compras";

    require_once('include/conexao.php');
    include_once('includes/cabecalho_site.php');

    $produto = isset($_GET['produto']) ? $_GET['produto'] : '';
    $inserir = isset($_GET['inserir']) ? $_GET['inserir'] : '';

    //qt = 1 default de quantidade
    $qt = 1;

    //Captur o ultimo ID da tabela pedido
    $sql = "SELECT id, status FROM pedidos ORDER BY id DESC";
    $rs = mysqli_query($dbc, $sql);
    $reg = mysqli_fetch_array($rs);
    $id = $reg['id'];
    $status = $reg['status'];
   
    //Insere um registro na tabela de pedideos com nº do pedido
    if (!isset($_SESSION['num_ped']) && $inserir == 'S') 
    {
        $id = $id + 1;
        //Prepara o numero do pedido: id, hora e primeiro minuto
        $num_ped = $id . "." . date("H") . substr(date("i"),0,1);
        $_SESSION['num_ped'] = $num_ped;
        $_SESSION['id_ped'] = $id;

        $_SESSION['num_boleto'] = $id . date("H") . 
            substr(date("i"),0,1);

        $sqli = "INSERT INTO pedidos (num_ped, status) 
            VALUES ('$num_ped','Em andamento')";
        mysqli_query($dbc, $sqli);
        
        $_SESSION['status'] = 'Em andamento';
    }

    //Excluir item da cesta de miniaturas
    $excluir = isset($_GET['excluir']) ? $_GET['excluir'] : '';
    $id = isset($_GET['id']) ? $_GET['id'] : '';

    if ($excluir == "S") 
    {
        $sqld = "DELETE FROM itens WHERE id = '" . $id . "' ";
        mysqli_query($dbc, $sqld);
    }

    //Selecione a miniatura
    $q = "SELECT m.*, c.descricao
            FROM miniaturas m INNER JOIN categoria c
            ON m.id_categoria = c.id
            WHERE m.codigo = '" . $produto . "'";

    $r = @mysqli_query($dbc, $q);
    $reg = mysqli_fetch_array($r);

    $codigo = $reg["codigo"];
    $nome = $reg["nome"];
    $preco = $reg["preco"];
    $desconto = $reg["desconto"];
    $desconto_boleto = $reg["desconto_boleto"];
    $peso = $reg["peso"];
    $valor_desconto = $preco - ($preco * $desconto) / 100;
    $valor_boleto = $valor_desconto - 
        ($valor_desconto * $desconto_boleto) / 100;
    $num_ped = $_SESSION['num_ped'];

    //Verifica se o item já se encontra na cesta
    $sql_dp = "SELECT codigo FROM itens 
        WHERE codigo = '" . $produto . "' AND num_ped = '" .
        $num_ped . "'";
    $rs_dp = mysqli_query($dbc, $sql_dp);
    //Caso nenhum registro seja encontrado, será igual 0
    //caso contrario será igual 1.
    $item_duplicado = mysqli_num_rows($rs_dp);

    //Adiciona o produto na tabela itens, se dup igual a 0
    if ($item_duplicado == 0 && $inserir == 'S') {
        $sqli = "INSERT INTO itens 
        (num_ped, codigo, nome, qt, preco, peso, preco_boleto,
        desconto, desconto_boleto)
        VALUES ('$num_ped', '$codigo', '$nome', '$qt', 
        '$preco', '$peso', '$valor_boleto', 
        '$desconto','$valor_desconto')";
        mysqli_query($dbc, $sqli);
    }

    //Atualiza itens do carrinho de acordo com os valores
    //digitados pelo usuário
    $atualiza = isset($_GET['atualiza']) ? 
            $_GET['atualiza'] : '';

    if ($atualiza == 'S') {
        for ($contador=1; $contador <= $_SESSION['total_itens'];
            $contador++) {
                $b[$contador] = $_POST['txt'.$contador];
                $c[$contador] = $_POST['id'.$contador];

                $sqla = "UPDATE itens SET qt = '" .
                    $b[$contador] . "' 
                    WHERE id = '" . $c[$contador] . "'";
                mysqli_query($dbc, $sqla);
            }
    }


    //Captura os itens adicionados ao carrinho para serem 
    //exibidos na página
    $sql = "SELECT * FROM itens 
        WHERE num_ped = '" . $num_ped . "'
        ORDER BY id";
    $rs = mysqli_query($dbc, $sql);
    $total_itens = mysqli_num_rows($rs);
    $_SESSION['total_itens'] = $total_itens;
?>

<script type="text/javascript">
    function ampliar_imagem(url, nome_janela, parametros) {
        window.open(url, nome_janela, parametros);
    }

    function valida_form() {
        <?php for ($contador=1; $contador <= $_SESSION['total_itens'];
            $contador++) { ?>
        
            if (document.cesta.txt<?= $contador; ?>.value < 1) {
                alert("O campo quantidade não pode ser menor que 1.");
                document.cesta.txt<?= $contador; ?>.focus();
                return false;
            }
        <?php } ?>        
    }
</script>

<!-- Menu de Categorias -->
<div class="row">
    <?php include_once('includes/menu_categoria.php'); ?>
</div>

<!-- Informaçoes da cesta de compra -->
<?php if (!isset($_SESSION['num_ped'])) { ?>
    <div class="row">
        <div class="col-md-12">
            <h2>Sua cesta de compra esta vazia</h2>
        </div>
    </div>
<?php } else { ?>
    <div class="row">
        <div class="col-md-6">
            <h2>Minha cesta de compra</h2>
        </div>
        <div class="col-md-6 text-right">
            <h2>Número do pedido: 
                <b><?= $_SESSION['num_ped']; ?></b>
            </h2>
        </div>
    </div>

    <form name="cesta" method="post" action="cesta.php?atualiza=S"
        onsubmit="return valida_form(this);">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Descrição da miniatura</th>
                    <th>Quantidade</th>
                    <th>Excluir</th>
                    <th>Preço unitário</th>
                    <th>Total R$</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $n = 0;
                $subtotal = 0;
                while ($reg = mysqli_fetch_array($rs)) {
                    $n = $n + 1;
                    $id = $reg["id"];
                    $codigo = $reg["codigo"];
                    $nome = $reg["nome"];
                    $qt = $reg["qt"];
                    $preco_unit = $reg["preco"];
                    $peso = $reg["peso"];
                    $preco_total = $preco_unit * $qt;
                    $subtotal = $subtotal + $preco_total;
                ?>
                    <tr>
                        <td>
                            <img src="produtos/<?= $codigo; ?>.jpg" />
                            <?= $codigo; ?> - <?= $nome; ?>
                        </td>
                        <td>
                            <input type="text" name="txt<?= $n; ?>" 
                                value="<?= $qt; ?>" 
                                class="form-control" />
                        </td>
                        <td>
                            <a href="cesta.php?id=<?= $id; ?>&excluir=S">
                                <img src="img/btn_removerItem.gif" />
                            </a> 
                        </td>
                        <td><?php echo number_format($preco_unit, 2, ',', '.'); ?></td>
                        <td><?php echo number_format($preco_total, 2, ',', '.'); ?></td>
                        <input type="hidden" name="id<?= $n; ?>" value="<?= $id; ?>" />
                    </tr>
                <?php } ?>

                <tr>
                    <td colspan="3" class="h5">
                        *O valor total da sua compra não inclui o frete,
                        ele será calculado no fechamento do seu pedido.
                    </td>
                    <td class="text-right h4">Subtotal</td>
                    <td class="text-right h4"><?php echo 
                        number_format($subtotal, 2, ',', '.'); 
                        $_SESSION['total'] = $subtotal;
                    ?>    
                    </td>
                </tr>

                <tr>
                    <td colspan="3">
                        <a href="index.php" class="btn btn-primary btn-block">
                            Comprar mais</a>
                    </td>
                    <td>
                        <input class="btn btn-warning btn-block"
                            type="submit"
                            value="Atualizar valor" />                            
                    </td>
                    <td>
                        <a href="login.php" class="btn btn-success btn-block">
                            Fechar pedido</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

<?php } 

include_once('includes/rodape.php');

?>