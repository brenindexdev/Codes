<?php
    require_once("../include/conexao.php");
    
    if (isset($_POST['Username']) || 
        isset($_POST['senha'])){
        if (strlen($_POST['Username']) == 0)
            echo "Usuário requerido";
        else if (strlen($_POST['senha']) == 0)
            echo "Senha requerida";
        else {
            $usuario = $_POST['Username'];
            $senha = $_POST['senha'];
            $database = 'crica';
            $host = 'localhost';

            $mysqli = new mysqli($host,$usuario,$senha,$database);

            if($mysqli->error){
                die("erro ao conectar no banco de dados" . $mysqli->error);
            }
            else {
                header("location: ../principal.php");
            }

        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <title>Login | Crica</title>
</head>
<body>

    <form class="container d-flex flex-column justify-content-center align-items-center vh-100" action="" method="post">
    <div class="container">   
        <div class="mb-3 w-100">
            <label for="validationCustomUsername" class="form-label">Usuário</label>
            <div class="input-group">
                <span class="input-group-text" id="inputGroupPrepend"></span>
                <input type="text" class="form-control" name="Username" aria-describedby="inputGroupPrepend" required>
            </div>
        </div>
        <div class="mb-3 w-100">
            <label for="validationCustom03" class="form-label">Senha</label>
            <input type="password" class="form-control" name="senha" required>
        </div>
        <button class=" entrar w-100 btn btn-md btn-success" type="submit" name="login">Login</button>
    </div>
    </form>

</body>
</html>
