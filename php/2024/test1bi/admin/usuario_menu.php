<?php
    include_once('../include/cabecalho_admin.php');

    require_once('../include/conexao.php');

    //Número de registros mostrados por página
    $exiba = 2;

    //Captura a pesquisa
    $where = mysqli_real_escape_string($dbc, trim(isset($_GET['q'])) ? $_GET['q'] : '');

    //Determina quantas paginas existem
    if(isset($_GET['p']) && is_numeric($_GET['p']))
    {
        $pagina = $_GET['p'];
    } else
    {
        //Contar a quantidade de registros
        $q = "SELECT COUNT(id) From usuario WHERE nome like '%$where%'";
        $r = @mysqli_query($dbc, $q);
        $row = @mysqli_fetch_array($r, MYSQLI_NUM);
        $qtde = $row[0];

        //Calcular o número de página
        if ($qtde > $exiba) {
            $pagina = ceil($qtde / $exiba);
        } else {
            $pagina = 1;
        }
    }

    //Determina uma posição no Bd para começar a retornar os resultados
    if (isset($_GET['s']) && is_numeric($_GET ['s'])) {
        $inicio = $_GET ['s'];
    } else {
        $inicio = 0;
    }

    //Determina a ordenação, por padrão e por código
    $ordem = isset ($_GET['ordem']) ? $_GET['ordem'] : 'id' ;

    //Determina a ordem de classificação
    switch ($ordem) {
        case 'id' :
            $order_by = 'id';
            break ; 
        case 'n' :
            $order_by = 'nome';
            break ;
        case 'e' :
            $order_by = 'email';
            break ; 
        case 'd' : 
            $order_by = 'data_inclusao';
            break ;
        default :
            $ordem = 'id';
            $order_by = 'data_inclusao';
            break;
    }
 
    $q = "SELECT id, nome, sobrenome, email, data_inclusao FROM usuario WHERE nome like '%$where%' ORDER BY $order_by LIMIT $inicio, $exiba";
    $r = @mysqli_query($dbc, $q);

    if(mysqli_num_rows($r) > 0) {
        $saida = "<div class='table-responsive col-md-12'>
            <table class='table table-stripped'>
                <thead>
                    <tr>
                        <th><a href='usuario_menu.php?ordem=id'>Código</a></th>
                        <th><a href='usuario_menu.php?ordem=m'>Nome</a></th>
                        <th><a href='usuario_menu.php?ordem=e'>Email</a></th>
                        <th><a href='usuario_menu.php?ordem=d'>Data de Inclusão</a></th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>";
        while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC))
        {
            $saida .= "<tr>
                            <td>" . $row['id'] . "</td>" .
                            "<td>" . $row['nome'] . "</td>" .
                            "<td>" . $row['email'] . "</td>" .
                            "<td>" . $row['data_inclusao'] . "</td>" .
                            "<td>
                                <a href='usuario_alt.php?id=".$row['id']."' class='btn btn-sm btn-warning'> Editar </a>
                                <a href='usuario_exc.php?id=".$row['id']."' class='btn btn-sm btn-danger'> Excluir </a>
                            </td>
                        </tr>";
                        
    }
    $saida .= "</tbody></table>";

    } else {
        $saida = "<div class='alert alert-warning'> Não existe registros de <b>$where</b> na tabela <br />
        <br><b>Tente:<b><br />
        - Palavras menos específicas;<br />
        - Palavras chaves diferentes;<br />
        - Confira a ortografia das palavras e se elas foram acentuadas corretamente;
        </div>";
    }

    if($pagina > 1) {
        $pag = '';
        $pagina_correta = ($inicio/$exiba) +1;

        //botão anterior
        if ($pagina_correta != 1) {
            $pag .= '<li class="page-item">
            <a class="page-link" href="usuario_menu.php?s=' . ($inicio - $exiba) . '&p=' . $pagina .
            '&ordem=' . $ordem . '&q=' . $where . '"><< Anterior</a></li>';
        } else {
            $pag .= '<li class="page-item disabled">
            <a class="page-link"><< Anterior</a></li>';
        }
    }

    //Todas as paginas
    for ($i = 1; $i <= $pagina; $i++) {
        if ($i != $pagina_correta) {
            $pag .= '<li class="page-item">
            <a class="page-link" href="usuario_menu.php?s=' . ($exiba * ($i- 1)) . '&p=' . $pagina .
            '&ordem=' . $ordem . '&q=' . $where . '">' . $i . '</a></li>';
        } else {
            $pag .= '<li class="page-item active">
            <a class="page-link">' . $i . '</a></li>';
        }
    }

    //botão próximo
    if ($pagina_correta != $pagina) {
        $pag .= '<li class="page-item">
        <a class="page-link" href="usuario_menu.php?s=' . ($inicio + $exiba) . '&p=' . $pagina .
        '&ordem=' . $ordem . '&q=' . $where . '">Próximo >></a></li>';
    } else {
        $pag .= '<li class="page-item disabled">
        <a class="page-link">Próximo >></a></li>';
    }
?>

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Menu do Usuário</h1>
    </div>

    <div class="row mb-3">
        <div class="col-md-9">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Pesquise o nome do usuário" id="busca" />
                <div class="input-group-append">
                    <a href="#" class="btn btn-primary" onclick="this.href='usuario_menu.php?q='+ document.getElementById('busca').value">
                        <i class="fa fa-search"></i>
                         Pesquisar</a>
                </div>
            </div>
        </div>

        <div class="col-md-3 text-right">
            <a href="usuario_cad.php" class="btn btn-primary">
                Inserir Usuário
            </a>
        </div>
    </div>

<?php echo $saida; ?>

    <div class='row'>
        <div class='col-md-12'>
            <ul class='pagination justify-content-end'>
                <?php if (isset($pag)) echo $pag; ?>
            </ul>
        </div>
    </div>

<?php
    include_once('../include/rodape_admin.php');
?>