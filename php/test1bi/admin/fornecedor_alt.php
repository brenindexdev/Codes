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
        $erros = array();

        //Verifica se existe um nome
        if (empty($_POST['nome'])) {
            $erros[] = "Você esqueceu de digitar o seu nome.";
        } else {
            $n = mysqli_real_escape_string($dbc, trim(
                $_POST['nome']));
        }

         //Verifica se existe um endereco
         if (empty($_POST['endereco'])) {
            $erros[] = "Você esqueceu de digitar o seu endereço.";
        } else {
            $endereco = mysqli_real_escape_string($dbc, trim(
                $_POST['endereco']));
        }

        //Verifica se existe um cidade
        if (empty($_POST['cidade'])) {
            $erros[] = "Você esqueceu de digitar o seu cidade.";
        } else {
            $cidade = mysqli_real_escape_string($dbc, trim(
                $_POST['cidade']));
        }

        //Verifica se existe um bairro
        if (empty($_POST['bairro'])) {
            $erros[] = "Você esqueceu de digitar o seu bairro.";
        } else {
            $bairro = mysqli_real_escape_string($dbc, trim(
                $_POST['bairro']));
        }

        //Verifica se existe um estado
        // if (empty($_POST['estado'])) {
        //     $erros[] = "Você esqueceu de digitar o seu estado.";
        // } else {
        //     $e = mysqli_real_escape_string($dbc, trim(
        //         $_POST['estado']));
        // }

        //Verifica se existe um cep
        if (empty($_POST['cep'])) {
            $erros[] = "Você esqueceu de digitar o seu CEP.";
        } else {
            $cep = mysqli_real_escape_string($dbc, trim(
                $_POST['cep']));
        }

        if (empty($erros)) {
            //SQL de alteração
            $q = "UPDATE fornecedor SET nome='$nome', 
                                        endereco='$endereco', 
                                        cidade='$cidade', 
                                        bairro='$bairro', 
                                        cep='$cep',
                                        data_alteracao = NOW() 
                                        WHERE id = $id";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                $sucesso = "<h1><b>Sucesso!</b></h1>
                <p>Seu registro foi alterado com sucesso!</p>
                <p>Aguarde... Redirecionando!</p>";
                echo "<meta HTTP-EQUIV='refresh' 
                    CONTENT='3;URL=fornecedor_menu.php'>";
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
    $q = "SELECT * FROM fornecedor WHERE id=$id";
    $r = @mysqli_query($dbc, $q);
    
    if(mysqli_Num_rows($r) == 1) {
        $row = mysqli_fetch_array($r, MYSQLI_NUM);
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Alteração do Fornecedor</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";

    if (isset($sucesso))
        echo "<div class='alert alert-success'>$sucesso</div>";        
?>

<form method="post" action="fornecedor_alt.php">
    <div class="row">
        <div class="form-group col-md-12">
            <label>Nome</label>
            <input type="text" name="nome" maxlength="60"
                class="form-control"
                placeholder="Digite o nome" 
                value="<?= $row[1];?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>Endereço</label>
            <input type="text" name="endereco" maxlength="60"
                class="form-control"
                placeholder="Digite o seu endereço"
                value="<?= $row[4];?>" />
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-3">
            <label>Cidade</label>
            <input type="text" name="cidade" maxlength="50"
                class="form-control"
                placeholder="Digite sua cidade"
                value="<?= $row[5];?>" />
        </div>

        <div class="form-group col-md-3">
            <label>Bairro</label>
            <input type="text" name="bairro" maxlength="50"
                class="form-control"
                placeholder="Digite seu bairro"
                value="<?= $row[6]; ?>"/>
        </div>

        <div class="form-group col-md-3">
            <label>Estado</label>
            <select class="form-control"></select>
        </div>

        <div class="form-group col-md-3">
            <label>CEP</label>
            <input type="text" name="cep" maxlength="10"
                class="form-control"
                placeholder="Digite seu CEP"
                value="<?= $row[8]; ?>"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="fornecedor_menu.php" class="btn btn-secondary">
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