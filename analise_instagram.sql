-- ============================================================
-- ANÁLISE DE PERFORMANCE DO INSTAGRAM — BARBEARIA STUDIO FARIA
-- Autor: Anderson Rodrigues dos Santos
-- Banco de dados: BigQuery | curso-ebac-472620.studio_faria.posts
-- Período analisado: Janeiro — Abril 2026
-- ============================================================
-- Contexto: Projeto real de análise de dados do Instagram de
-- uma barbearia após mudança de endereço. Objetivo: identificar
-- padrões de performance para orientar estratégia de conteúdo.
-- ============================================================


-- ============================================================
-- 1. PERFORMANCE POR TIPO DE POST
-- ============================================================

SELECT
  `Tipo de Post`,
  COUNT(*)                             AS total_posts,
  ROUND(AVG(Alcance), 0)               AS media_alcance,
  ROUND(AVG(Pct_Engajamento / 100), 2) AS media_engajamento_pct,
  SUM(`Conversão`)                     AS total_conversoes
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY `Tipo de Post`
ORDER BY media_alcance DESC;

-- Carrossel: maior engajamento (20,57%) mas apenas 1 post no período
-- Foto (Feed): melhor taxa de conversão proporcional (13 conv. em 6 posts)
-- Story: domina em volume (84 posts) mas menor alcance médio (152)
-- Recomendação: aumentar frequência de Carrossel e Reels


-- ============================================================
-- 2. EVOLUÇÃO MENSAL DE PERFORMANCE
-- ============================================================

SELECT
  `Mês`,
  COUNT(*)                             AS total_posts,
  ROUND(AVG(Alcance), 0)               AS media_alcance,
  ROUND(AVG(Pct_Engajamento / 100), 2) AS media_engajamento_pct,
  SUM(`Conversão`)                     AS total_conversoes
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY `Mês`
ORDER BY MIN(Data);

-- Janeiro: melhor desempenho (alcance médio 216, engajamento 6,47%)
-- Queda progressiva: alcance caiu de 216 para 109 em abril
-- Correlação com irregularidade nas postagens identificada


-- ============================================================
-- 3. TOP 5 TEMAS POR CONVERSÃO
-- ============================================================

SELECT
  Tema,
  COUNT(*)                             AS total_posts,
  ROUND(AVG(Alcance), 0)               AS media_alcance,
  ROUND(AVG(Pct_Engajamento / 100), 2) AS media_engajamento_pct,
  SUM(`Conversão`)                     AS total_conversoes
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY Tema
ORDER BY total_conversoes DESC
LIMIT 5;

-- Institucional: maior conversão (31) — credibilidade converte
-- Corte: segundo em conversões (23) com alto volume de posts
-- Salão: maior engajamento médio (6,52%)


-- ============================================================
-- 4. MELHOR DIA DA SEMANA PARA POSTAR
-- ============================================================

SELECT
  `Dia da Semana`,
  COUNT(*)                             AS total_posts,
  ROUND(AVG(Alcance), 0)               AS media_alcance,
  ROUND(AVG(Pct_Engajamento / 100), 2) AS media_engajamento_pct,
  SUM(`Conversão`)                     AS total_conversoes
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY `Dia da Semana`
ORDER BY media_engajamento_pct DESC;

-- Terça-feira: melhor dia (engajamento 5,70%, 34 conversões)
-- Quinta-feira: segundo melhor (engajamento 5,12%, 19 conversões)
-- Sexta-feira: pior dia (engajamento 3,10%, apenas 5 conversões)
-- Recomendação: priorizar postagens terça e quinta-feira


-- ============================================================
-- 5. ANÁLISE DO FUNIL DE CONTEÚDO
-- Nota: Classificação via CASE WHEN pois coluna Funil não
-- existe na fonte de dados — criada via Power Query no Power BI
-- ============================================================

SELECT
  CASE
    WHEN Tema IN ('Meme', 'Motivacional') THEN 'Topo'
    WHEN Tema IN ('Salão', 'Bastidor', 'Cliente', 'Comercial') THEN 'Meio'
    WHEN Tema IN ('Institucional', 'Corte', 'Promoção/CTA',
                  'foto chamada para agendamento') THEN 'Fundo'
    ELSE 'Não classificado'
  END                                  AS Funil,
  COUNT(*)                             AS total_posts,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_posts,
  ROUND(AVG(Alcance), 0)               AS media_alcance,
  ROUND(AVG(Pct_Engajamento / 100), 2) AS media_engajamento_pct,
  SUM(`Conversão`)                     AS total_conversoes
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY Funil
ORDER BY
  CASE Funil
    WHEN 'Topo'  THEN 1
    WHEN 'Meio'  THEN 2
    WHEN 'Fundo' THEN 3
    ELSE 4
  END;

-- Topo: apenas 6 posts (6,5%) — gap critico identificado
-- Meio: 35 posts (38,5%) — engajamento 4,85%
-- Fundo: 50 posts (54,9%) — domina a estratégia com 67 conversões
-- Recomendação: aumentar producao de Reels (topo) para crescimento organico


-- ============================================================
-- 6. TOP 10 POSTS POR ENGAJAMENTO
-- ============================================================

SELECT
  Data,
  `Tipo de Post`,
  Tema,
  `Descrição`,
  Alcance,
  Engajamento_Num                      AS engajamento_num,
  ROUND(Pct_Engajamento / 100, 2)      AS pct_engajamento,
  `Conversão`                          AS conversoes
FROM `curso-ebac-472620.studio_faria.posts`
ORDER BY Pct_Engajamento DESC
LIMIT 10;

-- Bastidor de colaboradora (22,54%): conteudo humano performa muito
-- Carrossel de apresentacao do espaco (20,57%): conteudo de valor engaja
-- Resultado de cliente aparece 3x no top 10: prova social funciona
-- 6 dos 10 melhores posts sao de Janeiro: confirma queda de qualidade


-- ============================================================
-- 7. TAXA DE CONVERSÃO POR TIPO DE POST E TEMA
-- ============================================================

SELECT
  `Tipo de Post`,
  Tema,
  COUNT(*)                             AS total_posts,
  SUM(`Conversão`)                     AS total_conversoes,
  ROUND(
    SAFE_DIVIDE(
      SUM(`Conversão`),
      SUM(Alcance)
    ) * 100, 2)                        AS taxa_conversao_pct
FROM `curso-ebac-472620.studio_faria.posts`
GROUP BY `Tipo de Post`, Tema
HAVING total_conversoes > 0
ORDER BY total_conversoes DESC;

-- Story Institucional: 1,20% de conversao — melhor combinacao
-- Story Cliente: 1,04% — prova social converte muito bem
-- Foto (Feed) Corte: 0,91% — feed de resultado e eficiente
-- Story Promocao/CTA: 0,57% — CTA direto converte MENOS que conteudo organico
-- Insight principal: mostrar credibilidade converte 2x mais que pedir agendamento
