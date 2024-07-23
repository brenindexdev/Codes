function CalculoSenoCosseno() {
    let a = parseFloat(document.getElementById('a').value);
    let b = parseFloat(document.getElementById('b').value);
    let c = parseFloat(document.getElementById('c').value);

    let Kseno = Math.sin(a + b);
    let Vcosseno = Math.cos(a + c);

    document.getElementById('Kseno').textContent = Kseno.toFixed(2);
    document.getElementById('Vcosseno').textContent = Vcosseno.toFixed(2);
}

function CalculoRealDolar() {
    let dolar = parseFloat(document.getElementById('dolar').value);
    let real = parseFloat(document.getElementById('real').value);
    let precoatual = real / dolar;

    document.getElementById('precoatual').textContent = "$" + precoatual.toFixed(2);
}
