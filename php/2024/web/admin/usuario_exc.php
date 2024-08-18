<?php 
    include_once('../include/cabecalho_admin.php');
    require_once('../include/conexao.php');

    if ((isset($_GET['id'])) && (is_numeric($_GET['id']))) {
        $id = $_GET['id'];
    } else if 
        ((isset($_POST['id'])) && (is_numeric($_POST['id']))) {
        $id = $_POST['id'];
    } else {
        header("Location: usuario_menu.php");
        exit();
    }

    if (isset($_POST['enviou'])) {       

        //SQL de exclusão
            $q = "DELETE FROM usuario
                  WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='0;URL=usuario_menu.php'>";
            } else {
                $erro = "<h1><b>Erro no Sistema</b></h1>
                <p>Ocorreu um erro no sistema.</p>";
                $erro .= "<p>" . mysqli_error($dbc) . "</p>";
            }
    }

    //Pesquisa para exibir o registro para alteração
    $q = "SELECT * FROM usuario WHERE id=$id";
    $r = @mysqli_query($dbc, $q);

    if (mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Usuário - Exclusão</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";
?>

<form method="post" action="usuario_exc.php">
    <div class="row">
        <div class="form-group col-md-6">
            <label>Nome</label>
            <input type="text" name="nome" maxlength="60"
                class="form-control"
                disabled
                placeholder="Digite o nome" 
                value="<?= $row[1]; ?>" />
        </div>
        
        <div class="form-group col-md-6">
            <label>Sobrenome</label>
            <input type="text" name="sobrenome" maxlength="40"
                class="form-control"
                disabled
                placeholder="Digite o sobrenome" 
                value="<?= $row[2]; ?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>E-mail</label>
            <input type="email" name="email" maxlength="80"
                class="form-control"
                placeholder="Digite o E-mail" 
                disabled
                value="<?= $row[3]; ?>" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="usuario_menu.php" class="btn btn-secondary">
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