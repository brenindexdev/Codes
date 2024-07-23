let resultadoSequencia = document.getElementById('resultado-sequencia');
let resultadoSoma = document.getElementById('resultado-soma');

function sequenciaNumeros() {
    let sequencia = [];
    let soma = 0;
    for (let i = 1; i <= 100; i++) {
        sequencia.push(i * 5);
        soma += i * 5;
    }
    resultadoSequencia.textContent = `Sequência: ${sequencia.join(', ')}`;
    resultadoSoma.textContent = `Soma: ${soma}`;
}

let resultadoFibonacci = document.getElementById('resultado-fibonacci');
let somaFibonacci = document.getElementById('soma-fibonacci');

function sequenciaFibonacci() {
    let a = 0;
    let b = 1;
    let fibonacci = [a];
    let soma = a;
    while (b <= 2584) {
        [a, b] = [b, a + b];
        fibonacci.push(a);
        soma += a;
    }
    resultadoFibonacci.textContent = `Sequência de Fibonacci: ${fibonacci.join(', ')}`;
    somaFibonacci.textContent = `Soma: ${soma}`;
}

let estudantes = [];
        
        function Avaliar() {
            const nome = document.getElementById('nome').value;
            const nota = parseFloat(document.getElementById('nota').value);
            const faltas = parseInt(document.getElementById('faltas').value);

            if (isNaN(nota) || isNaN(faltas)) {
                alert('Por favor, insira valores numéricos válidos.');
                return;
            }

            const status = (nota >= 6 && faltas < 20) ? 'aprovado' : 'reprovado';
            alert('O aluno(a) ' + nome + ' foi ' + status + '!');

            estudantes.push({ nome, nota, faltas, status });
            Atualizar();
            Limpar();
        }

        function Limpar() {
            document.getElementById('formEstudantes').reset();
        }

        function Mostrar() {
            const totalestudantes = estudantes.length;
            const totalnotas = estudantes.reduce((sum, student) => sum + student.nota, 0);
            const medianota = totalnotas / totalestudantes;
            const maxnota = Math.max(...estudantes.map(student => student.nota));
            const minnota = Math.min(...estudantes.map(student => student.nota));

            document.getElementById('totalestudantes').textContent = totalestudantes;
            document.getElementById('totalnotas').textContent = totalnotas.toFixed(2);
            document.getElementById('medianota').textContent = medianota.toFixed(2);
            document.getElementById('maxnota').textContent = maxnota.toFixed(2);
            document.getElementById('minnota').textContent = minnota.toFixed(2);
        }

        function Atualizar() {
            Mostrar();
            console.log(estudantes);
        }