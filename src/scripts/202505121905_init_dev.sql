-- (Opcional) Limpa o schema inteiro para desenvolvimento
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- 1) CRIAÇÃO DAS TABELAS
CREATE TABLE IF NOT EXISTS agente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  profissao VARCHAR(100) NOT NULL,
  unidade_atendimento VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS paciente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE NOT NULL,
  diabetico BOOLEAN NOT NULL,
  necessidade_resp BOOLEAN NOT NULL,
  nome_resp VARCHAR(100),
  condicao VARCHAR(200) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  telefone_resp VARCHAR(20),
  agente_id INT,
  FOREIGN KEY (agente_id) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS formulario1 (
  id SERIAL PRIMARY KEY,
  data_preenchimento DATE NOT NULL,
  tipo_ferida VARCHAR(100) NOT NULL,
  localizacao_corpo VARCHAR(100) NOT NULL,
  tamanho_comprimento NUMERIC NOT NULL,
  tamanho_largura NUMERIC NOT NULL,
  exsudato BOOLEAN NOT NULL,
  historico_medico VARCHAR(500) NOT NULL,
  remedios VARCHAR(500) NOT NULL,
  sintomas VARCHAR(200) NOT NULL,
  paciente_id INT,
  FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);

CREATE TABLE IF NOT EXISTS formulario2 (
  id SERIAL PRIMARY KEY,
  data_preenchimento DATE NOT NULL,
  status_ferida VARCHAR(100) NOT NULL,
  tamanho_comprimento NUMERIC NOT NULL,
  tamanho_largura NUMERIC NOT NULL,
  cheiro_ferida BOOLEAN NOT NULL,
  pele_ao_redor VARCHAR(100) NOT NULL,
  febre BOOLEAN NOT NULL,
  dor NUMERIC NOT NULL,
  observacao VARCHAR(300),
  paciente_id INT,
  FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);

CREATE TABLE IF NOT EXISTS historico (
  id SERIAL PRIMARY KEY,
  data_abertura DATE NOT NULL,
  tipo_ferida VARCHAR(100) NOT NULL,
  localizacao_corpo VARCHAR(100) NOT NULL,
  historico_medico VARCHAR(500) NOT NULL,
  exsudato BOOLEAN NOT NULL,
  remedios VARCHAR(500) NOT NULL,
  frequencia_cuidados NUMERIC NOT NULL,
  sintomas VARCHAR(200) NOT NULL,
  observacao_paciente VARCHAR(500),
  paciente_id INT,
  agente_id INT,
  FOREIGN KEY (paciente_id) REFERENCES paciente(id),
  FOREIGN KEY (agente_id) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS avaliacao_historico (
  id SERIAL PRIMARY KEY,
  avaliacao NUMERIC NOT NULL,
  observacao_paciente VARCHAR(500),
  paciente_id INT,
  agente_id INT,
  historico_id INT,
  formulario1_id INT,
  formulario2_id INT,
  FOREIGN KEY (paciente_id)      REFERENCES paciente(id),
  FOREIGN KEY (agente_id)        REFERENCES agente(id),
  FOREIGN KEY (historico_id)     REFERENCES historico(id),
  FOREIGN KEY (formulario1_id)   REFERENCES formulario1(id),
  FOREIGN KEY (formulario2_id)   REFERENCES formulario2(id)
);

-- 2) INSERÇÕES (na ordem certa)

-- 2.1) Agentes
INSERT INTO agente (nome, profissao, unidade_atendimento, telefone) VALUES
('Carla Monteiro', 'Enfermeira',              'UBS Jardim Paraíso', '(11) 99876‑1234'),
('João Pereira'  , 'Técnico em Enfermagem',    'PSF Centro'         , '(11) 99765‑4321');

-- 2.2) Pacientes (referenciam agentes 1 e 2)
INSERT INTO paciente 
  (nome, data_nascimento, diabetico, necessidade_resp, nome_resp, condicao, telefone, telefone_resp, agente_id)
VALUES
  ('Marcos Silva'   ,'1958-02-10', TRUE , FALSE, 'Julia Silva'   , 'Pé diabético (úlcera neuropática)'      , '(11)91234‑5678', '(11)92345‑6789', 1),
  ('Ana Rodrigues'  ,'1972-11-25', FALSE, TRUE , 'Carlos Rodrigues', 'Úlcera por pressão lombar (acamado)'     , '(11)93456‑7890', '(11)94567‑8901', 2);

-- 2.3) Formulário 1
INSERT INTO formulario1 
  (data_preenchimento, tipo_ferida, localizacao_corpo, tamanho_comprimento, tamanho_largura, exsudato, historico_medico, remedios, sintomas, paciente_id)
VALUES
  ('2025-05-01','Úlcera neuropática','Pé direito',  3.5, 2.0, TRUE , 'Diabetes tipo 2 há 15 anos', 'Metformina, Insulina NPH', 'Queimação e secreção', 1),
  ('2025-05-02','Úlcera por pressão','Região lombar',5.0, 4.5, FALSE, 'Acamamento prolongado'     , 'Dipirona'               , 'Dor ao toque'        , 2);

-- 2.4) Formulário 2
INSERT INTO formulario2 
  (data_preenchimento, status_ferida, tamanho_comprimento, tamanho_largura, cheiro_ferida, pele_ao_redor, febre, dor, observacao, paciente_id)
VALUES
  ('2025-05-05','Em granulação', 3.2, 1.8, FALSE, 'Leve eritema', FALSE, 2, 'Melhora na cicatrização', 1),
  ('2025-05-06','Estável'      , 5.0, 4.5, FALSE, 'Pele íntegra' , FALSE, 4, 'Desconforto ao mover'   , 2);

-- 2.5) Histórico
INSERT INTO historico 
  (data_abertura, tipo_ferida, localizacao_corpo, historico_medico, exsudato, remedios, frequencia_cuidados, sintomas, observacao_paciente, paciente_id, agente_id)
VALUES
  ('2025-04-28','Úlcera neuropática','Pé direito','Neuropatia periférica', TRUE , 'Curativo diário', 1, 'Formigamento', 'Usa calçados ortopédicos', 1, 1),
  ('2025-04-29','Úlcera por pressão','Região lombar','Imobilidade', FALSE, 'Curativo 48h'   , 0.5, 'Queimação' , 'Mudança de decúbito',      2, 2);

-- 2.6) Avaliação do Histórico
INSERT INTO avaliacao_historico 
  (avaliacao, observacao_paciente, paciente_id, agente_id, historico_id, formulario1_id, formulario2_id)
VALUES
  (4.8,'Continue protocolo atual'     , 1,1,1,1,1),
  (3.5,'Reavaliar em 3 dias'          , 2,2,2,2,2);
