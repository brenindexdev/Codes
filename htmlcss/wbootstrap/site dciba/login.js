function login() {

    var email = document.getElementById('Email').value;
    var senha = document.getElementById('Senha').value;


    if (email === 'nome@exemplo.com' && senha === 'senha') {
        location.href = "home.html";
    }
    else if (email === '') {
        alert('Nada foi inserido. Coloque suas credenciais.');
    }
    else if (senha === '') {
        alert('Nada foi inserido. Coloque suas credenciais.');
    }
    else if (email === '' && senha === '') {
        alert('Nada foi inserido. Coloque suas credenciais.');
    }
    else {
        alert('Credenciais incorretas. Por favor, tente novamente.');
    }

}