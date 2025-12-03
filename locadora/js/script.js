const SHEET_ID = "1TXDxycQoPBDBusIqxfiNdEJK8kucqg6_PKj8BHi0hgc";

const URL_CARROS = `https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:json&sheet=Carros`;
const URL_CLIENTES = `https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:json&sheet=Clientes`;

async function carregarDados(url) {
    const res = await fetch(url);
    const txt = await res.text();

    const json = JSON.parse(txt.substring(txt.indexOf("{"), txt.lastIndexOf("}") + 1));
    const cols = json.table.cols.map(c => c.label || c.id);
    const rows = json.table.rows || [];

    return rows.map(r => {
        const obj = {};
        cols.forEach((col, i) => {
            obj[col] = r.c && r.c[i] ? r.c[i].v : "";
        });
        return obj;
    });
}

function extrairDriveId(text) {
    if (!text) return "";


    if (/^[a-zA-Z0-9_-]{10,}$/.test(text.trim())) return text.trim();

    const patterns = [
        /\/d\/([a-zA-Z0-9_-]{10,})/,       
        /id=([a-zA-Z0-9_-]{10,})/,          
        /open\?id=([a-zA-Z0-9_-]{10,})/,    
        /\/file\/d\/([a-zA-Z0-9_-]{10,})/    
    ];

    for (const re of patterns) {
        const m = text.match(re);
        if (m && m[1]) return m[1];
    }

    return "";
}

async function carregarCarros() {
    const destino = document.getElementById("carrosLista");
    if (!destino) {
        console.warn("Elemento #carrosLista não encontrado.");
        return;
    }

    destino.innerHTML = "<p>Carregando...</p>";

    try {
        const dados = await carregarDados(URL_CARROS);
        console.log("dados carregados:", dados);
        renderizarCarros(dados);
    } catch (err) {
        console.error("Erro ao carregar dados do Sheets:", err);
        destino.innerHTML = "<p>Erro ao carregar.</p>";
    }
}

function renderizarCarros(lista) {
    const destino = document.getElementById("carrosLista");
    destino.innerHTML = "";

    if (!Array.isArray(lista) || lista.length === 0) {
        destino.innerHTML = "<p>Nenhum carro encontrado.</p>";
        return;
    }

    lista.forEach((c, idx) => {
        const disp = String(c.Disponivel || c.disponivel || "").toUpperCase() === "TRUE";

        const card = document.createElement("div");
        card.className = "car-card";
        if (!disp) card.classList.add("indisponivel");

        const rawImg = c.Imagem || c.imagem || c.images || c.Images || "";

        const id = extrairDriveId(String(rawImg || "").trim());
        const imagem = id
            ? `https://drive.google.com/uc?export=view&id=${id}`
            : "https://via.placeholder.com/400x240?text=Sem+Foto";

        console.log(`Carro[${idx}] modelo=${c.Modelo || c.modelo} imagemRaw="${rawImg}" id="${id}" url="${imagem}"`);

        card.innerHTML = `
            <div class="card-img-wrap">
                <img src="${imagem}" alt="${(c.Modelo || "")}" class="car-img" onerror="this.src='https://via.placeholder.com/400x240?text=Imagem+Inacessível'">
            </div>
            <div class="card-body">
                <h3>${c.Modelo || ""}</h3>
                <p class="muted">${c.Ano || ""} • ${c.Cor || ""}</p>
            </div>
        `;

        if (disp) {
            card.style.cursor = "pointer";
            card.onclick = () => {
                window.location.href = `agendamento-carro.html?id=${c.ID || c.Id || ""}`;
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
                <td>${c.ID || ""}</td>
                <td>${c.Nome || ""}</td>
                <td>${c.Telefone || ""}</td>
                <td>${c.CPF || ""}</td>
                <td>${c.Email || ""}</td>
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
    carregarCarros();
    carregarClientes();
});