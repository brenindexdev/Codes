<?php 
    include_once('../include/cabecalho_admin.php');

    if (isset($_POST['enviou'])) {

        require_once('../include/conexao.php');

        $erros = array();

        //Verifica se existe um título
        if (empty($_POST['titulo'])) {
            $erros[] = "Você esqueceu de digitar o seu titulo.";
        } else {
            $t = mysqli_real_escape_string($dbc, trim(
                $_POST['titulo']));
        }

        if (empty($erros)) {
            //SQL de inserção
            $q = "INSERT INTO categoria (titulo, data_inclusao)
                VALUES ('$t', NOW())";
                
            $r = @mysqli_query($dbc, $q);

            if ($r) {
                $sucesso = "<h1><b>Sucesso!</b></h1>
                <p>Seu registro foi incluido com sucesso!</p>
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
?>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Cadastro de Categoria</h1>
</div>

<?php 
    if (isset($erro))
        echo "<div class='alert alert-danger'>$erro</div>";

    if (isset($sucesso))
        echo "<div class='alert alert-success'>$sucesso</div>";        
?>

<form method="post" action="categoria_cad.php">
    <div class="row">
        <div class="form-group col-md-6">
            <label>Título</label>
            <input type="text" name="titulo" maxlength="60"
                class="form-control"
                placeholder="Digite o título" 
                value="<?php if (isset($_POST['titulo']))
                echo $_POST['titulo'];?>"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <a href="categoria_menu.php" class="btn btn-secondary">
                Fechar sem Salvar</a>
            <input type="submit" value="Salvar"
                class="btn btn-primary" />
        </div>
    </div>
    <input type="hidden" name="enviou" value="true" />
</form>

<?php 
    include_once('../include/rodape_admin.php');
?>