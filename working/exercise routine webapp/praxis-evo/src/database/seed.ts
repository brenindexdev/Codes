import { db } from './db';

let isSeeding = false;

export async function seedDatabase() {
  if (isSeeding) return;
  isSeeding = true;

  const profileCount = await db.userProfile.count();
  if (profileCount > 0) return; // banco semeado

  // Perfil Inicial
  await db.userProfile.add({
    height: 172, initialWeight: 50, currentWeight: 50, age: 19, startDate: '2026-09-15'
  });

  // Estágios
  const stages = [
    { name: 'INICIANTE', startDate: '2026-09-15', endDate: '2026-10-19', order: 1 },
    { name: 'FÁCIL', startDate: '2026-10-20', endDate: '2026-12-07', order: 2 },
    { name: 'MÉDIO', startDate: '2026-12-08', endDate: '2027-02-01', order: 3 },
    { name: 'DIFÍCIL', startDate: '2027-02-02', endDate: '2027-04-12', order: 4 },
    { name: 'EXPERIENTE', startDate: '2027-04-13', endDate: '2027-06-21', order: 5 }
  ];
  const stageIds = await Promise.all(stages.map(s => db.stages.add(s)));

  // Dias de Treino para todos os estágios (3 = Terça, 5 = Quinta, 7 = Sábado)
  const days = [];
  for (let i = 0; i < 5; i++) {
    days.push({ stageId: stageIds[i], dayOfWeek: 3, name: 'SUPERIOR A', focus: 'Foco em Superiores e Core' });
    days.push({ stageId: stageIds[i], dayOfWeek: 5, name: 'INFERIORES', focus: 'Foco em Pernas e Core' });
    days.push({ stageId: stageIds[i], dayOfWeek: 7, name: 'SUPERIOR B', focus: 'Foco em Costas, Bíceps e Ombros' });
  }
  const dayIds = await Promise.all(days.map(d => db.workoutDays.add(d)));

  // Cadastro de TODOS os exercícios necessários até o Estágio 5
  const exData = [
    { name: 'Flexão de Braços', equipment: 'Corporal', instructions: 'Corpo reto, peito no chão.' }, // 1 (exIds[0])
    { name: 'Remada Unilateral', equipment: 'Halteres', instructions: 'Apoiar mão, puxar halter.' }, // 2
    { name: 'Pike Push-up', equipment: 'Corporal', instructions: 'V invertido.' }, // 3
    { name: 'Rosca Direta', equipment: 'Halteres', instructions: 'Subir sem balançar o tronco.' }, // 4
    { name: 'Tríceps Acima da Cabeça', equipment: 'Halteres', instructions: 'Halter atrás da cabeça.' }, // 5
    { name: 'Prancha', equipment: 'Corporal', instructions: 'Contrair abdômen.' }, // 6
    { name: 'Agachamento Livre', equipment: 'Corporal', instructions: 'Descer controladamente.' }, // 7
    { name: 'Afundo Reverso', equipment: 'Corporal', instructions: 'Passo para trás.' }, // 8
    { name: 'Romanian Deadlift (RDL)', equipment: 'Barra', instructions: 'Quadril para trás.' }, // 9
    { name: 'Panturrilha em Pé', equipment: 'Corporal', instructions: 'Ponta dos pés.' }, // 10
    { name: 'Dead Bug', equipment: 'Corporal', instructions: 'Costas no chão, braços e pernas opostos.' }, // 11
    { name: 'Remada com Barra', equipment: 'Barra', instructions: 'Puxar barra no abdômen.' }, // 12
    { name: 'Elevação Lateral', equipment: 'Halteres', instructions: 'Até a linha do ombro.' }, // 13
    { name: 'Rosca Martelo', equipment: 'Halteres', instructions: 'Pegada neutra.' }, // 14
    { name: 'Prancha Lateral', equipment: 'Corporal', instructions: 'Apoio lateral.' }, // 15
    { name: 'Desenvolvimento', equipment: 'Halteres', instructions: 'Empurrar acima da cabeça.' }, // 16
    { name: 'Flexão Declinada', equipment: 'Corporal', instructions: 'Pés elevados.' }, // 17
    { name: 'Flexão Fechada', equipment: 'Corporal', instructions: 'Mãos juntas, foco no tríceps.' }, // 18
    { name: 'Agachamento com Barra', equipment: 'Barra', instructions: 'Barra nas costas.' }, // 19
    { name: 'Elevação de Pernas', equipment: 'Corporal', instructions: 'Deitado ou pendurado.' }, // 20
    { name: 'Rosca com Barra', equipment: 'Barra', instructions: 'Flexão de cotovelos.' }, // 21
    { name: 'Flexão Avançada', equipment: 'Corporal', instructions: 'Variação arqueiro ou similar.' }, // 22
    { name: 'Pike Push-up Avançada', equipment: 'Corporal', instructions: 'Pés mais altos.' }, // 23
    { name: 'Core', equipment: 'Corporal', instructions: 'Exercícios livres de abdômen.' }, // 24
    { name: 'Afundo Búlgaro', equipment: 'Corporal/Halteres', instructions: 'Pé traseiro elevado.' }, // 25
    { name: 'Pistol Squat (Progressão)', equipment: 'Corporal', instructions: 'Agachamento unilateral.' }, // 26
    { name: 'Panturrilha Unilateral', equipment: 'Corporal/Halteres', instructions: 'Uma perna por vez.' } // 27
  ];
  const exIds = await Promise.all(exData.map(e => db.exercises.add(e)));

  // Helper para criar exercícios do treino mais facilmente
  const addWOs = async (dayIdIndex: number, workouts: any[]) => {
    await db.workoutExercises.bulkAdd(
      workouts.map((w, index) => ({
        workoutDayId: dayIds[dayIdIndex], exerciseId: exIds[w.exIndex], order: index + 1,
        sets: w.s, minReps: w.min, maxReps: w.max, targetWeight: w.w, restSeconds: w.r || 60
      }))
    );
  };

  // ESTÁGIO 1 - INICIANTE
  await addWOs(0, [{ exIndex: 0, s: 3, min: 6, max: 12, w: 0, r: 90 }, { exIndex: 1, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 2, s: 2, min: 5, max: 10, w: 0, r: 90 }, { exIndex: 3, s: 2, min: 10, max: 15, w: 3 }, { exIndex: 4, s: 2, min: 10, max: 15, w: 3 }, { exIndex: 5, s: 2, min: 20, max: 40, w: 0, r: 45 }]);
  await addWOs(1, [{ exIndex: 6, s: 3, min: 10, max: 15, w: 0, r: 90 }, { exIndex: 7, s: 2, min: 8, max: 12, w: 0 }, { exIndex: 8, s: 3, min: 10, max: 12, w: 6, r: 90 }, { exIndex: 9, s: 3, min: 15, max: 20, w: 0 }, { exIndex: 10, s: 2, min: 8, max: 12, w: 0, r: 45 }]);
  await addWOs(2, [{ exIndex: 0, s: 3, min: 6, max: 12, w: 0, r: 90 }, { exIndex: 11, s: 3, min: 8, max: 12, w: 6, r: 90 }, { exIndex: 12, s: 2, min: 12, max: 15, w: 3 }, { exIndex: 13, s: 2, min: 10, max: 15, w: 3 }, { exIndex: 4, s: 2, min: 10, max: 15, w: 3 }, { exIndex: 14, s: 2, min: 20, max: 30, w: 0, r: 45 }]);

  // ESTÁGIO 2 - FÁCIL
  await addWOs(3, [{ exIndex: 0, s: 3, min: 8, max: 15, w: 0, r: 90 }, { exIndex: 1, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 2, s: 3, min: 6, max: 12, w: 0, r: 90 }, { exIndex: 12, s: 3, min: 12, max: 15, w: 3 }, { exIndex: 3, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 5, s: 3, min: 30, max: 45, w: 0, r: 45 }]);
  await addWOs(4, [{ exIndex: 6, s: 3, min: 12, max: 15, w: 0, r: 90 }, { exIndex: 7, s: 3, min: 10, max: 12, w: 0 }, { exIndex: 8, s: 3, min: 10, max: 15, w: 8, r: 90 }, { exIndex: 9, s: 3, min: 15, max: 20, w: 0 }, { exIndex: 10, s: 3, min: 10, max: 12, w: 0, r: 45 }]);
  await addWOs(5, [{ exIndex: 0, s: 3, min: 8, max: 15, w: 0, r: 90 }, { exIndex: 11, s: 3, min: 10, max: 15, w: 8, r: 90 }, { exIndex: 15, s: 3, min: 8, max: 12, w: 3 }, { exIndex: 13, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 4, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 14, s: 3, min: 25, max: 40, w: 0, r: 45 }]);

  // ESTÁGIO 3 - MÉDIO
  await addWOs(6, [{ exIndex: 16, s: 3, min: 8, max: 12, w: 0, r: 90 }, { exIndex: 11, s: 4, min: 8, max: 12, w: 10, r: 90 }, { exIndex: 2, s: 3, min: 8, max: 12, w: 0 }, { exIndex: 17, s: 3, min: 8, max: 12, w: 0 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }, { exIndex: 5, s: 3, min: 40, max: 60, w: 0, r: 45 }]);
  await addWOs(7, [{ exIndex: 18, s: 4, min: 8, max: 12, w: 10, r: 90 }, { exIndex: 8, s: 3, min: 8, max: 12, w: 12, r: 90 }, { exIndex: 7, s: 3, min: 10, max: 12, w: 3 }, { exIndex: 9, s: 4, min: 15, max: 20, w: 0 }, { exIndex: 19, s: 3, min: 8, max: 15, w: 0, r: 45 }]);
  await addWOs(8, [{ exIndex: 11, s: 4, min: 8, max: 12, w: 10, r: 90 }, { exIndex: 0, s: 3, min: 10, max: 15, w: 0, r: 90 }, { exIndex: 15, s: 3, min: 8, max: 12, w: 3 }, { exIndex: 20, s: 3, min: 8, max: 12, w: 8 }, { exIndex: 4, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }]);

  // ESTÁGIO 4 - DIFÍCIL
  await addWOs(9, [{ exIndex: 16, s: 4, min: 8, max: 15, w: 0, r: 90 }, { exIndex: 11, s: 4, min: 8, max: 12, w: 14, r: 90 }, { exIndex: 2, s: 4, min: 8, max: 12, w: 0 }, { exIndex: 17, s: 3, min: 8, max: 15, w: 0 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }, { exIndex: 5, s: 3, min: 45, max: 60, w: 0, r: 45 }]);
  await addWOs(10, [{ exIndex: 18, s: 4, min: 8, max: 12, w: 14, r: 90 }, { exIndex: 8, s: 4, min: 8, max: 12, w: 14, r: 90 }, { exIndex: 7, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 9, s: 4, min: 15, max: 25, w: 3 }, { exIndex: 19, s: 3, min: 10, max: 15, w: 0, r: 45 }, { exIndex: 14, s: 2, min: 40, max: 60, w: 0, r: 45 }]);
  await addWOs(11, [{ exIndex: 11, s: 4, min: 8, max: 12, w: 14, r: 90 }, { exIndex: 16, s: 4, min: 8, max: 12, w: 0, r: 90 }, { exIndex: 15, s: 3, min: 8, max: 12, w: 3 }, { exIndex: 20, s: 3, min: 8, max: 12, w: 10 }, { exIndex: 4, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }]);

  // ESTÁGIO 5 - EXPERIENTE
  await addWOs(12, [{ exIndex: 21, s: 4, min: 6, max: 12, w: 0, r: 90 }, { exIndex: 11, s: 4, min: 8, max: 12, w: 16, r: 90 }, { exIndex: 22, s: 4, min: 6, max: 10, w: 0 }, { exIndex: 17, s: 3, min: 8, max: 15, w: 0 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }, { exIndex: 23, s: 3, min: 30, max: 60, w: 0, r: 45 }]);
  await addWOs(13, [{ exIndex: 18, s: 4, min: 8, max: 12, w: 16, r: 90 }, { exIndex: 8, s: 4, min: 8, max: 12, w: 16, r: 90 }, { exIndex: 24, s: 3, min: 8, max: 12, w: 3 }, { exIndex: 25, s: 3, min: 5, max: 10, w: 0 }, { exIndex: 26, s: 3, min: 15, max: 25, w: 3 }, { exIndex: 19, s: 3, min: 10, max: 15, w: 0, r: 45 }]);
  await addWOs(14, [{ exIndex: 11, s: 4, min: 8, max: 12, w: 16, r: 90 }, { exIndex: 21, s: 4, min: 6, max: 12, w: 0, r: 90 }, { exIndex: 15, s: 3, min: 8, max: 12, w: 3 }, { exIndex: 20, s: 3, min: 8, max: 12, w: 10 }, { exIndex: 4, s: 3, min: 10, max: 15, w: 3 }, { exIndex: 12, s: 3, min: 12, max: 20, w: 3 }]);
}