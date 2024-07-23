<?php 
    include_once('../include/cabecalho_admin.php');
    require_once('../include/conexao.php');
    if ((isset($_GET['id'])) && is_numeric($_GET['id'])) {
        $id= $_GET['id'];
    } else if 
     ((isset($_POST['id'])) && (is_numeric($_POST['id']))) {
        $id= $_POST['id'];
     } else {
        header ("Location: usuario_menu.php");
        exit();
     }
    

    if (isset($_POST['enviou'])) {

       

        $erros = array();

        //Verifica se existe um nome
        if (empty($_POST['nome'])) {
            $erros[] = "Você esqueceu de digitar o seu nome.";
        } else {
            $n = mysqli_real_escape_string($dbc, trim(
                $_POST['nome']));
        }

        //Verifica se existe um sobrenome
        if (empty($_POST['sobrenome'])) {
            $erros[] = "Você esqueceu de digitar o seu sobrenome.";
        } else {
            $s = mysqli_real_escape_string($dbc, trim(
                $_POST['sobrenome']));
        }

        //Verifica se existe um email
        if (empty($_POST['email'])) {
            $erros[] = "Você esqueceu de digitar o seu e-mail.";
        } else {
            $e = mysqli_real_escape_string($dbc, trim(
                $_POST['email']));
        }

        //Verifica se há uma senha e testa a confirmação
        if (!empty($_POST['senha1'])) {
            if ($_POST['senha1'] != $_POST['senha2']) {
                $erros[] = "Sua senha não confere com 
                    à confirmação.";
            } else {
                $p = mysqli_real_escape_string($dbc, trim(
                    $_POST['senha1']));
            }
        } else {
            $erros[] = "Você esqueceu de digitar sua senha.";
        }

        if (empty($erros)) {
            //SQL de alteração
            $q = "UPDATE usuario SET nome='$n', sobrenome='$s', email='$e', senha=SHA1('DWEB2024.$p'), data_alteracao = NOW() WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                $sucesso = "<h1><b>Sucesso!</b></h1>
                <p>Seu registro foi alterado com sucesso!</p>
                <p>Aguarde... Redirecionando!</p>";
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='3;URL=usuario_menu.php'>";
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
    $q = "SELECT * FROM usuario WHERE id=$id";
    $r = @mysqli_query($dbc, $q);
    
    if(mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Usuário - Alteração</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";

    if (isset($sucesso))
        echo "<div class='alert alert-success'>$sucesso</div>";        
?>

<form method="post" action="usuario_alt.php">
    <div class="row">
        <div class="form-group col-md-6">
            <label>Nome</label>
            <input type="text" name="nome" maxlength="60"
                class="form-control"
                placeholder="Digite o nome" 
                value="<?= $row[1];?>"/>
        </div>
        
        <div class="form-group col-md-6">
            <label>Sobrenome</label>
            <input type="text" name="sobrenome" maxlength="40"
                class="form-control"
                placeholder="Digite o sobrenome"
                value="<?= $row[2];?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>E-mail</label>
            <input type="email" name="email" maxlength="80"
                class="form-control"
                placeholder="Digite o E-mail"
                value="<?= $row[3];?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-6">
            <label>Senha</label>
            <input type="password" name="senha1" maxlength="10"
                class="form-control"
                placeholder="Digite a Senha" />
        </div>

        <div class="form-group col-md-6">
            <label>Confirme a Senha</label>
            <input type="password" name="senha2" maxlength="10"
                class="form-control"
                placeholder="Digite a Senha" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="usuario_menu.php" class="btn btn-secondary">
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