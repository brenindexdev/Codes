let currentInput = '';
let resultDisplayed = false;


// Limpar tudo
function Limpar() {
    document.getElementById('display').value = '';
    currentInput = '';
    resultDisplayed = false;
}

// Limpar o último digito
function DeletarUltimoDigito() {
    let display = document.getElementById('display');
    let displayText = display.value;
    display.value = displayText.substring(0, displayText.length-1);
    console.log(display.value);
}

function PotenciaQuadrada() {
    display.value = Math.sqrt(display.value);
}

// Apresentar o valor
function Mostrar(value) {
    if (resultDisplayed) {
        Limpar();
    }
    document.getElementById('display').value += value;
    currentInput += value;
}

// Calculando resultado final
function Resultado() {
    try {
        let result = eval(currentInput);
        document.getElementById('display').value = result;
        currentInput = result.toString();
        resultDisplayed = true;
    } catch (error) {
        document.getElementById('display').value = 'Error';
    }
}

// Calculando raiz quadrada
function RaizQuadrada() {
    try {
        let inputValue = eval(currentInput);
        if (inputValue >= 0) {
            let result = Math.sqrt(inputValue);
            document.getElementById('display').value = result;
            currentInput = result.toString();
            resultDisplayed = true;
        } else {
            document.getElementById('display').value = 'Error';
        }
    } catch (error) {
        document.getElementById('display').value = 'Error';
    }
}

// Ação das teclas
document.addEventListener('keydown', function (event) {
    let key = event.key;
    
    // Mapeamento de tecla para botão
    let keyMappings = {
        '0': '0',
        '1': '1',
        '2': '2',
        '3': '3',
        '4': '4',
        '5': '5',
        '6': '6',
        '7': '7',
        '8': '8',
        '9': '9',
        '+': '+',
        '-': '-',
        '*': '*',
        '/': '/',
        '.': '.',
        '=': '=',
        '^': '^',
        'r': '√',
        'R': '√',
        'Enter': '=',
        'Backspace': '⌫', 
        'Escape': 'C'
    };

    let buttonValue = keyMappings[key];
    
    if (buttonValue !== undefined) {
        if (buttonValue === '=') {
            Resultado();
        } else if (buttonValue === 'C') {
            Limpar();
        } else if (event.key === 'r' || event.key === 'R') {
            RaizQuadrada();
        } else if (buttonValue === '⌫') {
            DeletarUltimoDigito();
        } else {
            Mostrar(buttonValue);
        }
    }
});

