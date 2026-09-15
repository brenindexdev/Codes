<?php 
    include_once('../include/cabecalho_admin.php');

    require_once('../include/conexao.php');

    //Numero de registros mostrados por pagina
    $exiba = 10;

    //Captura a Pesquisa
    $where = mysqli_real_escape_string($dbc, trim(
        isset($_GET['q'])) ? $_GET['q'] : '');

    //Determina quantas paginas existem
    if (isset($_GET['p']) && is_numeric($_GET['p']))
    {
        $pagina = $_GET['p'];
    } else 
    {
        //Contar a quantidade de registros
        $q = "SELECT COUNT(id) FROM categoria WHERE nome like 
            '%$where%'";
        $r = @mysqli_query($dbc, $q);
        $row = @mysqli_fetch_array($r, MYSQLI_NUM);
        $qtde = $row[0];

        //calcular o numero de pagina
        if ($qtde > $exiba) 
        {
            $pagina = ceil($qtde / $exiba);
        } else {
            $pagina = 1;
        }
    }

    //Determina a posição no BD para retornar os resultados
    if (isset($_GET['s']) && is_numeric($_GET['s'])) {
        $inicio = $_GET['s'];
    } else {
        $inicio = 0;
    }

    //Determina a ordenaçã, por padrão é por Código
    $ordem = isset($_GET['ordem']) ? $_GET['ordem'] : 'id';

    //Determina a ordem de classificação
    switch ($ordem) {
        case 'id' :
            $order_by = 'id';
            break;
        case 't' :
            $order_by = 'titulo';
            break;
        case 'd' :
            $order_by = 'data_inclusao';
            break;
        default :
            $ordem = 'id';
            $order_by = 'id';
            break;
        }

    $q = "SELECT id, titulo, data_inclusao
            FROM categoria
            WHERE titulo like '%$where%'
            ORDER BY $order_by
            LIMIT $inicio, $exiba";
    $r = @mysqli_query($dbc, $q);

    if (mysqli_num_rows($r) > 0) {
        $saida = "<div class='table-responsive col-md-12'>
            <table class='table table-striped'>
                <thead>
                    <tr>
                        <th><a href='categoria_menu.php?ordem=id'>Código</a></th>
                        <th><a href='categoria_menu.php?ordem=n'>Título</a></th>
                        <th><a href='categoria_menu.php?ordem=d'>Data Inclusão</a></th>
                        <th class='text-center'>Ações</th>
                    </tr>
                </thead>
                <tbody>";
        while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC))
        {
            $saida .= "<tr>
                        <td>" . $row['id'] . "</td>" .
                        "<td>" . $row['titulo'] . "</td>" .
                        "<td>" . $row['data_inclusao'] . "</td>" .
                        "<td class='text-center'>
                            <a href='categoria_alt.php?id=".$row['id']."' 
                                class='btn btn-sm btn-warning'>Editar</a>
                            <a href='categoria_exc.php?id=".$row['id']."' 
                                class='btn btn-sm btn-danger'>Excluir</a>
                        </td>
                       </tr>";
        }
        $saida .= "</tbody></table>";
    } else {
        $saida = "<div class='alert alert-warning'>
        Não existe registro na tabela.
        </div>";
    }

?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Categoria - Menu</h1>
</div>

<div class="row mb-3">
    <div class="col-md-9">
        <div class="input-group">
            <input type="text" class="form-control"
                placeholder="Pesquise o titulo da categoria"
                id="busca" />
            <div class="input-group-append">
                <a class="btn btn-primary" 
                    href="#"
                    onclick="this.href='categoria_menu.php?q='+
                    document.getElementById('busca').value">
                    <i class="fa fa-search"></i> Pesquisar
                </a>
            </div>
        </div>
    </div>
    <div class="col-md-3 text-right">
        <a href="categoria_cad.php" class="btn btn-primary">
            Inserir Categoria
        </a>
    </div>
</div>

<?php echo $saida; ?>

<?php 
    include_once('../include/rodape_admin.php');
?>