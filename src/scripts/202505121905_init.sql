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