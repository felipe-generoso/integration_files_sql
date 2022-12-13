# integracao_arquivos_sql

Especificação resumida:

Ramo de atuação aplicável: Database Marketing.

Integração automatizada dos dados originários dos arquivos: pessoas e pedidos.(schema de tabelas na sequência). 

Frequência de integração a cada 24 horas (schedule às 07 da manhã).

O projeto inclui:
- Validação de email
- Validação de dados básicos
- Log da rodada de integração 

Segmentações:
- Por região e cidade
- Por faixa de compra
- Por tempo médio de compras
- Por LTV

Uma Tabela consolidada onde é possível:
- Realizar o filtro de pessoas que compram mais de 1x nos últimos 12 meses
- Segmentação para campanha de aniversário
- Classificação de pessoas em níveis de comportamento de compra.

Schema de tabelas e campos:

Tabela CLIENTES:

- ID
- EMAIL
- NOME
- DATA_NASCIMENTO
- SEXO
- DATA_CADASTRO_SISTEMAORIGEM
- CIDADE
- UF
- PERMISSAO_RECEBE_EMAIL (1: Recebe // 0: não recebe)

Tabela PEDIDOS:

- ID_CLIENTE
- ID_PEDIDO
- ID_PRODUTO
- DEPARTAMENTO
- QUANTIDADE
- VALOR_UNITARIO
- PARCELAS
- DATA_PEDIDO
- MEIO_PAGAMENTO
- STATUS_PAGAMENTO

Tabela CONS_RFV (Calculada)

- DATA_ULTIMA_COMPRA
- ULTIMO_DEPTO_COMPRA
- PARCELAMENTO_PREFER / parcelamento mais praticado
- MEIO_PAGAMENTO_PREFER / meio de pagamento mais praticado
- TICKET_MEDIO_ALL / ticket médio total
- TICKET_MEDIO_12M / ticket médio últimos 12 meses
- FREQUENCIA_COMPRA_ALL / frequência de compra total
- FREQUENCIA_COMPRA_12M / frequência de compra últimos 12 meses
- TIER_ATUAL / tipo de cliente (ouro, prata, etc)

Tabela TIERS (valor comprado)

- até 1000  / Cliente básico
- 1000 a 2000 / Cliente Prata
- 2000 a 5000 / Cliente Ouro
- 5000+ / Cliente Super

Tabela LOG DE RODADAS

- ID_RODADA / Sequencial da rodada
- DATA_RODADA / Timestamp da rodada do JOB
- TABELA / Qua tabela o log está referenciando (clientes ou pedidos)
- QUANTIDADE_ALTERADO / Quantidade de registros alterados na rodada
- QUANTIDADE_INSERIDO / Quantidade de registros inseridos na rodada

Demais observações para execução do projeto:

1) Os scripts estão nomeados na pasta com a ordem que deverão ser executados.
2) Deverão ser criados os diretórios: "C:\PMITG\CLIENTES" e "C:\PMITG\PEDIDOS" para a integração dos arquivos.
3) A rotina não processa arquivos do mesmo nome que já foram processados anteriormente.
4) Os scripts foram criados por objetos e em arquivos separados para ficar mais claro o entendimento e organização.
