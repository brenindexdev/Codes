<?php 
    include_once('../include/cabecalho_admin.php');
    require_once('../include/conexao.php');
    if ((isset($_GET['id'])) && is_numeric($_GET['id'])) {
        $id= $_GET['id'];
    } else if 
     ((isset($_POST['id'])) && (is_numeric($_POST['id']))) {
        $id= $_POST['id'];
     } else {
        header ("Location: categoria_menu.php");
        exit();
     }
    

    if (isset($_POST['enviou'])) {

        $erros = array();

        //Verifica se existe um título
        if (empty($_POST['titulo'])) {
            $erros[] = "Você esqueceu de digitar o seu titulo.";
        } else {
            $t = mysqli_real_escape_string($dbc, trim(
                $_POST['titulo']));
        }


        if (empty($erros)) {
            //SQL de alteração
            $q = "UPDATE categoria SET titulo='$t', data_alteracao = NOW() WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                $sucesso = "<h1><b>Sucesso!</b></h1>
                <p>Seu registro foi alterado com sucesso!</p>
                <p>Aguarde... Redirecionando!</p>";
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='3;URL=categoria_menu.php'>";
            } else {
                $erro = "<h1><b>Erro no Sistema</b></h1>
                <p>Ocorreu um erro no sistema.</p>";
                $erro .= "<p>" . mysqli_error($dbc) . "</p>";
            }
        } else {
            $erro = "<h1><b>Erro!</b></h1> 
            <p>Ocorreram o(s) seguinte(s) erro(s): <br />";
            foreach ($erros as $msg) {
                $erro .= "- $msg <br />";
            }
            $erro .= "</p><p>Por favor, tente novamente.</p>";
        }
    }

    //Pesquisa para exibir o registro para alteração
    $q = "SELECT * FROM categoria WHERE id=$id";
    $r = @mysqli_query($dbc, $q);
    
    if(mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Altereação de Categoria</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";

    if (isset($sucesso))
        echo "<div class='alert alert-success'>$sucesso</div>";        
?>

<form method="post" action="categoria_alt.php">
    <div class="row">
        <div class="form-group col-md-6">
            <label>Título</label>
            <input type="text" name="titulo" maxlength="60"
                class="form-control"
                placeholder="Digite o titulo" 
                value="<?= $row[1];?>"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="categoria_menu.php" class="btn btn-secondary">
                Fechar sem Salvar</a>
            <input type="submit" value="Salvar"
                class="btn btn-warning" />
        </div>
    </div>
    <input type="hidden" name="enviou" value="true" />
    <input type="hidden" name="id" value="<?= $row[0];?>" />
</form>

<?php
    }
    include_once('../include/rodape_admin.php');
?>