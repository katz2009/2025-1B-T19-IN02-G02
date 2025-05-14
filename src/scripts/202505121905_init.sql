CREATE TABLE IF NOT EXISTS agente (
    id SERIAL PRIMARY KEY, -- Identificador único
    nome VARCHAR (100) NOT NULL, -- Nome 
    profissao VARCHAR (100) NOT NULL, -- Profissão do agente de saúde
    unidade_atendimento VARCHAR (100) NOT NULL, -- UBS de atendimento
    telefone VARCHAR (20) NOT NULL -- Contato
);

CREATE TABLE IF NOT EXISTS paciente ( -- preenchido pelo agente de saúde
    id SERIAL PRIMARY KEY,
    nome VARCHAR (100) NOT NULL,
    data_nascimento DATE NOT NULL, -- data de nascimento
    diabetico BOOLEAN NOT NULL, -- booleano atribui valores de "verdadeiro ou falso" que aplicado no nosso contexto pode ser sim ou não
    necessidade_resp BOOLEAN NOT NULL,
    nome_resp VARCHAR (100), -- opcional responder, já que depende do necessidade_resp
    condicao VARCHAR (200) NOT NULL,
    telefone VARCHAR (20) NOT NULL,
    telefone_resp VARCHAR (20), -- opcional responder, já que depende do necessidade_resp
    agente_id INT, -- chave estrangeira que permite que o agente tenha acesso as informações dessa tabela
    FOREIGN KEY (agente_id) REFERENCES agente(id) 
);

CREATE TABLE IF NOT EXISTS formulario1 ( -- preenchido pelo paciente (confirmação do prontuário)
    id SERIAL PRIMARY KEY,
    data_preenchimento DATE NOT NULL,
    tipo_ferida VARCHAR (100) NOT NULL,
    localizacao_corpo VARCHAR (100) NOT NULL,
    tamanho_comprimento NUMERIC NOT NULL, -- o tamnho é um número, não precisa de letras e poupa armazenamento
    tamanho_largura NUMERIC NOT NULL,
    exsudato BOOLEAN NOT NULL,
    historico_medico VARCHAR (500) NOT NULL,
    remedios VARCHAR (500) NOT NULL,
    sintomas VARCHAR (200) NOT NULL,
    paciente_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);

CREATE TABLE IF NOT EXISTS formulario2 ( -- preenchido pelo paciente
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

    
CREATE TABLE IF NOT EXISTS prontuario ( -- preenchimento pelo agente de saúde
    id SERIAL PRIMARY KEY,
    data_abertura DATE NOT NULL,
    tipo_ferida VARCHAR (100) NOT NULL,
    localizacao_corpo VARCHAR (100) NOT NULL,
    historico_medico VARCHAR (500) NOT NULL,
    remedios VARCHAR (500) NOT NULL,
    frequencia_cuidados NUMERIC NOT NULL,
    sintomas VARCHAR (200) NOT NULL,
    observacao_paciente VARCHAR (500),
    paciente_id INT,
    agente_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (agente_id) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS avaliacao_historico ( -- tabela que reúne as informações importantes
    id SERIAL PRIMARY KEY,
    avaliacao NUMERIC NOT NULL,
    observacao_paciente VARCHAR (500),
    formulario2_id INT,
    paciente_id INT,
    agente_id INT,
    prontuario_id INT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (agente_id) REFERENCES agente(id),
    FOREIGN KEY (prontuario_id) REFERENCES prontuario(id)
);