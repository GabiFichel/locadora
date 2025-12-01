const SHEET_ID = "1TXDxycQoPBDBusIqxfiNdEJK8kucqg6_PKj8BHi0hgc";

const URL_CARROS = `https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:json&sheet=Carros`;
const URL_CLIENTES = `https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:json&sheet=Clientes`;

async function carregarDados(url) {
    const res = await fetch(url);
    const txt = await res.text();

    const json = JSON.parse(txt.substring(txt.indexOf("{"), txt.lastIndexOf("}") + 1));

    const cols = json.table.cols.map(c => c.label || c.id);
    const rows = json.table.rows;

    return rows.map(r => {
        const obj = {};
        cols.forEach((col, i) => {
            obj[col] = r.c[i] ? r.c[i].v : "";
        });
        return obj;
    });
}


async function carregarCarros() {
    const destino = document.getElementById("carrosLista");
    if (!destino) return;

    destino.innerHTML = "<p>Carregando...</p>";

    const dados = await carregarDados(URL_CARROS);
    renderizarCarros(dados);
}

function renderizarCarros(lista) {
    const destino = document.getElementById("carrosLista");
    destino.innerHTML = "";

    lista.forEach(c => {
        const disp = String(c.Disponivel).toUpperCase() === "TRUE";

        const card = document.createElement("div");
        card.className = "car-card";
        if (!disp) card.classList.add("indisponivel");

        const imagem = c.Imagem || "https://via.placeholder.com/400x240?text=Sem+Foto";

        card.innerHTML = `
            <img src="${imagem}">
            <h3>${c.Modelo}</h3>
            <p class="muted">${c.Ano} • ${c.Cor}</p>
        `;

        if (disp) {
            card.onclick = () => {
                window.location.href = `agendamento-carro.html?id=${c.ID}`;
            };
        }

        destino.appendChild(card);
    });
}


async function carregarClientes() {
    const corpo = document.getElementById("clientesTabela");
    if (!corpo) return;

    corpo.innerHTML = "<tr><td colspan='5'>Carregando...</td></tr>";

    const dados = await carregarDados(URL_CLIENTES);
    corpo.innerHTML = "";

    dados.forEach(c => {
        corpo.innerHTML += `
            <tr>
                <td>${c.ID}</td>
                <td>${c.Nome}</td>
                <td>${c.Telefone}</td>
                <td>${c.CPF}</td>
                <td>${c.Email}</td>
            </tr>
        `;
    });
}

function toggleTheme() {
    document.body.classList.toggle("dark-mode");

    const novo = document.body.classList.contains("dark-mode") ? "dark" : "light";
    localStorage.setItem("theme", novo);
}


document.addEventListener("DOMContentLoaded", () => {
    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark-mode");
    }
});