<?php
session_start();

// Verifica se o usuário está logado, se não, redireciona para a página de login
if (!isset($_SESSION['usuario'])) {
    header("Location: login.php");
    exit();
}
?>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Principal - Sistema Acadêmico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .menu-table {
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            border-collapse: collapse;
        }
        .menu-table th, .menu-table td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: center;
        }
        .menu-table th {
            background-color: #f2b7b5;
        }
        .menu-table td {
            background-color: #d7eae8;
        }
        .menu-table td a {
            display: block;
            color: #000;
            text-decoration: none;
        }
        .menu-table td a:hover {
            text-decoration: underline;
            color: #007bff;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 class="text-center mt-4">Menu de Opções Principal</h1>
        
        <table class="menu-table table">
            <thead>
                <tr>
                    <th>Alunos</th>
                    <th>Cursos</th>
                    <th>Disciplinas</th>
                    <th>Professores</th>
                    <th>Horário</th>
                    <th>Salas</th>
                    <th>Sair</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="#">Cadastro</a></td>
                    <td><a href="#">Cadastro</a></td>
                    <td><a href="#">Cadastro</a></td>
                    <td><a href="#">Cadastro</a></td>
                    <td><a href="#">Cadastro</a></td>
                    <td><a href="#">Cadastro</a></td>
                    <td rowspan="5"><a href="#">Sair</a></td>
                </tr>
                <tr>
                    <td><a href="#">Boletim</a></td>
                    <td><a href="#">Disciplinas</a></td>
                    <td><a href="#">Professores</a></td>
                    <td><a href="#">Disciplinas</a></td>
                    <td><a href="#">Grade</a></td>
                    <td><a href="#">Mapa</a></td>
                </tr>
                <tr>
                    <td><a href="#">Matrícula</a></td>
                    <td><a href="#">Alunos</a></td>
                    <td><a href="#">Horário</a></td>
                    <td><a href="#">Boletim</a></td>
                    <td><a href="#">Professores</a></td>
                    <td><a href="#">Professores</a></td>
                </tr>
                <tr>
                    <td><a href="#">Disciplinas</a></td>
                    <td><a href="#">Professor</a></td>
                    <td><a href="#">Salas</a></td>
                    <td><a href="#">Cursos</a></td>
                    <td><a href="#">Disciplinas</a></td>
                    <td><a href="#">Disciplinas</a></td>
                </tr>
                <tr>
                    <td><a href="#">Curso</a></td>
                    <td><a href="#">Horários</a></td>
                    <td><a href="#">Cursos</a></td>
                    <td><a href="#">Alunos</a></td>
                    <td><a href="#">Salas</a></td>
                    <td><a href="#">Cursos</a></td>
                </tr>
                <tr>
                    <td><a href="#">Grade Curricular</a></td>
                </tr>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
