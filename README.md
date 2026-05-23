# 📊 Análise de Performance e Estratégia de Conteúdo – Instagram Barbearia

Projeto de análise de dados aplicado a um negócio local real, com foco em transformar métricas do Instagram em decisões estratégicas orientadas por dados.

O projeto evoluiu de uma análise manual para uma estrutura automatizada de coleta, armazenamento e análise de dados, utilizando **Instagram Graph API, Python, SQL, BigQuery, Google Sheets e Power BI**, criando um pipeline contínuo de monitoramento de performance e geração de insights de negócio.

**Stack:** `Python` • `SQL` • `BigQuery` • `Power BI` • `Instagram Graph API` • `Google Sheets` • `Power Query`

---

🔗 [Acessar Dashboard no Power BI](https://app.powerbi.com/view?r=eyJrIjoiMmVkZWYxM2EtNTAxNy00NmQ0LTliZGMtNDY5YzkyNzA2YTBhIiwidCI6ImQ2MmVkZjk4LTJkNmYtNDBhOS05YTJhLWEwNmE4MmFlOTdlYyJ9)

<img width="1272" height="715" alt="Dashboard - Visão Geral" src="https://github.com/user-attachments/assets/307c9a83-ddf1-4fbd-a9f4-d679f5819c2c" />


---

# 🗂️ Índice

- [📍 Contexto](#-contexto)
- [🎯 Objetivo](#-objetivo)
- [🏗️ Arquitetura do Projeto](#️-arquitetura-do-projeto)
- [🛠️ Ferramentas Utilizadas](#️-ferramentas-utilizadas)
- [📁 Estrutura do Projeto](#-estrutura-do-projeto)
- [🔄 Pipeline de Dados](#-pipeline-de-dados)
- [🔍 Metodologia](#-metodologia)
- [🧠 Análise Exploratória com SQL](#-análise-exploratória-com-sql-bigquery)
- [💾 Técnicas SQL Aplicadas](#-técnicas-sql-aplicadas)
- [💡 Principais Insights](#-principais-insights)
- [🚀 Estratégia Recomendada](#-estratégia-recomendada)
- [📌 Próximos Passos](#-próximos-passos)
- [👤 Autor](#-autor)

---

# 📍 Contexto

A **Barbearia Studio Faria** passou por uma mudança de endereço em 2026, migrando para um espaço maior e com maior visibilidade. Com o potencial de crescimento do negócio, o Instagram se tornou um canal estratégico para aquisição e relacionamento com clientes.

Apesar do potencial, a ausência de consistência nas postagens e de uma estratégia orientada por dados limitava o crescimento do perfil.

Este projeto nasceu da necessidade de responder perguntas como:

- Quais tipos de conteúdo performam melhor?
- O que gera alcance versus conversão?
- Existe um padrão de queda ou crescimento?
- Qual o papel de cada formato no funil de conteúdo?
- Como transformar métricas em decisões estratégicas?

O objetivo foi substituir decisões intuitivas por decisões baseadas em dados reais.

---

# 🎯 Objetivo

Utilizar dados reais do Instagram para:

✅ Diagnosticar a performance do perfil  
✅ Identificar padrões de alcance, engajamento e conversão  
✅ Comparar formatos de conteúdo (Reels, Stories, Feed e Carrossel)  
✅ Explorar os dados via SQL para encontrar padrões ocultos  
✅ Realizar análises estatísticas descritivas  
✅ Mapear o funil de conteúdo  
✅ Definir uma estratégia de crescimento orgânico baseada em evidências  
✅ Automatizar a coleta de dados para monitoramento contínuo

---

## 🛠️ Ferramentas Utilizadas

| Ferramenta | Uso |
|---|---|
| Instagram Graph API | Coleta automatizada de métricas de posts |
| Python (Google Colab) | Script de integração API → Planilha |
| Google Sheets | Armazenamento e estruturação da base de dados |
| Power BI | Dashboard interativo de monitoramento |
| Power Query | Transformação e limpeza dos dados |

---

## 📁 Estrutura do Projeto

```
studio-faria-instagram-analysis/
│
├── data/
│   └── database_studio_faria.xlsx     # Base de dados com histórico de posts
│
├── scripts/
│   └── coleta_automatica.ipynb        # Notebook Google Colab — coleta via API
│
├── dashboard/
│   └── link_powerbi.txt               # Link para o dashboard interativo
│
├── imagens/
│   └── dashboard_preview.png          # Print do dashboard
│
└── README.md
```

---

## 🔄 Pipeline de Dados

O projeto conta com um pipeline automatizado para coleta de dados de Feed e Reels:

# 🏗️ Arquitetura do Projeto

O projeto utiliza uma arquitetura híbrida, separando a camada operacional da camada analítica.

```text
Instagram Graph API
        ↓
Python (Google Colab)
        ↓
Google Sheets (Base Principal)
       ↙                 ↘
BigQuery              Power BI
(SQL + EDA)          (Dashboard)

### Como funciona

**Feed e Reels (automatizado):**
1. Script Python conecta à Instagram Graph API
2. Busca posts dos últimos 90 dias
3. Coleta métricas: alcance, curtidas, comentários, compartilhamentos, salvamentos
4. Calcula engajamento automaticamente
5. Insere na planilha na posição correta por data
6. Sistema anti-duplicatas via ID do post

### 🛠️ Ferramentas Utilizadas
1. Instagram Graph API	Coleta automatizada das métricas
2. Python (Google Colab)	Integração API → Base de dados
3. Google Sheets	Base principal do projeto
4.BigQuery	Ambiente analítico para SQL
5. SQL	Exploração e estatística descritiva
6. Power BI	Dashboard interativo
7. Power Query	Limpeza e transformação dos dados

**Stories (manual):**
- Inseridos manualmente na planilha devido à limitação da API
- Stories expiram após 24h e não têm histórico disponível via API

### Frequência de atualização

Rodar o script **1x por semana** é suficiente para manter o dashboard atualizado.

### ⚠️ Renovação do token

O Access Token da API expira a cada **60 dias** — necessário gerar novo token no Meta for Developers e atualizar no script.

---

## 🔍 Metodologia

### 1. Coleta de Dados

Levantamento dos dados de todos os posts publicados no perfil entre janeiro e abril de 2026:

- Tipo de conteúdo (Reels, Carrossel, Foto/Feed, Story)
- Alcance por post
- Taxa de engajamento (%)
- Número de conversões
- Horário e dia da semana de publicação
- Etapa do funil (Topo, Meio, Fundo)

### 2. Automação da Coleta

Integração com a **Instagram Graph API** via Python para automatizar a coleta de métricas de Feed e Reels novos, eliminando trabalho manual e garantindo atualização contínua do dashboard.

### 3. Limpeza e Estruturação

Organização e padronização dos dados no Google Sheets com Power Query no Power BI para transformação e modelagem.

### 4. Análise Exploratória

Identificação de tendências mensais, comparação de performance por formato, mapeamento do funil de conteúdo e análise de melhores horários via heatmap.

### 5. Estratégia

Tradução dos insights em recomendações práticas de mix de conteúdo por etapa do funil.

---

## 💡 Principais Insights

### 📉 Queda de Performance

| Métrica | Janeiro | Fevereiro | Março | Abril |
|---|---|---|---|---|
| Média de Alcance | 210 | 144 | 163 | 94 |
| Média de Engajamento (%) | 8% | 6% | 4% | 4% |
| Média de Conversões | 3 | 1 | 1 | 2 |

🚨 O alcance médio caiu mais de 50% entre janeiro e abril, correlacionado diretamente à queda na frequência de postagens.

### 📊 Performance por Tipo de Conteúdo

| Tipo de Post | Alcance Médio | Engajamento (%) | Conversões |
|---|---|---|---|
| Reels | 645 | 4,81% | 0 |
| Carrossel | 418 | 20,57% | 0 |
| Foto (Feed) | 227 | 6,04% | 4 |
| Story | 151 | 4,93% | 1 |

### 🔑 Insight Principal: Alcance ≠ Conversão

Cada formato cumpre um papel diferente e complementar no funil:

| Etapa do Funil | Formato | Papel |
|---|---|---|
| 🔝 Topo (Alcance) | Reels | Atrair novos públicos |
| 🎯 Meio (Engajamento) | Carrossel | Prender atenção e gerar interesse |
| 💰 Fundo (Conversão) | Foto (Feed) | Gerar ação e decisão do cliente |
| 🤝 Relacionamento | Stories | Manter proximidade com a audiência |

### ⏰ Melhores Horários para Postar

Análise via heatmap revelou os momentos de maior engajamento:

- **Melhor dia:** Terça-feira (engajamento médio ~5,7%)
- **Melhor horário:** 15h-18h (engajamento médio ~9,6%)
- **Pior dia:** Sábado (3,88%)

### ⚠️ Crescimento Orgânico Inexistente

O perfil não gerou novos seguidores em nenhum mês do período analisado, indicando ausência de estratégia de topo de funil — reforçando a necessidade de Reels como formato prioritário para aquisição.

---

## 🚀 Estratégia Recomendada

Com base nos dados, a estratégia de conteúdo ideal para o perfil:

**Mix de conteúdo sugerido:**

- **Reels** → Prioridade para atrair novos clientes e aumentar alcance orgânico
- **Carrossel** → Conteúdo de valor (dicas, antes/depois, processo) para engajar a audiência
- **Foto (Feed)** → Resultados, provas sociais e chamadas para agendamento
- **Stories** → Publicações diárias para manutenção de relacionamento

**Frequência:** Consistência é o fator mais crítico identificado nos dados. A queda de 50% no alcance está diretamente ligada à irregularidade das postagens — não ao conteúdo em si.

---

## 📌 Próximos Passos

- [ ] Monitorar resultados após implementação da estratégia
- [ ] Comparar métricas antes e depois das mudanças
- [ ] Expandir análise com dados do segundo semestre de 2026
- [ ] Automatizar renovação do token da API

---

## 👤 Autor

**Anderson Rodrigues dos Santos**
Analista de Dados Júnior | Business Intelligence

[LinkedIn](#) • [Portfólio](#) • [GitHub](#)
