CREATE TABLE IF NOT EXISTS agente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR (100) NOT NULL,
    profissao VARCHAR (100) NOT NULL,
    unidade_atendimento VARCHAR (100) NOT NULL,
    telefone VARCHAR (20) NOT NULL
);

CREATE TABLE IF NOT EXISTS paciente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR (100) NOT NULL,
    data_nascimento DATE NOT NULL,
    diabetico BOOLEAN NOT NULL,
    necessidade_resp BOOLEAN NOT NULL,
    nome_resp VARCHAR (100),
    condicao VARCHAR (200) NOT NULL,
    telefone VARCHAR (20) NOT NULL,
    telefone_resp VARCHAR (20),
    agente_id INT,
    FOREIGN KEY (agente_id) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS formulario1 (
    id SERIAL PRIMARY KEY,
    data_preenchimento DATE NOT NULL,
    tipo_ferida VARCHAR (100) NOT NULL,
    localizacao_corpo VARCHAR (100) NOT NULL,
    tamanho_comprimento NUMERIC NOT NULL,
    tamanho_largura NUMERIC NOT NULL,
    exsudato BOOLEAN NOT NULL,
    historico_medico VARCHAR (500) NOT NULL,
    remedios VARCHAR (500) NOT NULL,
    sintomas VARCHAR (200) NOT NULL,
    paciente_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);

CREATE TABLE IF NOT EXISTS formulario2 (
    id SERIAL PRIMARY KEY,
    data_preenchimento DATE NOT NULL,
    status_ferida VARCHAR (100) NOT NULL,
    tamanho_comprimento NUMERIC NOT NULL,
    tamanho_largura NUMERIC NOT NULL,
    cheiro_ferida BOOLEAN NOT NULL,
    pele_ao_redor VARCHAR (100) NOT NULL,
    febre BOOLEAN NOT NULL,
    dor NUMERIC NOT NULL,
    observacao VARCHAR (300),
    paciente_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);

CREATE TABLE IF NOT EXISTS historico (
    id SERIAL PRIMARY KEY,
    data_abertura DATE NOT NULL,
    tipo_ferida VARCHAR (100) NOT NULL,
    localizacao_corpo VARCHAR (100) NOT NULL,
    historico_medico VARCHAR (500) NOT NULL,
    exsudato BOOLEAN NOT NULL,
    remedios VARCHAR (500) NOT NULL,
    frequencia_cuidados NUMERIC NOT NULL,
    sintomas VARCHAR (200) NOT NULL,
    observacao_paciente VARCHAR (500),
    paciente_id INT,
    agente_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (agente_id) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS avaliacao_historico (
    id SERIAL PRIMARY KEY,
    avaliacao NUMERIC NOT NULL,
    observacao_paciente VARCHAR (500),
    paciente_id INT,
    agente_id INT,
    historico_id INT,
    formulario1_id INT,
    formulario2_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (agente_id) REFERENCES agente(id),
    FOREIGN KEY (historico_id) REFERENCES historico(id),
    FOREIGN KEY (formulario1_id) REFERENCES formulario1(id),
    FOREIGN KEY (formulario2_id) REFERENCES formulario1(id)
);

INSERT INTO agente (nome, profissao, unidade_atendimento, telefone)
VALUES
('Carla Souza', 'Enfermeira', 'UBS Jardim Primavera', '(11) 99999-1234'),
('João Mendes', 'Técnico de Enfermagem', 'PSF São João', '(11) 98888-4567');

INSERT INTO paciente (nome, data_nascimento, diabetico, necessidade_resp, nome_resp, condicao, telefone, telefone_resp, agente_id)
VALUES
('Antônio da Silva', '1950-08-15', TRUE, TRUE, 'Maria da Silva', 'Ferida crônica na perna direita', '(11) 91111-2233', '(11) 92222-3344', 1),
('Lúcia Ferreira', '1975-04-30', FALSE, FALSE, NULL, 'Ferida por pressão nas costas', '(11) 93333-4455', NULL, 2);

INSERT INTO formulario1 (data_preenchimento, tipo_ferida, localizacao_corpo, tamanho_comprimento, tamanho_largura, exsudato, historico_medico, remedios, sintomas, paciente_id)
VALUES
('2025-05-10', 'Úlcera venosa', 'Perna direita', 5.5, 3.2, TRUE, 'Hipertensão, diabetes tipo 2', 'Metformina, Captopril', 'Dor leve, secreção amarelada', 1),
('2025-05-11', 'Ferida por pressão', 'Região lombar', 6.0, 4.0, FALSE, 'Imobilidade prolongada, obesidade', 'Dipirona', 'Coceira e vermelhidão', 2);

INSERT INTO formulario2 (data_preenchimento, status_ferida, tamanho_comprimento, tamanho_largura, cheiro_ferida, pele_ao_redor, febre, dor, observacao, paciente_id)
VALUES
('2025-05-12', 'Em cicatrização', 5.2, 3.1, FALSE, 'Sem vermelhidão', FALSE, 3, 'Paciente colaborativo com o tratamento', 1),
('2025-05-13', 'Estável', 6.0, 4.0, FALSE, 'Levemente irritada', FALSE, 4, 'Sem evolução nos últimos dias', 2);

INSERT INTO historico (data_abertura, tipo_ferida, localizacao_corpo, historico_medico, exsudato, remedios, frequencia_cuidados, sintomas, observacao_paciente, paciente_id, agente_id)
VALUES
('2025-04-20', 'Úlcera venosa', 'Perna direita', 'Hipertensão, diabetes tipo 2', TRUE, 'Metformina, Captopril', 3, 'Dor ao caminhar, secreção moderada', 'Paciente usa meias compressivas', 1, 1),
('2025-04-22', 'Ferida por pressão', 'Região lombar', 'Imobilidade, obesidade', FALSE, 'Dipirona', 2, 'Sensação de queimação ao deitar', 'Paciente em cadeira de rodas', 2, 2);

INSERT INTO avaliacao_historico (avaliacao, observacao_paciente, paciente_id, agente_id, historico_id, formulario1_id, formulario2_id)
VALUES
(4.5, 'Ferida apresentando melhora significativa', 1, 1, 1, 1, 1),
(3.0, 'Pouca evolução, mas sem piora', 2, 2, 2, 2, 2);