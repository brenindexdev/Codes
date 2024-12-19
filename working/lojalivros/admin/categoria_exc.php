<?php 
    include_once('../include/cabecalho_admin.php');
    require_once('../include/conexao.php');

    if ((isset($_GET['id'])) && (is_numeric($_GET['id']))) {
        $id = $_GET['id'];
    } else if 
        ((isset($_POST['id'])) && (is_numeric($_POST['id']))) {
        $id = $_POST['id'];
    } else {
        header("Location: categoria_menu.php");
        exit();
    }

    if (isset($_POST['enviou'])) {       

        //SQL de exclusão
            $q = "DELETE FROM categoria
                  WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='0;URL=categoria_menu.php'>";
            } else {
                $erro = "<h1><b>Erro no Sistema</b></h1>
                <p>Ocorreu um erro no sistema.</p>";
                $erro .= "<p>" . mysqli_error($dbc) . "</p>";
            }
    }

    //Pesquisa para exibir o registro para alteração
    $q = "SELECT * FROM categoria WHERE id=$id";
    $r = @mysqli_query($dbc, $q);

    if (mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Categoria - Exclusão</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";
?>

<form method="post" action="categoria_exc.php">
    <div class="row">
        <div class="form-group col-md-12">
            <label>Título</label>
            <input type="text" name="titulo" maxlength="60"
                class="form-control"
                disabled
                placeholder="Digite o título" 
                value="<?= $row[1]; ?>" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="categoria_menu.php" class="btn btn-secondary">
                Fechar sem Excluir</a>
            <input type="submit" value="Excluir"
                class="btn btn-danger" />
        </div>
    </div>
    <input type="hidden" name="enviou" value="true" />
    <input type="hidden" name="id" value="<?= $row[0]; ?>" />
</form>

<?php 
    }
    include_once('../include/rodape_admin.php');
?>