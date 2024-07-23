function calcularCustos() {

    let litrosJan = parseFloat(document.getElementById('litrosJan').value);
    let precoJan = parseFloat(document.getElementById('precoJan').value);

    let litrosFev = parseFloat(document.getElementById('litrosFev').value);
    let precoFev = parseFloat(document.getElementById('precoFev').value);

    if (isNaN(litrosJan) || isNaN(precoJan) || isNaN(litrosFev) || isNaN(precoFev)) {
        alert('Por favor, insira valores numéricos válidos.');
        return;
    }

    const precoUnidJan = precoJan / litrosJan;
    const precoUnidFev = precoFev / litrosFev;

    let mediaLitros = (litrosJan + litrosFev) / 2;
    let mediaPreco = (precoJan + precoFev) / 2;

    let minLitros = Math.min(litrosJan, litrosFev);
    let minPreco = Math.min(precoJan, precoFev);

    let maxLitros = Math.max(litrosJan, litrosFev);
    let maxPreco = Math.max(precoJan, precoFev);

    let totalLitros = litrosJan + litrosFev;
    let totalPreco = precoJan + precoFev;

    const resultHTML = `
        <p>Preço Unid. Janeiro: R$ ${precoUnidJan.toFixed(2)}</p>
        <p>Preço Unid. Fevereiro: R$ ${precoUnidFev.toFixed(2)}</p>
        <p>Média dos Litros: ${mediaLitros.toFixed(2)}</p>
        <p>Média do Preço: R$ ${mediaPreco.toFixed(2)}</p>
        <p>Mínimo Litros: ${minLitros.toFixed(2)}</p>
        <p>Mínimo Preço: R$ ${minPreco.toFixed(2)}</p>
        <p>Máximo Litros: ${maxLitros.toFixed(2)}</p>
        <p>Máximo Preço: R$ ${maxPreco.toFixed(2)}</p>
        <p>Total Litros: ${totalLitros.toFixed(2)}</p>
        <p>Total Preço: ${totalPreco.toFixed(2)}</p>
    `;

    document.getElementById('resultado').innerHTML = resultHTML

}