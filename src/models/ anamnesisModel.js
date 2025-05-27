const db = require('../db/connection');

const Anamnesis = {
  findAll: async () => {
    const result = await db.query(`
      SELECT 
        id,
        data_de_conclusao,
        foto,
        tipo_ferida,
        localizacao_corpo,
        tamanho_comprimento,
        tamanho_largura,
        exsudato,
        historico_medico,
        remedios,
        febre,
        sintomas,
        observacao_paciente,
        frequencia_cuidados,
        patient_id,
        agent_id
      FROM anamnesis
    `);
    return result.rows;
  },

  findById: async (id) => {
    const result = await db.query(`
      SELECT 
        id,
        data_de_conclusao,
        foto,
        tipo_ferida,
        localizacao_corpo,
        tamanho_comprimento,
        tamanho_largura,
        exsudato,
        historico_medico,
        remedios,
        febre,
        sintomas,
        observacao_paciente,
        frequencia_cuidados,
        patient_id,
        agent_id
      FROM anamnesis
      WHERE id = $1
    `, [id]);
    return result.rows[0];
  },

  create: async (data) => {
    const query = `
      INSERT INTO anamnesis (
        data_de_conclusao, foto, tipo_ferida, localizacao_corpo,
        tamanho_comprimento, tamanho_largura, exsudato, historico_medico,
        remedios, febre, sintomas, observacao_paciente, frequencia_cuidados,
        patient_id, agent_id
      ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)
      RETURNING *`;
    
    const values = [
      data.data_de_conclusao,
      data.foto,
      data.tipo_ferida,
      data.localizacao_corpo,
      data.tamanho_comprimento,
      data.tamanho_largura,
      data.exsudato,
      data.historico_medico,
      data.remedios,
      data.febre,
      data.sintomas,
      data.observacao_paciente,
      data.frequencia_cuidados,
      data.patient_id,
      data.agent_id
    ];

    const result = await db.query(query, values);
    return result.rows[0];
  },

  update: async (id, data) => {
    const query = `
      UPDATE anamnesis SET 
        data_de_conclusao = $1,
        foto = $2,
        tipo_ferida = $3,
        localizacao_corpo = $4,
        tamanho_comprimento = $5,
        tamanho_largura = $6,
        exsudato = $7,
        historico_medico = $8,
        remedios = $9,
        febre = $10,
        sintomas = $11,
        observacao_paciente = $12,
        frequencia_cuidados = $13,
        patient_id = $14,
        agent_id = $15
      WHERE id = $16
      RETURNING *`;
    
    const values = [
      data.data_de_conclusao,
      data.foto,
      data.tipo_ferida,
      data.localizacao_corpo,
      data.tamanho_comprimento,
      data.tamanho_largura,
      data.exsudato,
      data.historico_medico,
      data.remedios,
      data.febre,
      data.sintomas,
      data.observacao_paciente,
      data.frequencia_cuidados,
      data.patient_id,
      data.agent_id,
      id
    ];

    const result = await db.query(query, values);
    return result.rows[0];
  },

  delete: async (id) => {
    await db.query('DELETE FROM anamnesis WHERE id = $1', [id]);
  }
};

module.exports = Anamnesis;
