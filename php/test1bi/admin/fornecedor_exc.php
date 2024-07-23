<?php 
    include_once('../include/cabecalho_admin.php');
    require_once('../include/conexao.php');

    if ((isset($_GET['id'])) && is_numeric($_GET['id'])) {
        $id= $_GET['id'];
    } else if 
     ((isset($_POST['id'])) && (is_numeric($_POST['id']))) {
        $id= $_POST['id'];
     } else {
        header ("Location: fornecedor_menu.php");
        exit();
     }
    

    if (isset($_POST['enviou'])) {

            //SQL de exclusão
            $q = "DELETE FROM fornecedor WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='0;URL=fornecedor_menu.php'>";
            } else {
                $erro = "<h1><b>Erro no Sistema</b></h1>
                <p>Ocorreu um erro no sistema.</p>";
                $erro .= "<p>" . mysqli_error($dbc) . "</p>";
            }
        }

    //Pesquisa para exibir o registro para alteração
    $q = "SELECT * FROM fornecedor WHERE id = $id";
    $r = @mysqli_query($dbc, $q);
    
    if(mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Exclusão de Usuário</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";
    ?>

<form method="post" action="fornecedor_alt.php">
    <div class="row">
        <div class="form-group col-md-12">
            <label>Nome</label>
            <input type="text" name="nome" maxlength="60"
                class="form-control" disabled
                placeholder="Digite o nome" 
                value="<?= $row[1];?>"/>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>Endereço</label>
            <input type="text" name="endereco" maxlength="60"
                class="form-control" disabled
                placeholder="Digite o seu endereço"
                value="<?= $row[4];?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-3">
            <label>Cidade</label>
            <input type="text" name="cidade" maxlength="20"
                class="form-control" disabled
                placeholder="Digite sua cidade"
                value="<?= $row[5];?>" />
        </div>

        <div class="form-group col-md-3">
            <label>Bairro</label>
            <input type="text" name="bairro" maxlength="60"
                class="form-control" disabled
                placeholder="Digite seu bairro"
                value="<?= $row[6]; ?>"/>
        </div>

        <div class="form-group col-md-3">
            <label>Estado</label>
            <select class="form-control" disabled name="" id=""></select>
        </div>

        <div class="form-group col-md-3">
            <label>CEP</label>
            <input type="text" name="cep" maxlength="60"
                class="form-control" disabled
                placeholder="Digite seu CEP"
                value="<?= $row[8]; ?>"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="fornecedor_menu.php" class="btn btn-secondary">
                Fechar sem Excluir</a>
            <input type="submit" value="Excluir"
                class="btn btn-danger" />
        </div>
    </div>
    <input type="hidden" name="enviou" value="true" />
    <input type="hidden" name="id" value="<?= $row[0];?>" />
</form>

<?php
    }
    include_once('../include/rodape_admin.php');
?>